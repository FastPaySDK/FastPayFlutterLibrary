import 'dart:convert';

import 'package:fastpay_merchant//fastpay_flutter_sdk.dart';
import 'package:fastpay_merchant/models/request/payment_initiation_request.dart';
import 'package:fastpay_merchant/models/request/payment_send_otp_request.dart';
import 'package:fastpay_merchant/models/response/base_response_model.dart';
import 'package:fastpay_merchant/models/response/payment_initiation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/response/payment_success_response.dart';

class FastpaySdkController{

  FastpaySdkController._privateConstructor();
  static final FastpaySdkController _instance = FastpaySdkController._privateConstructor();
  static FastpaySdkController get instance => _instance;

  Future<void> initPayment(
      PaymentInitiationRequest paymentInitiationRequest,
      Function(PaymentInitiationResponse paymentInitiationResponse) onSuccess,
      {Function(int code,String message)? onFailed}) async {
    final response = await _executeNetworkRequest(FastpayFlutterSdk.instance.apiInitiate,NetworkRequestType.POST,paymentInitiationRequest.toJson(),onFailed: onFailed);
    if(response != null){
      try{
        var data = PaymentInitiationResponse.fromJson(response);
        FastpayFlutterSdk.instance.apiToken = data.token??'';
        onSuccess.call(data);
      }catch(e){
        onFailed?.call(0,'Something went wrong');
      }
    }
  }

  Future<void> sendOtp(
      PaymentSendOtpRequest paymentSendOtpRequest,
      Function(String message) onSuccess,
      {Function(int code,String message)? onFailed}) async {
    final response = await _executeNetworkRequest(FastpayFlutterSdk.instance.apiSendOtp,NetworkRequestType.POST,paymentSendOtpRequest.toJson(),onFailed: onFailed,isVersion2: true,isEmptyBody: true);
    if(response != null){
      try{
        onSuccess.call(response);
      }catch(e){
        onFailed?.call(0,'Something went wrong');
      }
    }
  }

  Future<void> payWithOtp(
      PaymentSendOtpRequest paymentSendOtpRequest,
      Function(PaymentSuccessResponse message) onSuccess,
      {Function(int code,String message)? onFailed}) async {
    final response = await _executeNetworkRequest(FastpayFlutterSdk.instance.apiPaymentWithOtpVerification,NetworkRequestType.POST,paymentSendOtpRequest.toJson(),onFailed: onFailed,isVersion2: true,isEmptyBody: false);
    if(response != null){
      try{
        var data = PaymentSuccessResponse.fromJson(response);
        onSuccess.call(data);
      }catch(e){
        onFailed?.call(0,'Something went wrong');
      }
    }
  }

  Future<dynamic> _executeNetworkRequest(
      String networkUrl,
      NetworkRequestType requestType,
      Map<String, dynamic>? requestBody,
      {Function(int code,String message)? onFailed,bool isEmptyBody = false, bool isVersion2 = false}

  )async{
    bool isProduction = FastpayFlutterSdk.instance.fastpayPaymentRequest?.isProduction??false;
    var url = Uri.parse((isProduction?FastpayFlutterSdk.instance.productionUrl:FastpayFlutterSdk.instance.sandBoxUrl)+((isVersion2)?FastpayFlutterSdk.instance.apiVersionV2:FastpayFlutterSdk.instance.apiVersionV1)+networkUrl);
    var headers = {
      'Accept':'application/json',
      'Content-Type':'application/json',
    };
    debugPrint('PRINT_STACK_TRACE::URL...........................: ${url.toString()}');
    debugPrint('PRINT_STACK_TRACE::Request.......................: ${json.encode(requestBody)}');
    var response = (requestType == NetworkRequestType.GET)?await http.get(url, headers: headers):await http.post(url, headers: headers,body: json.encode(requestBody));
    if(response != null){
      var jsonMap = jsonDecode(response.body);
      var data = BaseResponseModel.fromJson(jsonMap);
      debugPrint('PRINT_STACK_TRACE::Response(${response.statusCode}).....................: ${data.toString()}');
      if (response.statusCode == 200) {
        if(data.code == 200){
          if(isEmptyBody) {
            return data.message;
          }
          return data.data;
        }else{
          onFailed?.call(data.code??0,(data.errors??[]).join("/n"));
          return null;
        }
      } else {
        onFailed?.call(data.code??0,(data.errors??[]).join("/n"));
        return null;
      }
    }else{
      onFailed?.call(0,'Something went wrong');
      return null;
    }
  }

}