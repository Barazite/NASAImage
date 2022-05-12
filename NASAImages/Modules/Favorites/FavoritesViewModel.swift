//
//  FavoritesViewModel.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 5/5/22.
//

import Foundation

protocol FavoritesViewModelProtocol {
    func fetchData()
    func getNumberOfRow() -> Int
    func getItem(index: Int) -> NasaItem
}

class FavoritesViewModel{
    var data: [NasaItem] = []
    var favoritesViewController : FavoritesViewController
    
    init(vc: FavoritesViewController){
        self.favoritesViewController = vc
    }
}

extension FavoritesViewModel: FavoritesViewModelProtocol{
    func fetchData() {
        self.data = CoreDataManager().fetchLocalNasa()
        self.favoritesViewController.reloadData()
    }
    
    func getNumberOfRow() -> Int {
        self.data.count
    }
    
    func getItem(index: Int) -> NasaItem {
        self.data[index]
    }
}
