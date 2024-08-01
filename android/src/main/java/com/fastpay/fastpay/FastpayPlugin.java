package com.fastpay.fastpay;

import android.content.Context;
import android.content.Intent;
import android.app.Activity;
import android.os.Handler;
import android.provider.ContactsContract;
import android.content.Intent;
import android.content.IntentFilter;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import android.net.Uri;


import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;

import com.fastpay.payment.model.merchant.FastpayRequest;
import com.fastpay.payment.model.merchant.FastpayResult;
import com.fastpay.payment.model.merchant.FastpaySDK;
import com.fastpay.payment.service.listener.ListenerFastpayCallback;

import java.util.Locale;
import java.util.Map;


/** FastpayPlugin */
public class FastpayPlugin implements FlutterPlugin, MethodCallHandler , ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  private Activity activity;
  private Result mResult;
  private boolean isProduction = false;
  private static final String TAG = "FastpayPlugin";


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "com.fastpay.fastpay/payment");
    context = flutterPluginBinding.getApplicationContext();


    channel.setMethodCallHandler(this);

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("fastpaySDKPayment")) {
      String getData = call.arguments();
      Intent intent = new Intent (Intent.ACTION_VIEW);
      intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      intent.setData(Uri.parse(getData));
      context.startActivity(intent);
    } else {
      result.notImplemented();
    }
  }




  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    activity = null;
  }


  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    binding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    binding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }


  @Override
  public boolean onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    if (requestCode == 1999) {
      String response;
      switch (resultCode) {
        case Activity.RESULT_OK:
          if (data != null && data.hasExtra(FastpayResult.EXTRA_PAYMENT_RESULT)) {
            FastpayResult result = data.getParcelableExtra(FastpayResult.EXTRA_PAYMENT_RESULT);
            //? is payment success
            response = "{\"isSuccess\":true,\"errorMessage\":\"\",\"transactionStatus\":\""+result.getTransactionStatus()+"\",\"transactionId\":\""+result.getTransactionId()+"\",\"orderId\":\""+result.getOrderId()+"\",\"paymentAmount\":\""+result.getPaymentAmount()+"\",\"paymentCurrency\":\""+result.getPaymentCurrency()+"\",\"payeeName\":\""+result.getPayeeName()+"\",\"payeeMobileNumber\":\""+result.getPayeeMobileNumber()+"\",\"paymentTime\":\""+result.getPaymentTime()+"\"}";
            if (!isProduction)
              android.util.Log.i(TAG, "onMethodCall: ....."+response);

            mResult.success(response);
          }
          break;

        //? is payment Failed
        case Activity.RESULT_CANCELED:
          if (data != null && data.hasExtra(FastpayRequest.EXTRA_PAYMENT_MESSAGE)) {
            String message = data.getStringExtra(FastpayRequest.EXTRA_PAYMENT_MESSAGE);
            //? is payment fail any fastPay resource cancel
            response = "{\"isSuccess\":false,\"errorMessage\":\""+message+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}";
            mResult.success(response);

          } else {
            //? is payment back
            response = "{\"isSuccess\":false,\"errorMessage\":\""+"CANCELED"+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}";
            mResult.success(response);
          }
          if (!isProduction)
            android.util.Log.i(TAG, "onMethodCall: ....."+response);
          break;
        default:
          //? is payment for any other resource cancel
          response = "{\"isSuccess\":false,\"errorMessage\":\""+"CANCELED"+"\",\"transactionStatus\":\"\",\"transactionId\":\"\",\"orderId\":\"\",\"paymentAmount\":\"\",\"paymentCurrency\":\"\",\"payeeName\":\"\",\"payeeMobileNumber\":\"\",\"paymentTime\":\"\"}";
          mResult.success(response);
          if (!isProduction)
            android.util.Log.i(TAG, "onMethodCall: ....."+response);
          break;
      }
    }
    return true;
  }
}
