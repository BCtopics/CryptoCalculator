//
//  CalculationViewController.swift
//  CryptoCalculator
//
//  Created by Bradley GIlmore on 5/22/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class CalculationViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Ethereum Calculations
    
    func calculateEthereumPrice() {
        EthPriceController.fetchUSDollarAmount(completion: { (wallet) in
            guard let usd = wallet else { NSLog("wallet in fetchUSDDollarAmount was nil"); return }
            DispatchQueue.main.async {
                guard let a = Double(usd.ethUSDAmount) else { return }
                guard let balanceEntered = self.amountEntered.text else { return }
                guard let b = Double(balanceEntered) else { return }
                let total = a * b
                self.temp = String("$\(total)")
                
                let alert = UIAlertController(title: "\(self.temp)", message: nil, preferredStyle: .alert)
                let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAlert)
                
                self.present(alert, animated: true, completion: nil)
                
                // Alert controller works when I put it into the function, but not when I have it run in the calculateButtonTapped. Fix this later.
            }
        })
        
    }
    
    
    //MARK: - CalculatePrice Function
    
    func calculatePrice(path: Path) {
        CoinPriceController.fetchUSDollarAmount(path: path, completion: { (wallet) in
            guard let usd = wallet else { NSLog("wallet in fetchUSDDollarAmount was nil"); return }
            DispatchQueue.main.async {
                
                guard let balanceEntered = self.amountEntered.text else { return }
                guard let a = Double(usd.coinUSDAmount) else { return }
                guard let b = Double(balanceEntered) else { return }
                let total = a * b
                
                self.temp = String("$\(total)")
                
                let alert = UIAlertController(title: "\(self.temp)", message: nil, preferredStyle: .alert)
                let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAlert)
                
                self.present(alert, animated: true, completion: nil)
            }
        })
        
    }
    
    //MARK: - IBActions/Buttons
    
    @IBAction func ethButtonTapped(_ sender: Any) {
        calculateEthereumPrice()
    }
    
    @IBAction func btcButtonTapped(_ sender: Any) {
        calculatePrice(path: .btc)
    }

    @IBAction func dashButtonTapped(_ sender: Any) {
        calculatePrice(path: .dash)
    }
    
    

    //MARK: - IBOutlets
    
    @IBOutlet weak var amountEntered: UITextField!
    
    //MARK: - Internal Properties
    
    var temp = "Nothing Yet :("
}
