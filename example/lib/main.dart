import 'dart:async';
import 'dart:io';

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

class _MyAppHomePageState extends State<MyAppHomePage> with WidgetsBindingObserver {
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _handleIncomingIntent();
    FastpayFlutterSdk.instance.fastpayPaymentRequest = FastpayPaymentRequest(
      "*****",
      "*****",
      "450",
      DateTime.now().microsecondsSinceEpoch.toString(),
      "sdk://test-sdk.com/callback",
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
    FastpayFlutterSdk.instance.context = context;
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
    if(Platform.isAndroid){
      final uri = await _appLinks.getLatestAppLink();
      debugPrint("Redirect URI: ${uri?.queryParameters}");
      final allQueryParams = uri?.queryParameters;
      final status = allQueryParams?['status'];
      final orderId = allQueryParams?['order_id'];
      debugPrint("..........................STATUS::: $status, OrderId:::$orderId");
    }else if(Platform.isIOS){
      final appLink = await _appLinks.getInitialAppLink();
      if (appLink != null) {
        var uri = Uri.parse(appLink.toString());
        debugPrint(' here you can redirect from url as per your need ');
      }
      _linkSubscription = _appLinks.uriLinkStream.listen((uriValue) {
        debugPrint('.................$uriValue');
        debugPrint(' you will listen any url updates ');
        debugPrint(' here you can redirect from url as per your need ');
      },onError: (err){
        debugPrint('====>>> error : $err');
      },onDone: () {
        _linkSubscription?.cancel();
      },);
    }
  }
}