import 'package:fastpay_flutter_sdk/constants/FastpayRequest.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fastpay_flutter_sdk/fastpay_flutter_sdk.dart';
import 'package:fastpay_flutter_sdk/fastpay_flutter_sdk_platform_interface.dart';
import 'package:fastpay_flutter_sdk/fastpay_flutter_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFastpayFlutterSdkPlatform
    with MockPlatformInterfaceMixin
    implements FastpayFlutterSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getFastpayPaymentResult(FastpayRequest request) {
    // TODO: implement getFastpayPaymentResult
    throw UnimplementedError();
  }
}

void main() {

}
