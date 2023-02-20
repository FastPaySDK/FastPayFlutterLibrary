
import 'fastpay_flutter_sdk_platform_interface.dart';

class FastpayFlutterSdk {
  Future<String?> getPlatformVersion() {
    return FastpayFlutterSdkPlatform.instance.getPlatformVersion();
  }
}
