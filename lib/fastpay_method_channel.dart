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
    if (call.method == 'callTestResuls') {
      print('callTest result = ${call.arguments}');
      callback?.call(SDKStatus.CANCEL,"MEssage");
    }
  }


}
