import 'fastpay_platform_interface.dart';

// test jest string
// class Fastpay {
//   Future<String?> getPlatformVersion() {
//     return FastpayPlatform.instance.getPlatformVersion();
//   }
// }

class Fastpay {
  Future<String?> getPlatformVersion(Map<String, dynamic> fastPayData,Function(SDKStatus,String)? callback) {
    return FastpayPlatform.instance.getPlatformVersion(fastPayData,callback);
  }
}

enum SDKStatus{
  INIT,
  PAYMENT_WITH_FASTPAY_APP,
  PAYMENT_WITH_FASTPAY_SDK,
  CANCEL
}
