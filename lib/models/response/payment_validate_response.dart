/// gw_transaction_id : "CYIILVR004"
/// merchant_order_id : 1723107206912441
/// received_amount : 450.0
/// currency : "IQD"
/// status : "Success"
/// customer_name : "Testing Team"
/// customer_mobile_number : "+9641000000004"
/// at : "2024-08-08 11:55:17"

class PaymentValidateResponse {
  PaymentValidateResponse({
      String? gwTransactionId, 
      String? merchantOrderId,
      double? receivedAmount, 
      String? currency, 
      String? status, 
      String? customerName, 
      String? customerMobileNumber, 
      String? at,}){
    _gwTransactionId = gwTransactionId;
    _merchantOrderId = merchantOrderId;
    _receivedAmount = receivedAmount;
    _currency = currency;
    _status = status;
    _customerName = customerName;
    _customerMobileNumber = customerMobileNumber;
    _at = at;
}

  PaymentValidateResponse.fromJson(dynamic json) {
    _gwTransactionId = json['gw_transaction_id'];
    _merchantOrderId = json['merchant_order_id'];
    _receivedAmount = json['received_amount'];
    _currency = json['currency'];
    _status = json['status'];
    _customerName = json['customer_name'];
    _customerMobileNumber = json['customer_mobile_number'];
    _at = json['at'];
  }
  String? _gwTransactionId;
  String? _merchantOrderId;
  double? _receivedAmount;
  String? _currency;
  String? _status;
  String? _customerName;
  String? _customerMobileNumber;
  String? _at;

  String? get gwTransactionId => _gwTransactionId;
  String? get merchantOrderId => _merchantOrderId;
  double? get receivedAmount => _receivedAmount;
  String? get currency => _currency;
  String? get status => _status;
  String? get customerName => _customerName;
  String? get customerMobileNumber => _customerMobileNumber;
  String? get at => _at;

}