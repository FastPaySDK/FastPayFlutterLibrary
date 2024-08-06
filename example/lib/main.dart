import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
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
    _handleIncomingIntent();
  }

  FastpayResult? _fastpayResult;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

/*  @override
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
            ScaffoldMessenger(
              child: ElevatedButton(
                onPressed: () async {
                  FastpayResult _fastpayResult = await FastPayRequest(
                    storeID: "*****",
                    storePassword: "******",
                    amount: "450",
                    orderID: DateTime.now().microsecondsSinceEpoch.toString(),
                    isProduction: false,
                    callback: (status,message){
                      debugPrint("CALLBACK..................."+message);
                      //_showToast(context,message);
                    }, callbackUri: "sdk://fastpay-sdk.com/callback",
                  );
                  if (_fastpayResult.isSuccess ?? false) {
                    // transaction success
                   // _showToast(context, "transaction success");
                    print(
                        '......................................transaction success');
                  } else {
                    // transaction failed
                    //_showToast(context, "transaction failed");
                    print(
                        '......................................transaction failed');
                  }
                  setState(() {});
                },
                child: Text("Pay"),
              ),
            ),
          ],
        ),
      ),
    );
  }*/






  void _showToast(BuildContext context,String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text(message),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
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

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Plugin Example App',
      home: LauncherScreen(),
    );
  }
}

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fastpay SDK test'),
      ),
      body: Center(
        child: InkWell(
            onTap: ()async{
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MyAppHomePage()));
            },
            child: Text('Click here to initiate')
        ),
      ),
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fastpay SDK test'),
      ),
      body: Center(
        child: Column(
          children: [
            const Center(
              child: Text('Fastpay SDK'),
            ),
            ScaffoldMessenger(
              child: ElevatedButton(
                onPressed: () async {
                  FastpayResult _fastpayResult = await FastPayRequest(
                    storeID: "748957_847",
                    storePassword: "v=7bUPTeC2#nQ2-+",
                    amount: "450",
                    orderID: DateTime.now().microsecondsSinceEpoch.toString(),
                    isProduction: false,
                    callback: (status,message){
                      debugPrint("CALLBACK..................."+message);
                      //_showToast(context,message);
                    }, callbackUri: "sdk://fastpay-sdk.com/callback",
                  );
                  if (_fastpayResult.isSuccess ?? false) {
                    // transaction success
                    // _showToast(context, "transaction success");
                    print(
                        '......................................transaction success');
                  } else {
                    // transaction failed
                    //_showToast(context, "transaction failed");
                    print(
                        '......................................transaction failed');
                  }
                  setState(() {});
                },
                child: Text("Pay"),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*Future<void> _handleIncomingIntent() async {
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
  }*/
}
