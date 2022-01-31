//
//  ProductViewController+Methods.swift
//  Collection View Challenge
//
//  Created by Dina ElShabassy on 1/30/22.
//  Copyright © 2022 Dina_ElShabassy. All rights reserved.
//

import Foundation
import UIKit

extension ProductsViewController {
    
    func fetchData(){
        isFetching = true
        networkModel.fetchProductsFromAPI { (products) in
            guard let result = products else{ return }
            self.productsArray.append(contentsOf: result)
            
            // add data to file manager for offline storage
            self.fileManager.saveArrayOfProducts(productsArray: self.productsArray)
            
            DispatchQueue.main.async{
                self.productsCollectionView.reloadData()
            }
            self.isFetching = false
        }
    }
    
    func collectionViewFlowLayout(){
        if let layout = productsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                let size = CGSize(width:(productsCollectionView!.bounds.width-30)/2, height: 292)
                layout.itemSize = size
        }
    }
    
    func checkConnectivity(){
        if NetworkMonitor.shared.isConnected{
            isConnectedToWifi = true
            fetchData()
        }else{
            isConnectedToWifi = false
            productsArray = fileManager.readArrayOfProducts()
        }
    }
    
}
