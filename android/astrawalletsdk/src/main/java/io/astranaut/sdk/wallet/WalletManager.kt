package io.astranaut.sdk.wallet

import android.content.Context
import wallet.core.jni.*

interface AppWallet {
    fun isValidMnemonic(mnemonic: String): Boolean
    fun isValidPrivateKey(hex: String): Boolean
}

class WalletManager: AppWallet {
    companion object {
        var mapping: HashMap<Context, WalletManager> = hashMapOf()
        fun sharedInstance(applicationContext: Context): WalletManager {
            if (mapping.containsKey(applicationContext)) {
                return mapping.getValue(applicationContext)
            }

            val walletManager = WalletManager(applicationContext)
            mapping[applicationContext] = walletManager
            return walletManager
        }
        private const val localName = "MyWallet"
    }

    private var applicationContext: Context
    private var path: String

    constructor(applicationContext: Context) {
        println("__DEBUG__ WalletManager constructor")
        this.applicationContext = applicationContext
        this.path = applicationContext.applicationInfo.dataDir + "/$localName"
    }

    fun getWallet(): StoredKey? {
        return StoredKey.load(path)
    }

    fun getWallet(password: String?): HDWallet? {
        val storedKey = StoredKey.load(path)
        return storedKey?.wallet(password?.toByteArray())
    }

    fun createNewMnemonic(): String? {
        val wallet = HDWallet(128, "")
        return wallet.mnemonic()
    }

    fun createNewWalletWithMnemonic(mnemonic: String, password: String = ""): HDWallet {
        if (!isValidMnemonic(mnemonic)) {
            throw Exception("Invalid Mnemonic")
        }

        val storedKey = StoredKey.importHDWallet(
            mnemonic,
            "",
            password.toByteArray(),
            CoinType.ETHEREUM
        )

        val success = storedKey.store(path)
        storedKey.wallet(password.toByteArray())
        println("__DEBUG__ storedKey.accountCount(): ${storedKey.accountCount()}")
        println("__DEBUG__ store success: $success")
        println("__DEBUG__ storedKey: ${StoredKey.load(path)}")
        return storedKey.wallet(password.toByteArray())
    }

    fun createNewWalletWithPrivateKey(privateKey: String, password: String = ""): HDWallet {
        if (!isValidPrivateKey(privateKey)) {
            throw Exception("Invalid Private Key")
        }

        val storedKey = StoredKey.importPrivateKey(
            privateKey.toByteArray(),
            "",
            password.toByteArray(),
            CoinType.ETHEREUM
        )
        storedKey.store(path)
        return storedKey.wallet(password.toByteArray())
    }

    fun isValid(password: String): Boolean {
        val storedKey = StoredKey.load(path)
        val wallet = storedKey?.wallet(password.toByteArray())
        return wallet != null
    }

    fun exportMnemonic(password: String?): String? {
        val wallet = getWallet(password)
        return wallet?.mnemonic()
    }

    fun exportHexAddress(password: String?): String? {
        val wallet = getWallet(password)
        return wallet?.getAddressForCoin(CoinType.ETHEREUM)
    }

    fun exportPrivateKey(password: String?): String? {
        val wallet = getWallet(password)
        val privateKey = wallet?.getKeyForCoin(CoinType.ETHEREUM)
        return privateKey?.data()?.toHexString(false)
    }

    fun exportPublicKey(password: String?): String? {
        val wallet = getWallet(password)
        val privateKey = wallet?.getKeyForCoin(CoinType.ETHEREUM)
        val publicKey = privateKey?.getPublicKeySecp256k1(true)
        return publicKey?.data()?.toHexString(false)
    }

    override fun isValidMnemonic(mnemonic: String): Boolean {
        return Mnemonic.isValid(mnemonic)
    }

    override fun isValidPrivateKey(hex: String): Boolean {
        return PrivateKey.isValid(hex.toByteArray(), Curve.SECP256K1)
    }
}

private fun ByteArray.toHexString(withPrefix: Boolean = true): String {
    var hexString = ""
    if (withPrefix) {
        hexString += "0x"
    }
    return hexString + this.joinToString("") {
        "%02x".format(it)
    }
}