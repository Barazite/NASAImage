//
//  CoreDataManager.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 5/5/22.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func fetchLocalNasa() -> [NasaItem]
    func saveItem(item: NasaItem, completion: () -> Void, failure: () -> Void)
    func deleteItem(item: NasaItem) -> Bool
    func checkItem(item: NasaItem) -> Bool
}

class CoreDataManager: CoreDataManagerProtocol {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext : NSManagedObjectContext
    
    init(){
        self.managedContext = self.appDelegate.persistentContainer.viewContext
    }
    
    func convertData(item: NasaItem) -> NasaItemCoreData{
        let localItemNasa = NasaItemCoreData(context: self.managedContext)
        localItemNasa.title = item.title
        localItemNasa.location = item.location
        localItemNasa.date = item.date
        localItemNasa.descriptionNasa = item.descriptionNasa
        localItemNasa.urlImage = item.urlImage
        
        return localItemNasa
    }
    
    func fetchLocalNasa() -> [NasaItem] {
        let fetchRequest: NSFetchRequest<NasaItemCoreData> = NasaItemCoreData.fetchRequest()
        
        do{
            let result =  try managedContext.fetch(fetchRequest)
            let items = result.map({
                NasaItem(localItem: $0)
            })
            return items
        }catch{
            print("Error fetchLocalNasa")
        }
        return []
    }
    
    func saveItem(item: NasaItem, completion: () -> Void, failure: () -> Void){
        _ = convertData(item: item)
        
        do{
            try self.managedContext.save()
            print("Item guardado")
            completion()
        }catch{
            print("Error al guardar item")
            failure()
        }
        
    }
    
    func deleteItem(item: NasaItem) -> Bool{
        let fetchRequest: NSFetchRequest<NasaItemCoreData> = NasaItemCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "urlImage = %@", item.urlImage!)
        do{
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0{
                self.managedContext.delete(result.first!)
                try self.managedContext.save()
                print("Eliminado")
                return true
            }
        }catch{
            print("Error al eliminar")
            return false
        }
        return false
    }
    
    func checkItem(item: NasaItem) -> Bool{
        var check = false
        let fetchRequest: NSFetchRequest<NasaItemCoreData> = NasaItemCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "urlImage = %@", item.urlImage!)
        
        do{
            let checkingItem = try managedContext.fetch(fetchRequest)
            if checkingItem.count > 0{
                check = true
            }
        }catch{
            print("Error en Check")
        }
        
        return check
    }
    
}
