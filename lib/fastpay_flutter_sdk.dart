
import 'fastpay_flutter_sdk_platform_interface.dart';
import 'constants/FastpayRequest.dart';

class FastpayFlutterSdk {
  Future<String?> getFastpayPaymentResult(FastpayRequest request) {
    return FastpayFlutterSdkPlatform.instance.getFastpayPaymentResult(request);
  }
}
