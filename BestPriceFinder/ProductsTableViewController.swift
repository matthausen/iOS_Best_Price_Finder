//
//  ProductsTableViewController.swift
//  BestPriceFinder
//
//  Created by Matteo Fusilli on 25/04/2020.
//  Copyright © 2020 Matteo Fusilli. All rights reserved.
//
// TODO:
// - Open new activity when clicking on Item object
// - Logo for iOS App
// - Add Amazon API
//

import UIKit

class ProductsTableViewController: UITableViewController, UISearchBarDelegate{

    var itemsData = [Item]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        return dateFormatter.string(from: date!)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        
        let itemObject = itemsData[indexPath.section]
                
        cell.textLabel?.text = itemObject.title[0]
        // cell.detailTextLabel?.text = "subtitle here"
        
        return cell
    }

}
