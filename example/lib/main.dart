import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:fastpay_merchant/fastpay_flutter_sdk.dart';
import 'package:fastpay_merchant/models/fastpay_payment_request.dart';
import 'package:flutter/material.dart';

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
    _handleIncomingIntent();
    FastpayFlutterSdk.instance.fastpayPaymentRequest = FastpayPaymentRequest(
      "748957_847",
      "v=7bUPTeC2#nQ2-+",
      "450",
      DateTime.now().microsecondsSinceEpoch.toString(),
      "sdk://fastpay-sdk.com/callback",
      "appfpclientFastpayFlutterSdk",
      false,
          (status, message, {result}) {
        debugPrint('PRINT_STACK_TRACE::MESSAGE.....................: ${message}');
        debugPrint('PRINT_STACK_TRACE.....................: ${result.toString()}');
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
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SdkInitializeScreen()));
            },
            child: Text('Click here')
        ),
      ),
    );
  }

  Future<void> _handleIncomingIntent() async {
    final _appLinks = AppLinks();
    final uri = await _appLinks.getLatestAppLink();
    final allQueryParams = uri?.queryParameters;
    final status = allQueryParams?['status'];
    final orderId = allQueryParams?['order_id'];
    debugPrint("..........................STATUS::: "+status.toString()+", OrderId:::"+orderId.toString());
  }
}