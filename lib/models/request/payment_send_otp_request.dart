/// mobile_number : "+9641200000009"
/// order_id : "AU1212129093e4"
/// password : "Password400@"
/// token : "0002010102120213964751610627052044829530336854032615802IQ5909DalkurdFF6005Erbil61054400162300114AU1212129093e40808PURCHASE6304B75A"

class PaymentSendOtpRequest {
  PaymentSendOtpRequest({
      String? mobileNumber, 
      String? orderId, 
      String? password, 
      String? token,}){
    _mobileNumber = mobileNumber;
    _orderId = orderId;
    _password = password;
    _token = token;
}

  PaymentSendOtpRequest.fromJson(dynamic json) {
    _mobileNumber = json['mobile_number'];
    _orderId = json['order_id'];
    _password = json['password'];
    _token = json['token'];
  }
  String? _mobileNumber;
  String? _orderId;
  String? _password;
  String? _token;

  String? get mobileNumber => _mobileNumber;
  String? get orderId => _orderId;
  String? get password => _password;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = _mobileNumber;
    map['order_id'] = _orderId;
    map['password'] = _password;
    map['token'] = _token;
    return map;
  }

}