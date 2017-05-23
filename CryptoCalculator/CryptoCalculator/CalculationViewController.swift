//
//  CalculationViewController.swift
//  CryptoCalculator
//
//  Created by Bradley GIlmore on 5/22/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class CalculationViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - CalculatePrice Function
    
    func calculatePrice(path: Path) {
        CoinPriceController.fetchUSDollarAmount(path: path, completion: { (price) in
            guard let usd = price else { NSLog("Price in fetchUSDDollarAmount was nil"); return }
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
        calculatePrice(path: .eth)
    }
    
    @IBAction func btcButtonTapped(_ sender: Any) {
        calculatePrice(path: .btc)
    }

    @IBAction func dashButtonTapped(_ sender: Any) {
        calculatePrice(path: .dash)
    }
    
    @IBAction func zcashButtonTapped(_ sender: Any) {
        calculatePrice(path: .zcash)
    }
    
    @IBAction func rippleButtonTapped(_ sender: Any) {
        calculatePrice(path: .xrp)
    }
    
    @IBAction func ltcButtonTapped(_ sender: Any) {
        calculatePrice(path: .ltc)
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var amountEntered: UITextField!
    
    //MARK: - Internal Properties
    
    var temp = "Nothing Yet :("
    
    
    //MARK: - UITextField Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
