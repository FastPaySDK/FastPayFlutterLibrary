import 'dart:async';

import 'package:fastpay_merchant/fastPayRequests.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  FastpayResult? _fastpayResult;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: [
              Center(
                child: Text("${_fastpayResult?.toJson()}\n"),
              ),
              ElevatedButton(
                onPressed: () async {
                  FastpayResult _fastpayResult = await FastPayRequest(
                    storeID: "748957_847",
                    storePassword: "v=7bUPTeC2#nQ2-+",
                    amount: "10000",
                    orderID: DateTime.now().microsecondsSinceEpoch.toString(),
                    isProduction: false,
                    callback: (status,message){
                      debugPrint("..................."+message);
                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: Text(message),
                      ));
                    }
                  );
                  if (_fastpayResult.isSuccess ?? false) {
                    // transaction success
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("transaction success"),
                    ));
                    print('......................................transaction success');
                  } else {
                    // transaction failed
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("transaction failed"),
                    ));
                    print('......................................transaction failed');
                  }
                  setState(() {});
                },
                child: Text("Pay"),
              ),
            ],
          )),
    );
  }
}
