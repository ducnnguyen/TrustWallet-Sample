//
//  WalletManager.swift
//  Wallet-Sample
//
//  Created by Duc Nguyen on 07/11/2022.
//

import Foundation
import WalletCore

protocol AppWallet {
    
    func isValid(mnemonic: String?) -> Bool
    func isValidKey(hex: String) -> Bool

}

final class WalletManager: AppWallet {
    public func createNewMnemonic() -> String? {
        let hdWallet = HDWallet(strength: 128, passphrase: "")
        return hdWallet?.mnemonic
    }
    
    public func createNewWallet(mnemonic: String?, password: String = "") throws -> WalletCore.Wallet {
        guard let mnemonic = mnemonic, isValid(mnemonic: mnemonic) else {
            throw KeyStore.Error.invalidMnemonic
        }
        let keyStore = try KeyStore(keyDirectory: WalletManager.keyDirectory)
        let wallet = try keyStore.import(mnemonic: mnemonic, name: WalletManager.localName, encryptPassword: password, coins: [.ethereum])
        return wallet
    }
    
    public func createNewWallet(privateKey: String?, password: String = "") throws -> WalletCore.Wallet {
        
        guard let privateKey = privateKey, isValidKey(hex: privateKey), let priv = PrivateKey(data: Data(hexString: privateKey)!) else {
            throw KeyStore.Error.invalidKey
        }
        let keyStore = try KeyStore(keyDirectory: WalletManager.keyDirectory)
        let wallet = try keyStore.import(privateKey: priv, name: WalletManager.localName, password: password, coin: .ethereum)
        return wallet
    }
    
    func isValidKey(hex: String) -> Bool {
        guard let data = Data(hexString: hex) else {return false}
        return PrivateKey.isValid(data: data, curve: .secp256k1)
    }
    
    public static let shared: WalletManager = WalletManager()
    
    private static let keyDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(localName)
    
    private static let localName: String = "MyWallet"
    
    func isValid(mnemonic: String?) -> Bool {
        guard let mnemonic = mnemonic else {return false}
        return Mnemonic.isValid(mnemonic: mnemonic)
    }
    
    public func getWallet() throws -> WalletCore.Wallet? {
        let keyStore = try KeyStore(keyDirectory: WalletManager.keyDirectory)
//        try keyStore.destroy()
        return keyStore.wallets.isEmpty ? nil : keyStore.wallets.first
    }
    
    public func isValid(password: String) throws -> Bool {
        let keyStore = try KeyStore(keyDirectory: WalletManager.keyDirectory)
        let wallet = try getWallet()
        let key = try keyStore.exportPrivateKey(wallet: wallet!, password: password)
        return key != nil
    }
    
    public func exportPrivateKey(wallet: WalletCore.Wallet?, password: String?) -> String {
        guard let key = wallet?.key, let password = password else {return ""}
        if key.isMnemonic {
            guard let hdWallet = key.wallet(password: Data(password.utf8)), let privateKey = try? hdWallet.getKeyForCoin(coin: .ethereum) else { return "" }
            return privateKey.data.hexString
        } else {
            guard let privateData = key.decryptPrivateKey(password: Data(password.utf8)) else {return ""}
            return privateData.hexString
        }
    }
    
    public func exportMnemonic(wallet: WalletCore.Wallet?, password: String?) -> String {
        guard let key = wallet?.key, let password = password,  key.isMnemonic == true else {return ""}
        guard let mnemonic = try? key.decryptMnemonic(password: Data(password.utf8)) else {return ""}
        return mnemonic
    }
    
    public func exportPublicKey(wallet: WalletCore.Wallet?, password: String?) -> String {
        guard let key = wallet?.key, let password = password else {return ""}
        let hdWallet = key.wallet(password: Data(password.utf8))
        print("_DEBUG_ hdWallet ", hdWallet)
        if key.isMnemonic {
            guard let hdWallet = key.wallet(password: Data(password.utf8)), let privateKey = try? hdWallet.getKeyForCoin(coin: .ethereum), let publicKey = try? privateKey.getPublicKeySecp256k1(compressed: true) else { return "" }
            return publicKey.data.hexString
        } else {
            guard let privateKey = key.privateKey(coin: .ethereum, password: Data(password.utf8)), let publicKey = try? privateKey.getPublicKeySecp256k1(compressed: true) else { return "" }
            return publicKey.data.hexString
        }
    }
    
    public func exportHexAddress(wallet: WalletCore.Wallet?, password: String?) -> String {
        if let password = password, let account = try? wallet?.getAccount(password: password, coin: .ethereum) {
            return account.address
        }
        return ""
    }
}
