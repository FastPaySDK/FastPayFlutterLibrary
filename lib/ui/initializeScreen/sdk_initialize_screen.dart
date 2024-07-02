import 'dart:async';


import 'package:fastpay_flutter_sdk/ui/widget/text_style.dart';

import 'package:fastpay_flutter_sdk/fastpay_flutter_sdk.dart';
import 'package:fastpay_flutter_sdk/models/fastpay_payment_request.dart';
import 'package:fastpay_flutter_sdk/models/request/payment_initiation_request.dart';
import 'package:fastpay_flutter_sdk/services/fastpay_sdk_controller.dart';
import 'package:flutter/material.dart';

import '../paymentScreen/payment_screen.dart';

class SdkInitializeScreen extends StatefulWidget {

  final FastpayPaymentRequest fastpayPaymentRequest;

  const SdkInitializeScreen(this.fastpayPaymentRequest,{super.key});

  @override
  State<SdkInitializeScreen> createState() => _SdkInitializeScreenState();
}

class _SdkInitializeScreenState extends State<SdkInitializeScreen> {

  @override
  void initState() {
    super.initState();
    FastpayFlutterSdk.instance.fastpayPaymentRequest = widget.fastpayPaymentRequest;
    FastpaySdkController.instance.initPayment(
      PaymentInitiationRequest(
          widget.fastpayPaymentRequest.stroreId,
          widget.fastpayPaymentRequest.storePassword,
          widget.fastpayPaymentRequest.amount,
          widget.fastpayPaymentRequest.orderID,
          'IQD'
      ),(){

    }
    );
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
              Text('Initiating...',style: getTextStyle(textSize: 12),)
            ],
          ),
        ),
      ),
    ));
  }
}
