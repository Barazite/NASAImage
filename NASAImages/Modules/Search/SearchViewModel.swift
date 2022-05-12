//
//  SearchViewModel.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 13/4/22.
//

import Foundation

protocol SearchViewModelProtocol {
    func getNumberOfRow() -> Int
    func getItem(index: Int) -> String
}

class SearchViewModel{
    private let data = ["earth", "moon", "sun", "mars", "jupiter", "saturn", "apollo", "hubble"]
}

extension SearchViewModel: SearchViewModelProtocol{
    func getNumberOfRow() -> Int {
        self.data.count
    }
    
    func getItem(index: Int) -> String {
        self.data[index]
    }
    
    
}
