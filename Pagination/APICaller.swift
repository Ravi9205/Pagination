//
//  APICaller.swift
//  Pagination
//
//  Created by Ravi Dwivedi on 14/04/23.
//

import Foundation



class APICaller {
    
    public var isPaginating = false
    
    
    func fetchData(isPagination:Bool = false,completion:@escaping(Result<[String],Error>)->Void){
        
        DispatchQueue.global().asyncAfter(deadline: .now()+(isPagination ? 3: 2)) {
            if isPagination {
                self.isPaginating = true
            }
            
            let  paginationData:[String] = [ "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix",
                                             "Apple",
                                             "Google",
                                             "Facebook",
                                             "Netflix"
                                             
                                             
            ]
            
            let newData:[String] = [ "Banana",
                                     "Grapes",
                                     "Nuts",
                                     "Dates",
                                     "Mango"
                                     
                                     
            ]
            
            completion(.success(isPagination ? newData:paginationData))
            
            if isPagination {
                self.isPaginating = false
            }
        }
    }
}
