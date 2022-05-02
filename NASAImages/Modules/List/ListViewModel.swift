//
//  ListViewModel.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 14/4/22.
//

import Foundation

protocol ListViewModelProtocol {
    func fetchData() async
    func getNumberOfRow() -> Int
    func getItem(index: Int) -> NasaItem
    func checkFinalList() -> Bool
    func getSearchText() -> String
}

class ListViewModel{
    var searchText : String
    var listViewController : ListViewController
    
    init(search: String, vc: ListViewController) {
        self.searchText = search
        self.listViewController = vc
    }
    
    var data : [NasaItem] = []
    var finalList = false
    var page = 1
    
}

extension ListViewModel: ListViewModelProtocol{
    
    func checkFinalList() -> Bool {
        self.finalList
    }
    
    func getSearchText() -> String{
        self.searchText.uppercased()
    }
    
    func fetchData() async{
        do{
            let dataServer = try await NasaManager().fetchNasa(page: "\(self.page)", search: self.searchText)
            guard let dataNasa = dataServer.collection?.items else {
                return
            }
            if dataNasa.count != 0{
                self.data.append(contentsOf: dataNasa.map{
                    NasaItem(businessModel: $0)
                })
                
                if self.data.count == dataServer.collection?.metadata?.totalHits{
                    self.finalList = true
                }else{
                    self.page += 1
                }
                await self.listViewController.reloadData()
            }else{
                await self.listViewController.emptyData()
            }
        }catch{
            print("Error")
            
        }
    }
    
    func getNumberOfRow() -> Int {
        self.data.count
    }
    
    func getItem(index: Int) -> NasaItem {
        self.data[index]
    }
}
