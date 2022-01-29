//
//  Products.swift
//  Collection View Challenge
//
//  Created by Dina ElShabassy on 1/30/22.
//  Copyright © 2022 Dina_ElShabassy. All rights reserved.
//

import Foundation

struct Products : Codable {
    
    let id : Int
    let productDescription : String
    let image : Image
    let price : Int
    
}

struct Image : Codable {
    
    let width : Int
    let height : Int
    let url : String
    
}
