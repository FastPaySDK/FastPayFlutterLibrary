import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fastpay.dart';
import 'fastpay_platform_interface.dart';

/// An implementation of [FastpayPlatform] that uses method channels.
class MethodChannelFastpay extends FastpayPlatform {
  /// The method channel used to interact with the native platform.
  MethodChannelFastpay() {
    methodChannel.setMethodCallHandler(_fromNative);
  }

  @visibleForTesting
  final methodChannel = const MethodChannel('fastpay');

  @override
  Future<String?> getPlatformVersion(Map<String, dynamic> fastPayData,Function(SDKStatus,String)? callback) async {
    this.callback = callback;
    final version = await methodChannel.invokeMethod<String>(
        'FastPayRequest', fastPayData);
    return version;
  }

  Future<void> _fromNative(MethodCall call) async {
    if (call.method == 'frequentCall') {
      //print('callTest result = ${call.arguments}');
      String arg = call.arguments;
      //debugPrint("............."+arg);
      Map<String, dynamic> data = jsonDecode(arg);
      //debugPrint("MAP............."+data.toString());
      String status = data['status']??'';
      if(status.toLowerCase() == "init"){
        callback?.call(SDKStatus.INIT,data['message']??'');
      } else if(status.toLowerCase() == "payment_with_fastpay_app"){
        callback?.call(SDKStatus.PAYMENT_WITH_FASTPAY_APP,data['message']??'');
      } else if(status.toLowerCase() == "payment_with_fastpay_sdk"){
        callback?.call(SDKStatus.PAYMENT_WITH_FASTPAY_SDK,data['message']??'');
      }else if(status.toLowerCase() == "cancel"){
        callback?.call(SDKStatus.CANCEL,data['message']??'');
      }
    }
  }


}
