import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fastpay_flutter_sdk_method_channel.dart';

abstract class FastpayFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a FastpayFlutterSdkPlatform.
  FastpayFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FastpayFlutterSdkPlatform _instance = MethodChannelFastpayFlutterSdk();

  /// The default instance of [FastpayFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelFastpayFlutterSdk].
  static FastpayFlutterSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FastpayFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(FastpayFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
