/// mobile_number : "+9641200000009"
/// order_id : "AU1212129093e4"
/// password : "Password400@"
/// token : "0002010102120213964751610627052044829530336854032615802IQ5909DalkurdFF6005Erbil61054400162300114AU1212129093e40808PURCHASE6304B75A"

class PaymentSendOtpRequest {
  PaymentSendOtpRequest({
      String? mobileNumber, 
      String? orderId, 
      String? password, 
      String? otp,
      String? token,}){
    _mobileNumber = mobileNumber;
    _orderId = orderId;
    _password = password;
    _otp = otp;
    _token = token;
}

  PaymentSendOtpRequest.fromJson(dynamic json) {
    _mobileNumber = json['mobile_number'];
    _orderId = json['order_id'];
    _password = json['password'];
    _otp = json['otp'];
    _token = json['token'];
  }
  String? _mobileNumber;
  String? _orderId;
  String? _password;
  String? _otp;
  String? _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = _mobileNumber;
    map['order_id'] = _orderId;
    map['password'] = _password;
    map['token'] = _token;
    if(_otp != null) {
      map['otp'] = _otp;
    }
    return map;
  }

  set token(String? value) {
    _token = value;
  }

  set otp(String? value) {
    _otp = value;
  }

  set password(String? value) {
    _password = value;
  }

  set orderId(String? value) {
    _orderId = value;
  }

  set mobileNumber(String? value) {
    _mobileNumber = value;
  }

  String? get token => _token;

  String? get otp => _otp;

  String? get password => _password;

  String? get orderId => _orderId;

  String? get mobileNumber => _mobileNumber;
}