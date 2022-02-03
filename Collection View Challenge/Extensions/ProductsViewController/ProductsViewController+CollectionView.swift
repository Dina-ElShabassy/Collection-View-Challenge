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
        
        let imageUrl = productsArray[indexPath.row].image.url
        
        ImageDownloader.shared.downloadImage(with: imageUrl, completionHandler: { (image, cached) in

            cell?.productImage.image = image

        }, placeholderImage: UIImage(named: "placeholder_profile_pic"))
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productDetailsVC = storyboard?.instantiateViewController(identifier: "productDetails") as? ProductDetailsViewController
        
        let imageUrl = productsArray[indexPath.row].image.url
        
        ImageDownloader.shared.downloadImage(with: imageUrl, completionHandler: { (image, cached) in

            productDetailsVC?.productImg  = image

        }, placeholderImage: UIImage(named: "placeholder_profile_pic"))
        
        productDetailsVC?.productDesc = productsArray[indexPath.row].productDescription
        
        self.navigationController?.pushViewController(productDetailsVC!, animated: true)
        
    }
    
    
    
}

extension ProductsViewController : UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if self.isConnectedToWifi{
            for index in indexPaths{
                if index.row >= productsArray.count - 3 && !isFetching{
                    fetchData()
                    break
                }
           }
        }
    }
    
}

extension ProductsViewController : PinterestLayoutDelegate {
  func collectionView(
      _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    return CGFloat(productsArray[indexPath.row].image.height)
  }
}
