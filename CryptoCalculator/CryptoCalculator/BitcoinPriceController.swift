//
//  File.swift
//  CryptoCalculator
//
//  Created by Bradley GIlmore on 5/22/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

class BitcoinPriceController {
    
    static let baseURL = URL(string: "https://coinmarketcap-nexuist.rhcloud.com/api/btc/price")
    
    //MARK: - FetchUSDDollarAmount Function
    
    static func fetchUSDollarAmount(completion: @escaping (_ responses: Bitcoin?) -> Void) {
        
        guard let usdURL = baseURL else { fatalError("USD/URL is nil") }
        
        NetworkController.performRequest(for: usdURL, httpMethod: .get, urlParameters: nil, body: nil) { (data, error) in
            
            guard let data = data else { return }
            
            guard error == nil else { print("Error: \(String(describing: error?.localizedDescription))"); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { completion(nil); return }
            
            guard let price = jsonDictionary["usd"] as? Double else { return }
            let priceString = String(price)

            let usdWallet = Bitcoin(bitcoinUSDAmount: priceString)
            print(usdWallet.bitcoinUSDAmount)
            
            
            completion(usdWallet)
            
        }
    }
}
