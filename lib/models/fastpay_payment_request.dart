import 'package:fastpay_flutter_sdk/models/fastpay_payment_response.dart';

import '../fastpay_flutter_sdk.dart';

class FastpayPaymentRequest{
  /*
  * required String storeID,
  required String storePassword,
  required String amount,
  required String orderID,
  required String callbackUri,
  bool isProduction = false,

  Function(SDKStatus,String)? callback*/
  final String stroreId;
  final String storePassword;
  final String amount;
  final String orderID;
  final String callbackUri;
  final bool isProduction;
  Function(SDKStatus,String, {FastpayPaymentResponse? result})? callback;

  FastpayPaymentRequest(this.stroreId, this.storePassword, this.amount,
      this.orderID, this.callbackUri, this.isProduction, this.callback);
}