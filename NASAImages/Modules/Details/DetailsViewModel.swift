//
//  DetailsViewModel.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 27/4/22.
//

import Foundation

protocol DetailsViewModelProtocol{
    func getItem() -> NasaItem
    func saveItem()
    func checkFav() -> Bool
    func deleteItem()
}

class DetailsViewModel{
    
    var item : NasaItem
    var fav : Bool
    var detailsViewController : DetailsViewController
    var coreManager : CoreDataManagerProtocol
    
    init(itemNasa: NasaItem, vc: DetailsViewController, favCheck: Bool = false) {
        self.item = itemNasa
        self.detailsViewController = vc
        self.coreManager = CoreDataManager()
        if favCheck{
            self.fav = favCheck
        }else{
            self.fav = coreManager.checkItem(item: self.item)
        }
    }
}

extension DetailsViewModel: DetailsViewModelProtocol{
    
    func getItem() -> NasaItem {
        self.item
    }
    
    func saveItem(){
        coreManager.saveItem(item: self.item){
            self.fav = true
            self.detailsViewController.configButtonFav()
            self.detailsViewController.showToast(message: "Guardado", seconds: 4.0)
        }failure: {
            self.detailsViewController.alertView(description: "Error al guardar")
        }
                    
    }
    
    func checkFav() -> Bool{
        self.fav
    }
    
    func deleteItem(){
        if coreManager.deleteItem(item: self.item){
            self.fav = false
            self.detailsViewController.configButtonFav()
            self.detailsViewController.showToast(message: "Eliminado", seconds: 4.0)
        }else{
            self.detailsViewController.alertView(description: "Error al eliminar")
        }
    }
}
