package io.astranaut.sdk.example

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import io.astranaut.sdk.wallet.WalletManager

class CreateWalletActivity: AppCompatActivity() {

    private lateinit var txtMnemonic: EditText
    private lateinit var txtPassword: EditText

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_create_wallet)

        txtMnemonic = findViewById(R.id.txtMnemonic)
        txtPassword = findViewById(R.id.txtPassword)

        val mnemonic =
            intent.extras?.getString("mnemonic")
        txtMnemonic.setText(mnemonic)
    }

    fun proceedCreateWalletHandler(view: View) {
        val password = txtPassword.text.toString()
        val walletManager = WalletManager.sharedInstance(applicationContext)
        walletManager.createNewWalletWithMnemonic(txtMnemonic.text.toString(), password)
        println("__DEBUG__ mnemonic ${walletManager.exportMnemonic(password)}")
        println("__DEBUG__ address ${walletManager.exportHexAddress(password)}")
        println("__DEBUG__ private key ${walletManager.exportPrivateKey(password)}")
        println("__DEBUG__ public key ${walletManager.exportPublicKey(password)}")

        val intent = Intent(this, WalletInfoActivity::class.java)
        intent.putExtra("password", password)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
        finish()
    }
}
