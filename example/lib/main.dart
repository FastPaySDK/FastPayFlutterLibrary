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
  TextEditingController orderId = TextEditingController(text: '');
  TextEditingController amount = TextEditingController(text: '');

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
      var request = FastpayRequest(storeId: "748957_847", storePassword: "v=7bUPTeC2#nQ2-+", amount: amount.text, orderId: orderId.text, environment: Environment.sandbox);
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
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                TextField(
                  controller: orderId,
                  decoration: InputDecoration(
                    labelText: 'Order ID',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: amount,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 16.0),
                FilledButton(
                  onPressed: () {
                    initPlatformState();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
