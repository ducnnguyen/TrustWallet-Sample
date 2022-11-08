//
//  NewWalletViewController.swift
//  Wallet-Sample
//
//  Created by Duc Nguyen on 04/11/2022.
//

import UIKit
import WalletCore
class NewWalletViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var textview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        textview.layer.borderWidth = 1.0
        textview.text = WalletManager.shared.createNewMnemonic()
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func createWallet(_ sender: Any) {
        activityIndicator.startAnimating()
        guard let wallet = try? WalletManager.shared.createNewWallet(mnemonic: textview.text, password: passwordTextField.text ?? "") else {
            activityIndicator.stopAnimating()
            return
        }
        if let walletInforVC = self.storyboard?.instantiateViewController(withIdentifier: "sbid_wallet_infor") as? WalletInforViewController {
            walletInforVC.wallet = wallet
            walletInforVC.password = passwordTextField.text
            self.navigationController?.pushViewController(walletInforVC, animated: true)
        }
        activityIndicator.stopAnimating()
        
    }
    
}
