//
//  Product.swift
//  BestPriceFinder
//
//  Created by Matteo Fusilli on 25/04/2020.
//  Copyright © 2020 Matteo Fusilli. All rights reserved.
//

import Foundation

struct Price: Codable {
    let __value__: String
}

struct ShippingServiceCost: Codable {
    let shippingServiceCost: [Price]
}

struct SellingStatus: Codable {
    let currentPrice:[Price]
}

struct Condition: Codable {
    let conditionDisplayName: [String]
}

struct Item: Codable {
    let title: [String]
    let galleryURL: [String]
    let viewItemURL: [String]
    let shippingInfo: [ShippingServiceCost]
    let sellingStatus: [SellingStatus]
    let condition: [Condition]
}

struct SearchResult: Codable {
    let item: [Item]
}

struct KeyWordResponse: Codable {
   
    let searchResult: [SearchResult]
}

struct EBayResponse: Codable {
    
    let findItemsByKeywordsResponse: [KeyWordResponse]
    
    static let AppName = "MatteoFu-dashboar-PRD-61979435f-f81d2e44"
    static let country = "EBAY-GB"
    
    static func findItem(query: String, _ completion: @escaping (NSArray) -> ()) {
        let task = URLSession.shared.dataTask(with: URL(string: "https://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0&SECURITY-APPNAME=\(AppName)&RESPONSE-DATA-FORMAT=JSON&keywords=\(query)&X-EBAY-SOA-GLOBAL-ID=\(country)")!) {(data, response, error) in
            guard let data = data else {return}
            var itemsArray: [Item] = []
            do {
                let newJSONDecoder = JSONDecoder()
                let itemObject = try newJSONDecoder.decode(EBayResponse.self, from: data)
                let item = itemObject.findItemsByKeywordsResponse[0].searchResult[0].item
                for i in item {
                    itemsArray.append(i)
                }
            } catch {
                print("No results from the EBAY API")
            }
            completion(itemsArray as NSArray)
        }
        task.resume()
    }

}
