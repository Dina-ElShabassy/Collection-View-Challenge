//
//  ProductsViewController+CollectionView.swift
//  Collection View Challenge
//
//  Created by Dina ElShabassy on 1/29/22.
//  Copyright © 2022 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit

extension ProductsViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductCollectionViewCell
        
        cell?.productPrice.text = "\(productsArray[indexPath.row].price)$"
        cell?.productDescription.text = productsArray[indexPath.row].productDescription
        
        ImageDownloader.shared.downloadImage(with: productsArray[indexPath.row].image.url, completionHandler: { (image, cached) in

            cell?.productImage.image = image

        }, placeholderImage: UIImage(named: "placeholder_profile_pic"))
        
        return cell!
    }
    
    
}
