package com.fastpay.sdk.fastpay_flutter_sdk

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import com.fastpay.payment.model.merchant.FastpayRequest
import com.fastpay.payment.model.merchant.FastpayResult
import com.fastpay.payment.model.merchant.FastpaySDK
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


/** FastpayFlutterSdkPlugin */
class FastpayFlutterSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private var activity: Activity?  = null
    private var mResult: Result? = null

    override fun onDetachedFromActivity() {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;
        binding.addActivityResultListener(this);
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fastpay_flutter_sdk")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        mResult = result;
        if (call.method == "initiatePayment") {
            //result.success("Android ${android.os.Build.VERSION.RELEASE}")
            if (activity != null) {
                try {
                    val hashMap = call.arguments as HashMap<*, *>
                    val fastpayRequest = FastpayRequest(
                        context,
                        hashMap["storeId"].toString(),
                        hashMap["storePassword"].toString(),
                        hashMap["amount"].toString(),
                        hashMap["orderId"].toString(),
                        FastpaySDK.SANDBOX
                    )
                    fastpayRequest.startPaymentIntent(activity, 2002)
                } catch (e: Exception) {
                    result.success("{\"isSuccess\":false,\"errorMessage\":\"" + e.message + "\"}")
                }
            } else {
                result.notImplemented()
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        activity = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == 2002) {
            when(resultCode){
                Activity.RESULT_OK->{
                    if (data != null && data.hasExtra(FastpayResult.EXTRA_PAYMENT_RESULT)) {
                        val fastpaySDKResult: FastpayResult? = data.getParcelableExtra(FastpayResult.EXTRA_PAYMENT_RESULT)
                        //? is payment success
                        mResult?.success("{\"isSuccess\":true,\"errorMessage\":\"\",\"transactionStatus\":\"" + fastpaySDKResult?.transactionStatus + "\",\"transactionId\":\"" + fastpaySDKResult?.transactionId + "\",\"orderId\":\"" + fastpaySDKResult?.orderId + "\",\"paymentAmount\":\"" + fastpaySDKResult?.paymentAmount + "\",\"paymentCurrency\":\"" + fastpaySDKResult?.paymentCurrency + "\",\"payeeName\":\"" + fastpaySDKResult?.payeeName + "\",\"payeeMobileNumber\":\"" + fastpaySDKResult?.payeeMobileNumber + "\",\"paymentTime\":\"" + fastpaySDKResult?.paymentTime + "\"}")
                    }else{
                        mResult?.success("{\"isSuccess\":false,\"errorMessage\":\""+"CANCELED"+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}");
                    }
                }
                Activity.RESULT_CANCELED->{
                    mResult?.success("{\"isSuccess\":false,\"errorMessage\":\""+"CANCELED"+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}");
                }
            }
        }
        return true
    }
}
