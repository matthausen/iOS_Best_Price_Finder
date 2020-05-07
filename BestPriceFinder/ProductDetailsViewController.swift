//
//  ProductDetailsViewController.swift
//  BestPriceFinder
//
//  Created by Matteo Fusilli on 03/05/2020.
//  Copyright © 2020 Matteo Fusilli. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productShippingInfo: UILabel!
    @IBOutlet weak var productCondition: UILabel!
    
    var product: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: (product?.galleryURL[0])!)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.productImage.image = UIImage(data: data!)
            }
        }
                
        productTitle.text = product?.title[0]
        productPrice.text = "GPB \(product?.sellingStatus[0].currentPrice[0].__value__)"
        productCondition.text = product?.condition[0].conditionDisplayName[0]
        productShippingInfo.text = "GBP \(product?.shippingInfo[0].shippingServiceCost[0].__value__)"

    }
    @IBAction func buyBtn(_ sender: Any) {
        UIApplication.shared.open(URL(string: (product?.viewItemURL[0])!)!, options: [:], completionHandler: nil)

    }
}
