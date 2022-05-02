//
//  String.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 2/5/22.
//

import Foundation

extension String{
    
    func convertDate() -> String{
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let fromDateObject = fromDateFormatter.date(from: self){
            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = "yyyy-MM-dd"
            
            let newDateString = toDateFormatter.string(from: fromDateObject)
            return newDateString
        }
        
        return self
    }
}
