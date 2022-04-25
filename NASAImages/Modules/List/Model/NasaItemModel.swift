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
    let description: String?
    let urlImage: String?
    
    init(businessModel: Item){
        self.title = businessModel.data?.first?.title
        self.location = businessModel.data?.first?.location
        self.date = businessModel.data?.first?.dateCreated
        self.description = businessModel.data?.first?.description508
        self.urlImage = businessModel.links?.first?.href
    }
}
