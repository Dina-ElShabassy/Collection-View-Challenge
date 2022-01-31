//
//  NetworkModel.swift
//  Collection View Challenge
//
//  Created by Dina ElShabassy on 1/29/22.
//  Copyright © 2022 Dina_ElShabassy. All rights reserved.
//

import Foundation

class NetworkModel {
    
    func fetchProductsFromAPI(completion: @escaping ([Products]?) -> Void) -> Void{
        
        let url = URL(string: URLs.apiURL)!

        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let result = try? JSONDecoder().decode([Products].self, from: data) {
                    completion(result)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
}
