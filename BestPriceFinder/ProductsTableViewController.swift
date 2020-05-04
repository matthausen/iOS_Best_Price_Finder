//
//  ProductsTableViewController.swift
//  BestPriceFinder
//
//  Created by Matteo Fusilli on 25/04/2020.
//  Copyright © 2020 Matteo Fusilli. All rights reserved.
//
// TODO:
// - Display image in cell, change style for labels
// - Improve detailView
// - Logo for iOS App
// - Add Amazon API
//

import UIKit

class ProductsTableViewController: UITableViewController, UISearchBarDelegate{

    var itemsData = [Item]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var ItemsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query:String = searchBar.text!
        fetchEbayItems(query: query)
    }
    
    func fetchEbayItems(query: String) {
        EBayResponse.findItem(query: query) { (item) in
            DispatchQueue.main.async {
                self.itemsData = item as! [Item]
                self.tableView.reloadData()
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemsData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! ItemTableViewCell

        let itemObject = itemsData[indexPath.section]
        
        let url = URL(string: itemObject.galleryURL[0])

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.imageCell.image = UIImage(data: data!)
            }
        }
        
        
        cell.titleCell?.text = itemObject.title[0]
        cell.subtitleCell?.text = "£ \(itemObject.sellingStatus[0].currentPrice[0].__value__)" 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductDetailsViewController {
            destination.product = itemsData[ItemsTable.indexPathForSelectedRow!.row]
        }
    }

}
