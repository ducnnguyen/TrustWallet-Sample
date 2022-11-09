package io.astranaut.sdk.example

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import io.astranaut.sdk.wallet.WalletManager

class MainActivity : AppCompatActivity() {
    lateinit var txtPassword: EditText

    init {
        System.loadLibrary("TrustWalletCore")
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val storedKey = WalletManager.sharedInstance(applicationContext).getWallet()

        if (storedKey != null) {
            setContentView(R.layout.activity_login)
            txtPassword = findViewById(R.id.txtPasswordLogin)
        }
        else {
            setContentView(R.layout.activity_main)
        }
    }

    fun loginHandler(view: View) {
        val password = txtPassword.text.toString()
        if (WalletManager.sharedInstance(applicationContext).isValid(password)) {
            val intent = Intent(this, WalletInfoActivity::class.java)
            intent.putExtra("password", password)
            startActivity(intent)
        }
    }

    fun createWalletHandler(view: View) {
        val intent = Intent(this, CreateWalletActivity::class.java)
        intent.putExtra("mnemonic", WalletManager.sharedInstance(applicationContext).createNewMnemonic())
        startActivity(intent)
   }

    fun recoverWalletHandler(view: View) {
        val intent = Intent(this, CreateWalletActivity::class.java)
        startActivity(intent)
    }
}
