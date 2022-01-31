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
        let productId = productsArray[indexPath.row].id
        
        ImageDownloader.shared.downloadImage(with: imageUrl, completionHandler: { (image, cached) in

            cell?.productImage.image = image
            //self.fileManager.saveProductImage(productId: productId, image: image!)

        }, placeholderImage: UIImage(named: "placeholder_profile_pic"))
        
        return cell!
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

extension ProductsViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         // vertical spacing between items
         return 5
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         //horizental spacing between items
         return 5
      }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        
          let width = (collectionView.frame.width - 5 )/2
         return CGSize(width: width, height: width*1.5)
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
             return UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
         }
   
}
