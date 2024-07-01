import 'dart:async';

import 'package:flutter/material.dart';

import '../paymentScreen/payment_screen.dart';

class SdkInitializeScreen extends StatefulWidget {
  const SdkInitializeScreen({super.key});

  @override
  State<SdkInitializeScreen> createState() => _SdkInitializeScreenState();
}

class _SdkInitializeScreenState extends State<SdkInitializeScreen> {

  @override
  void initState() {
    super.initState();
    /*Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PaymentScreen()),
      );
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/1.5),
          child: Column(
            children: [
              Image.asset(AssetImage("assets/ic_logo.png").assetName, package: 'fastpay_flutter_sdk',width: MediaQuery.of(context).size.width/3,),
              const SizedBox(height: 25,),
              const Text('Initiating...')
            ],
          ),
        ),
      ),
    ));
  }
}
