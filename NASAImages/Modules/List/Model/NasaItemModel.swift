//
//  NasaItemModel.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 20/4/22.
//

import Foundation
import UIKit

struct NasaItem{
    let title: String?
    let location: String?
    let date: String?
    let descriptionNasa: String?
    let urlImage: String?
    
    init(businessModel: Item){
        self.title = businessModel.data?.first?.title
        self.location = businessModel.data?.first?.location
        self.date = businessModel.data?.first?.dateCreated?.convertDate()
        self.descriptionNasa = businessModel.data?.first?.datumDescription?.replacingOccurrences(of: "  ", with: "\n\n")
        self.urlImage = businessModel.links?.first?.href
    }
    
    init(localItem: NasaItemCoreData){
        self.title = localItem.title
        self.location = localItem.location
        self.date = localItem.date
        self.descriptionNasa = localItem.descriptionNasa
        self.urlImage = localItem.urlImage
    }
}
