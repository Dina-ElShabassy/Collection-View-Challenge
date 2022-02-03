//
//  ProductsViewController.swift
//  Collection View Challenge
//
//  Created by Dina ElShabassy on 1/29/22.
//  Copyright © 2022 Dina_ElShabassy. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController{

    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var networkModel : NetworkModel = NetworkModel()
    var productsArray = [Products]()
    var isFetching = false
    var fileManager : FileManagerModel = FileManagerModel()
    var isConnectedToWifi : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkConnectivity()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getDataFromFileManager(_:)), name: .internetNotification, object: nil)
        
        //delegates
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.prefetchDataSource = self
        productsCollectionView.isPrefetchingEnabled = true
        
        //set this view as the delegate for the layout
        if let layout = productsCollectionView?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }
        
    }
    
    @objc func getDataFromFileManager(_ notification : Notification) {
        if let data = notification.userInfo{
         let isConnected : Bool = data["isConnected"]! as! Bool
            isConnectedToWifi = isConnected
         if !isConnected{
            productsArray = fileManager.readArrayOfProducts()
            
         }else{
            //fetch data
            fetchData()
            }
         DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
         }
        
      }
    }

}
