//
//  CalcViewController.swift
//  CryptoCalculator
//
//  Created by Bradley GIlmore on 5/24/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController {
    
    //MARK: - Objects
    
    let balanceTitle = UILabel()
    let balanceTextField = UITextField()
    
    // Buttons
    
    let ethereumButton = UIButton()
    let btcButton = UIButton()
    let dashButton = UIButton()
    
    
    // Stacks

    let firstStackView = UIStackView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - First StackView
        view.addSubview(firstStackView)
        firstStackView.alignment = .fill
        firstStackView.distribution = .fill // When I make this fill equally it does the btc icon... when I do fill it does a huge version of the ethereum icon?
        firstStackView.spacing = 20.0
        
        // Ethereum Button
        
        ethereumButton.setImage(#imageLiteral(resourceName: "EthIcon"), for: .normal)
        ethereumButton.translatesAutoresizingMaskIntoConstraints = false
        ethereumButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ethereumButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        ethereumButton.addTarget(self, action: #selector(calculatePrice(sender:)), for: .touchUpInside)

        // BTC Button
    
        btcButton.setImage(#imageLiteral(resourceName: "BTCIcon"), for: .normal)
        btcButton.translatesAutoresizingMaskIntoConstraints = false
        btcButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btcButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        btcButton.addTarget(self, action: #selector(calculatePrice(sender:)), for: .touchUpInside)
        
        // Dash Button
        
        dashButton.setImage(#imageLiteral(resourceName: "DashIcon"), for: .normal)
        dashButton.translatesAutoresizingMaskIntoConstraints = false
        dashButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dashButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dashButton.addTarget(self, action: #selector(calculatePrice(sender:)), for: .touchUpInside)
        
        
        //MARK: - Second Stack View
        
        // Balance Title
        balanceTitle.text = "Calculator"
        balanceTitle.sizeToFit()
        view.addSubview(balanceTitle)
        
        
        // Balance Text Field
        view.addSubview(balanceTextField)
        
        // Setup Functions
        
        setupStackView()
        setupConstraints()
    }
    
    func setupStackView() {
        
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        firstStackView.widthAnchor.constraint(equalToConstant: 200)
        firstStackView.heightAnchor.constraint(equalToConstant: 100)
        firstStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        firstStackView.addArrangedSubview(ethereumButton)
        firstStackView.addArrangedSubview(btcButton)
        firstStackView.addArrangedSubview(dashButton)
    }
    
    func setupConstraints() {
        
        // Turn Off Flags
        
        balanceTitle.translatesAutoresizingMaskIntoConstraints = false
        balanceTextField.translatesAutoresizingMaskIntoConstraints = false
    

        balanceTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        balanceTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    // Calculations
    
    func calculatePrice(sender: UIButton) {
        
        if sender == ethereumButton {
            path = .eth
        }
        
        if sender == btcButton {
            path = .btc
        }
        
        if sender == dashButton {
            path = .dash
        }
            
        CoinPriceController.fetchUSDollarAmount(path: path, completion: { (price) in
            guard let usd = price else { NSLog("Price in fetchUSDDollarAmount was nil"); return }
            DispatchQueue.main.async {
                
                guard let balanceEntered = self.balanceTextField.text else { return }
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
    
    //MARK: - Internal Properties
    
    var temp = "Nothing Yet :("
    var path = Path.btc


}
