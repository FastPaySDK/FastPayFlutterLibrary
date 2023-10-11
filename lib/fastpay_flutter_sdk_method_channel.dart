import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'constants/FastpayRequest.dart';

import 'fastpay_flutter_sdk_platform_interface.dart';

/// An implementation of [FastpayFlutterSdkPlatform] that uses method channels.
class MethodChannelFastpayFlutterSdk extends FastpayFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fastpay_flutter_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('initiatePayment');
    return version;
  }

  @override
  Future<String?> getFastpayPaymentResult(FastpayRequest request) async{
    final version = await methodChannel.invokeMethod<String>('initiatePayment',{
      'storeId': request.storeId,
      'storePassword': request.storePassword,
      'amount': request.amount,
      'orderId': request.orderId,
      'environment': request.environment.name,
    });
    return version;
  }
}
