//
//  ViewController.swift
//  Pagination
//
//  Created by Ravi Dwivedi on 14/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var tableView:UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        return tableView
    }()
    
    var data = [String]()
    
    var apiCaller = APICaller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.addSubview(tableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        setTableViewData()
        
    }
    
    private func setUI(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setTableViewData(){
        apiCaller.fetchData(isPagination: false) { [weak self] result in
            guard let self = self else { return}
            switch result{
            case .success(let data):
                self.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK:- TableView Data Source
extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    private func createFooterView() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let activityView = UIActivityIndicatorView()
        activityView.center = footerView.center
        footerView.addSubview(activityView)
        activityView.startAnimating()
        return footerView
    }
}

//MARK:- TableView Delegate
extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- ScrollView Delegate
extension ViewController:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let positon = scrollView.contentOffset.y
        
        if  positon > (self.tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            guard !apiCaller.isPaginating else {return}
            DispatchQueue.main.async {
                self.tableView.tableFooterView = self.createFooterView()
            }
            
            apiCaller.fetchData(isPagination: true) {[weak self] result in
                
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
                
                switch result{
                case .success(let data):
                    self.data.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
                
            }
        }
    }
}
