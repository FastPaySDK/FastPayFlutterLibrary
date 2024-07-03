import 'dart:async';

import 'package:fastpay_flutter_sdk/fastpay_flutter_sdk.dart';
import 'package:fastpay_flutter_sdk/models/fastpay_payment_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plugin Example App',
      home: MyAppHomePage(),
    );
  }
}

class MyAppHomePage extends StatefulWidget {
  const MyAppHomePage({super.key});

  @override
  State<MyAppHomePage> createState() => _MyAppHomePageState();
}

class _MyAppHomePageState extends State<MyAppHomePage> {
  String _platformVersion = 'Unknown';
  //final _fastpayFlutterSdkPlugin = FastpayFlutterSdk();

  @override
  void initState() {
    super.initState();
    FastpayFlutterSdk.instance.fastpayPaymentRequest = FastpayPaymentRequest(
      "748957_847",
      "v=7bUPTeC2#nQ2-+",
      "450",
      DateTime.now().microsecondsSinceEpoch.toString(),
      "sdk://fastpay-sdk.com/callback",
      false,
          (status,message){
        debugPrint("CALLBACK..................."+message);
        //_showToast(context,message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: InkWell(
            onTap: ()async{
                await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SdkInitializeScreen()));
                debugPrint('PRINT_STACK_TRACE:::Response....................: ${FastpayFlutterSdk.instance.fastpayPaymentResponse.toString()}');
              },
            child: Text('Click here')
        ),
      ),
    );
  }
}
