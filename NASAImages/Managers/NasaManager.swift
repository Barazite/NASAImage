//
//  NasaManager.swift
//  NASAImages
//
//  Created by Adrian Sevilla Diaz on 14/4/22.
//.replacingOccurrences(of: " ", with: "")

import Foundation
import UIKit

protocol NasaManagerProtocol {
    func fetchNasa(page: String, search: String) async throws -> NasaServerModel
}

class NasaManager: NasaManagerProtocol {
    let baseNasaURL = "https://images-api.nasa.gov/search?q=%@&page=%@"
    
    func fetchNasa(page: String, search: String) async throws -> NasaServerModel{
        let aux: [CVarArg] = [search, page]
        let endpoint = String(format: self.baseNasaURL, arguments: aux)
        
        let (data, response) = try await URLSession.shared.data(from: URL(string: endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        
        guard let httpResponse = response as? HTTPURLResponse else{
            throw ErrorTest.test
        }
        if (200...299).contains(httpResponse.statusCode){
            do{
                let serverModel = try JSONDecoder().decode(NasaServerModel.self, from: data)
                return serverModel
            }catch{
                throw ErrorTest.test
            }
        }else{
            throw ErrorTest.test        }
    }
    
    func fetchPhoto(url: URL) async throws -> UIImage {
        if let cache = URLCache.shared.cachedResponse(for: URLRequest(url: url))?.data, let img = UIImage(data: cache){
            return img
        }else{
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw ErrorTest.test
            }
            
            guard let image = UIImage(data: data) else {
                throw ErrorTest.test
            }
            let cacheData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cacheData, for: URLRequest(url: url))
            return image
        }
    }
}
