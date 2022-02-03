//
//  ProductDetailsViewController.swift
//  Collection View Challenge
//
//  Created by Dina ElShabassy on 2/2/22.
//  Copyright © 2022 Dina_ElShabassy. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    
    var productImg : UIImage?
    var productDesc : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productImage.image = productImg
        productDescription.text = productDesc

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
