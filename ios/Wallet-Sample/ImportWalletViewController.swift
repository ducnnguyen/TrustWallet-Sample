//
//  ImportWalletViewController.swift
//  Wallet-Sample
//
//  Created by Duc Nguyen on 04/11/2022.
//

import UIKit

class ImportWalletViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        textView.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
    }
    private var activityIndicator: UIActivityIndicatorView!
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
     @IBOutlet weak var passwordTextField: UITextField!
     // Pass the selected object to the new view controller.
    }
    */

    @IBAction func importWallet(_ sender: Any) {
        activityIndicator.startAnimating()
        if WalletManager.shared.isValid(mnemonic: textView.text) {
            guard let wallet = try? WalletManager.shared.createNewWallet(mnemonic: textView.text, password: passwordTextField.text ?? "") else {
                activityIndicator.stopAnimating()
                return
            }
            if let walletInforVC = self.storyboard?.instantiateViewController(withIdentifier: "sbid_wallet_infor") as? WalletInforViewController {
                walletInforVC.wallet = wallet
                walletInforVC.password = passwordTextField.text
                self.navigationController?.pushViewController(walletInforVC, animated: true)
            }
            activityIndicator.stopAnimating()
        } else if WalletManager.shared.isValidKey(hex: textView.text) {
            guard let wallet = try? WalletManager.shared.createNewWallet(privateKey: textView.text, password: passwordTextField.text ?? "") else {
                activityIndicator.stopAnimating()
                return
            }
            if let walletInforVC = self.storyboard?.instantiateViewController(withIdentifier: "sbid_wallet_infor") as? WalletInforViewController {
                walletInforVC.wallet = wallet
                walletInforVC.password = passwordTextField.text
                self.navigationController?.pushViewController(walletInforVC, animated: true)
            }
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.stopAnimating()
            print("__DEBUG__ invalid")
        }
    }
}
