import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/fastpay_payment_request.dart';
import 'models/fastpay_payment_response.dart';
import 'models/response/payment_initiation_response.dart';

export 'ui/initializeScreen/sdk_initialize_screen.dart';

enum SDKStatus{
  INIT,
  PAYMENT_WITH_FASTPAY_APP,
  PAYMENT_WITH_FASTPAY_SDK,
  CANCEL,
  SUCCESS,
  FAILED
}

enum NetworkRequestType{
  GET,
  POST
}

class FastpayFlutterSdk{

  FastpayFlutterSdk._privateConstructor();
  static final FastpayFlutterSdk _instance = FastpayFlutterSdk._privateConstructor();
  static FastpayFlutterSdk get instance => _instance;

  Timer? _timer;
  int _start = 20;

  BuildContext? _context;

  FastpayPaymentRequest? _fastpayPaymentRequest;
  PaymentInitiationResponse? _paymentInitiationResponse;
  String? _apiToken;
  bool _isTermsAndConditionPage = false;

  final String _sandBoxUrl = "https://staging-apigw-sdk.fast-pay.iq/";
  final String _productionUrl = "https://apigw-sdk.fast-pay.iq/";
  final String _apiVersionV1 = "api/v1/";
  final String _apiVersionV2 = "api/v2/";
  final String _apiInitiate = "public/sdk/payment/initiation";
  final String _apiPayment = "public/sdk/payment/pay";
  final String _apiSendOtp = "public/sdk/payment/pay/send-otp";
  final String _apiPaymentWithOtpVerification = "public/sdk/payment/pay/do-payment";
  final String _apiValidate = "public/sdk/payment/validate";


  FastpayPaymentRequest? get fastpayPaymentRequest => _fastpayPaymentRequest;

  set fastpayPaymentRequest(FastpayPaymentRequest? value) {
    _fastpayPaymentRequest = value;
  }

  set apiToken(String value) {
    _apiToken = value;
  }


  set context(BuildContext value) {
    _context = value;
  }


  set isTermsAndConditionPage(bool value) {
    _isTermsAndConditionPage = value;
  }

  String get apiToken => _apiToken??'';

  String get productionUrl => _productionUrl;

  String get sandBoxUrl => _sandBoxUrl;

  String get apiValidate => _apiValidate;

  String get apiPaymentWithOtpVerification => _apiPaymentWithOtpVerification;

  String get apiSendOtp => _apiSendOtp;

  String get apiPayment => _apiPayment;

  String get apiInitiate => _apiInitiate;

  String get apiVersionV2 => _apiVersionV2;

  String get apiVersionV1 => _apiVersionV1;

  PaymentInitiationResponse? get paymentInitiationResponse =>
      _paymentInitiationResponse;

  set paymentInitiationResponse(PaymentInitiationResponse? value) {
    _paymentInitiationResponse = value;
  }

  void startTimer() {
    _start = (_fastpayPaymentRequest?.isProduction == true)?(2*60):(5*50);
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec, (Timer timer) {
        if (_start == 0) {
          fastpayPaymentRequest?.callback?.call(SDKStatus.CANCEL,'Request time out');
          debugPrint('.............timer is finished');
          dispose(null);
        } else {
          _start--;
        }
      },
    );
  }

  void dispose(FastpayPaymentResponse? response){
    _start = (_fastpayPaymentRequest?.isProduction == true)?(2*60):(5*50);
    try{
      if(_isTermsAndConditionPage){
        Navigator.of(_context!).pop();
      }
      Navigator.of(_context!).pop();
      _timer?.cancel();
    }catch(e){
      Navigator.of(_context!).pop();
    }
  }
}