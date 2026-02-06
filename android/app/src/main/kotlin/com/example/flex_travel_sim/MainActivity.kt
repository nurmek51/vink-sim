package com.example.flex_travel_sim

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.telephony.euicc.EuiccManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "vink.sim/esim"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "installEsim" -> {
                    val smdpServer = call.argument<String>("smdpServer")
                    val activationCode = call.argument<String>("activationCode")
                    
                    if (smdpServer != null && activationCode != null) {
                        installEsimProfile(smdpServer, activationCode, result)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Missing smdpServer or activationCode", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun installEsimProfile(smdpServer: String, activationCode: String, result: MethodChannel.Result) {
        try {
            // Check if device supports eSIM
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.P) {
                result.error("UNSUPPORTED_VERSION", "eSIM requires Android 9.0 (API 28) or later", null)
                return
            }

            val euiccManager = getSystemService(EuiccManager::class.java)
            if (euiccManager == null || !euiccManager.isEnabled) {
                result.error("ESIM_NOT_SUPPORTED", "eSIM is not supported or enabled on this device", null)
                return
            }

            // Create LPA URL for eSIM profile
            val lpaUrl = "LPA:1$$smdpServer$$activationCode"
            
            // Try to use system eSIM manager
            try {
                val intent = Intent()
                intent.action = "android.telephony.euicc.action.PROVISION_EMBEDDED_SUBSCRIPTION"
                intent.putExtra("android.telephony.euicc.extra.ACTIVATION_CODE", lpaUrl)
                
                if (intent.resolveActivity(packageManager) != null) {
                    startActivity(intent)
                    result.success("success")
                    return
                }
            } catch (e: Exception) {
                // Fall back to other methods
            }

            // Alternative: Try opening Settings
            try {
                val settingsIntent = Intent("android.settings.NETWORK_OPERATOR_SETTINGS")
                if (settingsIntent.resolveActivity(packageManager) != null) {
                    startActivity(settingsIntent)
                    result.success("opened_settings")
                    return
                }
            } catch (e: Exception) {
                // Fall back to manual instructions
            }

            // Last resort: Open generic settings
            val intent = Intent("android.settings.SETTINGS")
            if (intent.resolveActivity(packageManager) != null) {
                startActivity(intent)
                result.success("opened_general_settings")
            } else {
                result.error("NO_SETTINGS", "Cannot open device settings", null)
            }

        } catch (e: Exception) {
            result.error("INSTALL_ERROR", "Failed to install eSIM profile: ${e.message}", null)
        }
    }
}