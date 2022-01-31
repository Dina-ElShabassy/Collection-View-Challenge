//
//  FileManagerModel.swift
//  Collection View Challenge
//
//  Created by Dina ElShabassy on 1/31/22.
//  Copyright © 2022 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit

class FileManagerModel{
    
    var products : [Products] = []

    struct SavedData: Codable {
        let products: [Products]

    }

    private let manager = FileManager.default
    private var filePath : URL!
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func documentDirectoryPath() -> URL? {
        let basepath = manager.urls(for: .documentDirectory,
            in: .userDomainMask).first
        
        return basepath
    }
    
    func saveArrayOfProducts(productsArray : [Products]){
        
        do {
            let filePath = (documentDirectoryPath()?.appendingPathComponent("SavedProducts"))!
            let savedData = SavedData(products: productsArray)
            let data = try encoder.encode(savedData)
            try data.write(to: filePath, options: .atomicWrite)
        } catch let error {
            print("Error while saving datas: \(error.localizedDescription)")
        }
        encoder.dataEncodingStrategy = .base64
        
    }
    
    func readArrayOfProducts() -> [Products] {
        
        do {
            if let filePath = documentDirectoryPath()?.appendingPathComponent("SavedProducts"){
                if let data = try? Data(contentsOf: filePath) {
                    decoder.dataDecodingStrategy = .base64
                 let savedData = try decoder.decode(SavedData.self, from: data)
                    self.products = savedData.products
                }
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
        return products
    }
    
}
