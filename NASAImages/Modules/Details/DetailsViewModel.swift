//
//  DetailsViewModel.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 27/4/22.
//

import Foundation

protocol DetailsViewModelProtocol{
    func getItem() -> NasaItem
}

class DetailsViewModel{
    
    var item : NasaItem
    var detailsViewController : DetailsViewController
    
    init(itemNasa: NasaItem, vc: DetailsViewController) {
        self.item = itemNasa
        self.detailsViewController = vc
    }
}

extension DetailsViewModel: DetailsViewModelProtocol{
    
    func getItem() -> NasaItem {
        self.item
    }
}
