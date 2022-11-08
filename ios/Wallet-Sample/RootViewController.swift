//
//  ViewController.swift
//  Wallet-Sample
//
//  Created by Duc Nguyen on 04/11/2022.
//

import UIKit
import WalletCore

class RootViewController: UIViewController {
    private var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        configureWallet()
    }
    
    private func configureActivityIndicator() {
        activityIndicator = .init(style: .medium)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tintColor = .systemGray
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
    
    private func configureWallet() {
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if let _ = try? WalletManager.shared.getWallet() {
                guard let walletInforVC = self?.storyboard?.instantiateViewController(withIdentifier: "sbid_login") as?  LoginViewController else {
                    self?.activityIndicator.stopAnimating()
                    return
                }
                let navVc = UINavigationController(rootViewController: walletInforVC)
                navVc.modalPresentationStyle = .fullScreen
                self?.present(navVc, animated: true) {
                    self?.activityIndicator.stopAnimating()
                }
            } else {
                guard let navViewController = self?.storyboard?.instantiateViewController(withIdentifier: "sbid_create_nav") as? UINavigationController else {
                    self?.activityIndicator.stopAnimating()
                    return
                }
                navViewController.modalPresentationStyle = .fullScreen
                
                self?.present(navViewController, animated: true) {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }


}

