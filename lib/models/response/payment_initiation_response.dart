/// storeName : "Test Merchant"
/// storeLogo : null
/// orderId : "AU1212129093e4"
/// billAmount : 261.0
/// currency : "IQD"
/// token : "36934da3-cd1e-446e-b4f2-09dd3ec0a407"
/// qrToken : "0002010102120213964171638458952044829530336854032615802IQ5913Test Merchant6005Erbil61054400162300114AU1212129093e40808PURCHASE6304EA61"

class PaymentInitiationResponse {
  PaymentInitiationResponse({
      String? storeName, 
      dynamic storeLogo, 
      String? orderId, 
      double? billAmount, 
      String? currency, 
      String? token, 
      String? qrToken,}){
    _storeName = storeName;
    _storeLogo = storeLogo;
    _orderId = orderId;
    _billAmount = billAmount;
    _currency = currency;
    _token = token;
    _qrToken = qrToken;
}

  PaymentInitiationResponse.fromJson(dynamic json) {
    _storeName = json['storeName'];
    _storeLogo = json['storeLogo'];
    _orderId = json['orderId'];
    _billAmount = json['billAmount'];
    _currency = json['currency'];
    _token = json['token'];
    _qrToken = json['qrToken'];
  }
  String? _storeName;
  dynamic _storeLogo;
  String? _orderId;
  double? _billAmount;
  String? _currency;
  String? _token;
  String? _qrToken;

  String? get storeName => _storeName;
  dynamic get storeLogo => _storeLogo;
  String? get orderId => _orderId;
  double? get billAmount => _billAmount;
  String? get currency => _currency;
  String? get token => _token;
  String? get qrToken => _qrToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['storeName'] = _storeName;
    map['storeLogo'] = _storeLogo;
    map['orderId'] = _orderId;
    map['billAmount'] = _billAmount;
    map['currency'] = _currency;
    map['token'] = _token;
    map['qrToken'] = _qrToken;
    return map;
  }

}