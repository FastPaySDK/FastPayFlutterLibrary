import 'dart:convert';

import 'package:fastpay_flutter_sdk/fastpay_flutter_sdk.dart';
import 'package:fastpay_flutter_sdk/models/request/payment_initiation_request.dart';
import 'package:fastpay_flutter_sdk/models/response/base_response_model.dart';
import 'package:fastpay_flutter_sdk/models/response/payment_initiation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FastpaySdkController{

  FastpaySdkController._privateConstructor();
  static final FastpaySdkController _instance = FastpaySdkController._privateConstructor();
  static FastpaySdkController get instance => _instance;

  Future<void> initPayment(
      PaymentInitiationRequest paymentInitiationRequest,
      Function(PaymentInitiationResponse paymentInitiationResponse) onSuccess,
      {Function(int code,String message)? onFailed}) async {
    final response = await _executeNetworkRequest(FastpayFlutterSdk.instance.apiInitiate,NetworkRequestType.POST,false,paymentInitiationRequest.toJson());
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

  Future<dynamic> _executeNetworkRequest(
      String networkUrl,
      NetworkRequestType requestType,
      bool isAuthRequired,
      Map<String, dynamic>? requestBody,
      {Function(int code,String message)? onFailed}

  )async{
    bool isProduction = FastpayFlutterSdk.instance.fastpayPaymentRequest?.isProduction??false;
    var url = Uri.parse((isProduction?FastpayFlutterSdk.instance.productionUrl:FastpayFlutterSdk.instance.sandBoxUrl)+FastpayFlutterSdk.instance.apiVersionV1+networkUrl);
    var headers = {
      'Accept':'application/json',
      'Content-Type':'application/json',
    };
    if(isAuthRequired){
      headers['Authorization'] = 'asdasdas';
    }
    var response = (requestType == NetworkRequestType.GET)?await http.get(url, headers: headers):await http.post(url, headers: headers,body: json.encode(requestBody));
    if(response != null){
      if (response.statusCode == 200) {
        var jsonMap = jsonDecode(response.body);
        var data = BaseResponseModel.fromJson(jsonMap);
        if(data.code == 200){
          return data.data;
        }else{
          onFailed?.call(data.code??0,data.message??'');
          return null;
        }
      } else {
        onFailed?.call(response.statusCode,'Something went wrong');
        return null;
      }
    }else{
      onFailed?.call(0,'Something went wrong');
      return null;
    }
  }

}