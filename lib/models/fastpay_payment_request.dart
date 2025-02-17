
import '../fastpay_flutter_sdk.dart';
import 'fastpay_payment_response.dart';

class FastpayPaymentRequest{
  final String stroreId;
  final String storePassword;
  final String amount;
  final String orderID;
  final String callBackUriIos;
  final String callBackUriAndroid;
  final bool isProduction;
  Function(SDKStatus,String, {FastpayPaymentResponse? result})? callback;

  FastpayPaymentRequest(this.stroreId, this.storePassword, this.amount,
      this.orderID, this.callBackUriIos, this.callBackUriAndroid, this.isProduction, this.callback);
}