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
}

void main() {
  final FastpayFlutterSdkPlatform initialPlatform = FastpayFlutterSdkPlatform.instance;

  test('$MethodChannelFastpayFlutterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFastpayFlutterSdk>());
  });

  test('getPlatformVersion', () async {
    FastpayFlutterSdk fastpayFlutterSdkPlugin = FastpayFlutterSdk();
    MockFastpayFlutterSdkPlatform fakePlatform = MockFastpayFlutterSdkPlatform();
    FastpayFlutterSdkPlatform.instance = fakePlatform;

    expect(await fastpayFlutterSdkPlugin.getPlatformVersion(), '42');
  });
}
