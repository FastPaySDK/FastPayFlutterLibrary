import 'package:flutter_test/flutter_test.dart';
import 'package:fastpay_flutter_sdk/fastpay_flutter_sdk.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFastpayFlutterSdkPlatform
    with MockPlatformInterfaceMixin{

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {

}
