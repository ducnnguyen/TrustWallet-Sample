package io.astranaut.sdk.example

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import io.astranaut.sdk.wallet.WalletManager

class WalletInfoActivity: AppCompatActivity() {

    private lateinit var txtOutMnemonic: TextView
    private lateinit var txtOutAddress: TextView
    private lateinit var txtOutPrivateKey: TextView
    private lateinit var txtOutPublicKey: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_wallet_info)

        txtOutMnemonic = findViewById(R.id.txtOutMnemonic)
        txtOutAddress = findViewById(R.id.txtOutAddress)
        txtOutPrivateKey = findViewById(R.id.txtOutPrivateKey)
        txtOutPublicKey = findViewById(R.id.txtOutPublicKey)

        val bundle = intent.extras
        val password = bundle?.getString("password")
        val walletManager = WalletManager.sharedInstance(applicationContext)

        txtOutMnemonic.text = walletManager.exportMnemonic(password)
        txtOutAddress.text = walletManager.exportHexAddress(password)
        txtOutPrivateKey.text = walletManager.exportPrivateKey(password)
        txtOutPublicKey.text = walletManager.exportPublicKey(password)
    }
}