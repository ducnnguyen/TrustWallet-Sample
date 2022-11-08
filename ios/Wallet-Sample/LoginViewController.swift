//
//  LoginViewController.swift
//  Wallet-Sample
//
//  Created by Duc Nguyen on 08/11/2022.
//

import UIKit

class LoginViewController: UIViewController {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let _activityIndicator = UIActivityIndicatorView.init(style: .medium)
        
        _activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        _activityIndicator.tintColor = .systemGray
        
        view.addSubview(_activityIndicator)
        
        NSLayoutConstraint.activate(
            [
                _activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                _activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
        return _activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        activityIndicator.startAnimating()
        if let _ = try? WalletManager.shared.isValid(password: passwordTextField.text ?? "") {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sbid_wallet_infor") as? WalletInforViewController {
                vc.password = passwordTextField.text
                vc.wallet = try? WalletManager.shared.getWallet()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            print("__DEBUG__ invalid")
        }
        activityIndicator.stopAnimating()
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
