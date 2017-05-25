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
    
    let zcashButton = UIButton()
    let xrpButton = UIButton()
    let ltcButton = UIButton()
    
    
    // Stacks

    let firstStackView = UIStackView()
    let secondStackView = UIStackView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.balanceTextField.becomeFirstResponder()
        
        balanceTextField.keyboardType = .decimalPad
        //FIXME: - Put this somewhere better later...
        
        //MARK: - First StackView
        view.addSubview(firstStackView)
        firstStackView.alignment = .fill
        firstStackView.distribution = .fill
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
        
        
        //MARK: - Second StackView
        
        view.addSubview(secondStackView)
        secondStackView.alignment = .fill
        secondStackView.distribution = .fill
        secondStackView.spacing = 20.0
        
        // Zcash Button
        
        zcashButton.setImage(#imageLiteral(resourceName: "ZECIcon"), for: .normal)
        zcashButton.translatesAutoresizingMaskIntoConstraints = false
        zcashButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        zcashButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        zcashButton.addTarget(self, action: #selector(calculatePrice(sender:)), for: .touchUpInside)
        
        // xrp Button 
        
        xrpButton.setImage(#imageLiteral(resourceName: "RippleIcon"), for: .normal)
        xrpButton.translatesAutoresizingMaskIntoConstraints = false
        xrpButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        xrpButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        xrpButton.addTarget(self, action: #selector(calculatePrice(sender:)), for: .touchUpInside)
        
        // LTC Button
        
        ltcButton.setImage(#imageLiteral(resourceName: "LTCIcon"), for: .normal)
        ltcButton.translatesAutoresizingMaskIntoConstraints = false
        ltcButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ltcButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        ltcButton.addTarget(self, action: #selector(calculatePrice(sender:)), for: .touchUpInside)
        
        
        // Balance Title
        balanceTitle.text = "Amount to Calculate"
        balanceTitle.sizeToFit()
        view.addSubview(balanceTitle)
        
        
        // Balance Text Field
        view.addSubview(balanceTextField)
        NSLayoutConstraint.init(item: balanceTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 8).isActive = true
        NSLayoutConstraint.init(item: balanceTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -8).isActive = true
        balanceTextField.borderStyle = .roundedRect
        
        
        // Setup Functions
        
        setupStackView1()
        setupStackView2()
        setupConstraints()
    }
    
    func setupStackView1() {
        
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        firstStackView.widthAnchor.constraint(equalToConstant: 200)
        firstStackView.heightAnchor.constraint(equalToConstant: 100)
        firstStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        firstStackView.addArrangedSubview(ethereumButton)
        firstStackView.addArrangedSubview(btcButton)
        firstStackView.addArrangedSubview(dashButton)
    }
    
    func setupStackView2() {
        
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        
        secondStackView.widthAnchor.constraint(equalToConstant: 200)
        secondStackView.heightAnchor.constraint(equalToConstant: 100)
        secondStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120).isActive = true // This is what I need to change later
        secondStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        secondStackView.addArrangedSubview(zcashButton)
        secondStackView.addArrangedSubview(xrpButton)
        secondStackView.addArrangedSubview(ltcButton)
        
    }
    
    func setupConstraints() {
        
        // Turn Off Flags
        
        balanceTitle.translatesAutoresizingMaskIntoConstraints = false
        balanceTextField.translatesAutoresizingMaskIntoConstraints = false
    
        // Balance Title Constraints
        
        balanceTitle.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 124).isActive = true
        balanceTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // BalanceTextField Constraints
        
        NSLayoutConstraint.init(item: balanceTextField, attribute: .top, relatedBy: .equal, toItem: balanceTitle, attribute: .bottom, multiplier: 1.0, constant: 19.5).isActive = true
        balanceTextField.placeholder = "Amount Of Crypto"
        
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
        
        if sender == zcashButton {
            path = .zcash
        }
        
        if sender == xrpButton {
            path = .xrp
        }
        
        if sender == ltcButton {
            path = .ltc
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
