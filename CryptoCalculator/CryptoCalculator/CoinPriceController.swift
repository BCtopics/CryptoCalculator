//
//  CoinPriceController.swift
//  CryptoCalculator
//
//  Created by Bradley GIlmore on 5/22/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

enum Path: String {
    case btc = "btc"
    case dash = "dash"
    case eth = "eth"
    case xrp = "xrp"
    case ltc = "ltc"
    case zcash = "zec"
}

class CoinPriceController {
    
    static let baseURL = URL(string: "https://coinmarketcap-nexuist.rhcloud.com/api/")
    
    //MARK: - FetchUSDDollarAmount Function
    
    static func fetchUSDollarAmount(path: Path, completion: @escaping (_ responses: Coin?) -> Void) {
        
        let searchURL = baseURL?.appendingPathComponent(path.rawValue).appendingPathComponent("price")
        
        guard let usdURL = searchURL else { fatalError("USD/URL is nil") }
        
        NetworkController.performRequest(for: usdURL, httpMethod: .get, urlParameters: nil, body: nil) { (data, error) in
            
            guard let data = data else { return }
            
            guard error == nil else { print("Error: \(String(describing: error?.localizedDescription))"); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { completion(nil); return }
            
            guard let price = jsonDictionary["usd"] as? Double else { return }
            let priceString = String(price)
            
            let usdWallet = Coin(coinUSDAmount: priceString)
            print(usdWallet.coinUSDAmount)
            
            
            completion(usdWallet)
            
        }
    }
}
