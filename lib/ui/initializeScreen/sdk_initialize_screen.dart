
import 'dart:io';

import 'package:fastpay_flutter_sdk/fastpay_flutter_sdk.dart';
import 'package:fastpay_flutter_sdk/models/request/payment_initiation_request.dart';
import 'package:fastpay_flutter_sdk/services/fastpay_sdk_controller.dart';
import 'package:fastpay_flutter_sdk/ui/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../paymentScreen/payment_screen.dart';

class SdkInitializeScreen extends StatefulWidget {

  //final FastpayPaymentRequest fastpayPaymentRequest;

  const SdkInitializeScreen({super.key});

  @override
  State<SdkInitializeScreen> createState() => _SdkInitializeScreenState();
}

class _SdkInitializeScreenState extends State<SdkInitializeScreen> {

  @override
  void initState() {
    super.initState();
    FastpayFlutterSdk.instance.startTimer();
    FastpayFlutterSdk.instance.context = context;
    var paymentRequest = FastpayFlutterSdk.instance.fastpayPaymentRequest;
    var errorList = <String>[];
    if(paymentRequest?.stroreId == null || paymentRequest?.stroreId.isEmpty == true){
      //FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.CANCEL,'Order id is empty');
      errorList.add('Store id is empty');
    }
    if(paymentRequest?.storePassword == null || paymentRequest?.storePassword.isEmpty == true){
      errorList.add('Store password is empty');
    }
    if(paymentRequest?.orderID == null || paymentRequest?.orderID.isEmpty == true){
      errorList.add('Order id is empty');
    }
    if(paymentRequest?.amount == null || paymentRequest?.amount.isEmpty == true){
      errorList.add('Amount is empty');
    }
    if(errorList.isEmpty){
      FastpaySdkController.instance.initPayment(
          PaymentInitiationRequest(
              paymentRequest?.stroreId??'',
              paymentRequest?.storePassword??'',
              paymentRequest?.amount??'',
              paymentRequest?.orderID??'',
              'IQD'
          ),(response)async{
            FastpayFlutterSdk.instance.paymentInitiationResponse = response;
              try{

                if (Platform.isAndroid){
                  var isAppInstalled = await LaunchApp.isAppInstalled(
                      androidPackageName: 'com.sslwireless.fastpay'
                  );
                  if(isAppInstalled){
                    FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.PAYMENT_WITH_FASTPAY_APP,'Payment is redirected to fastpay application');
                    final Uri _url = Uri.parse('appFpp://fast-pay.cash/qrpay?qrData=${response.qrToken}');
                    await launchUrl(_url);
                  }else{
                    FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.PAYMENT_WITH_FASTPAY_SDK,'Fastpay payment processing with fastpay SDK');
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PaymentScreen(response)));
                  }
                }else{
                  FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.PAYMENT_WITH_FASTPAY_APP,'Payment is redirected to fastpay application');
                  final Uri _url = Uri.parse('appFpp://fast-pay.cash/qrpay?qrData=${response.qrToken}');
                  await launchUrl(_url);
                }

              }catch(e){
                FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.PAYMENT_WITH_FASTPAY_SDK,'Fastpay payment processing with fastpay SDK');
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PaymentScreen(response)));
              }
          },
          onFailed: (code,message){
            FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.CANCEL,'Payment initialization failed');
            Navigator.pop(context);
          }
      );
    }else{
      FastpayFlutterSdk.instance.fastpayPaymentRequest?.callback?.call(SDKStatus.CANCEL,errorList.join(","));
      Navigator.pop(context);
    }

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