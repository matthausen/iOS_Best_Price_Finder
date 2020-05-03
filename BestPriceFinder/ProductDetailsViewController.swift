//
//  ProductDetailsViewController.swift
//  BestPriceFinder
//
//  Created by Matteo Fusilli on 03/05/2020.
//  Copyright © 2020 Matteo Fusilli. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productTitle: UILabel!
    var product: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productTitle.text = "\(String(describing: product?.title))"
    }
}
