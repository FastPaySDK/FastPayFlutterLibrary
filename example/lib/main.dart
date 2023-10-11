import 'package:fastpay_flutter_sdk/constants/Environment.dart';
import 'package:fastpay_flutter_sdk/constants/FastpayRequest.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fastpay_flutter_sdk/fastpay_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _fastpayFlutterSdkPlugin = FastpayFlutterSdk();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      var request = FastpayRequest(storeId: "storeId", storePassword: "storePassword", amount: "amount", orderId: "orderId", environment: Environment.sandbox);
      platformVersion = await _fastpayFlutterSdkPlugin.getFastpayPaymentResult(request) ?? 'Unknown platform version';
      debugPrint(platformVersion);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fastpay SDK test'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Test"),
              FilledButton(
                onPressed: (){
                  initPlatformState();
                },
                child: Text('Click to initiate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
