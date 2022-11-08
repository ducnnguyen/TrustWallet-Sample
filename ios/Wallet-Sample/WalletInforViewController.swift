//
//  WalletViewController.swift
//  Wallet-Sample
//
//  Created by Duc Nguyen on 08/11/2022.
//

import UIKit
import WalletCore

class WalletInforViewController: UIViewController {

    @IBOutlet weak var mnemonicField: UITextView!
    @IBOutlet weak var privateKeyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var publicKeyLabel: UILabel!
    
    var wallet: WalletCore.Wallet?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(wallet?.identifier)
        let privateKey = WalletManager.shared.exportPrivateKey(wallet: wallet, password: password)
        print("__DEBUG__ privatekey ", privateKey)
        privateKeyLabel.text = privateKey
        let mnemonic = WalletManager.shared.exportMnemonic(wallet: wallet, password: password)
        print("__DEBUG__ mnemonic ", mnemonic)
        mnemonicField.text = mnemonic
        let publicKey = WalletManager.shared.exportPublicKey(wallet: wallet, password: password)
        print("__DEBUG__ publicKey ", publicKey)
        publicKeyLabel.text = publicKey
        
        let address = WalletManager.shared.exportHexAddress(wallet: wallet, password: password)
        print("__DEBUG__ address ", address)
        addressLabel.text = address
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
