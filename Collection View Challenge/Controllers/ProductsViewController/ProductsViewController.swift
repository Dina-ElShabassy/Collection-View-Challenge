//
//  ProductsViewController.swift
//  Collection View Challenge
//
//  Created by Dina ElShabassy on 1/29/22.
//  Copyright © 2022 Dina_ElShabassy. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var networkModel : NetworkModel = NetworkModel()
    var productsArray = [Products]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //delegates
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        //get products from api
        networkModel.fetchProductsFromAPI { (products) in
            self.productsArray = products
            DispatchQueue.main.async{
                self.productsCollectionView.reloadData()
            }
            
        }
        
    }

}
