/// summary : {"recipient":{"name":"TestMerchant","mobile_number":"+9641716384589","avatar":"https: //staging-asset.fast-pay.iq/apigw-merchant/version20/users/logos/628a0ee995042VlAKu1653214953.png"},"invoice_id":"CYHDKNR434"}

class PaymentSuccessResponse {
  PaymentSuccessResponse({
      Summary? summary,}){
    _summary = summary;
}

  PaymentSuccessResponse.fromJson(dynamic json) {
    _summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
  }
  Summary? _summary;

  Summary? get summary => _summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_summary != null) {
      map['summary'] = _summary?.toJson();
    }
    return map;
  }

}

/// recipient : {"name":"TestMerchant","mobile_number":"+9641716384589","avatar":"https: //staging-asset.fast-pay.iq/apigw-merchant/version20/users/logos/628a0ee995042VlAKu1653214953.png"}
/// invoice_id : "CYHDKNR434"

class Summary {
  Summary({
      Recipient? recipient, 
      String? invoiceId,}){
    _recipient = recipient;
    _invoiceId = invoiceId;
}

  Summary.fromJson(dynamic json) {
    _recipient = json['recipient'] != null ? Recipient.fromJson(json['recipient']) : null;
    _invoiceId = json['invoice_id'];
  }
  Recipient? _recipient;
  String? _invoiceId;

  Recipient? get recipient => _recipient;
  String? get invoiceId => _invoiceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_recipient != null) {
      map['recipient'] = _recipient?.toJson();
    }
    map['invoice_id'] = _invoiceId;
    return map;
  }

}

/// name : "TestMerchant"
/// mobile_number : "+9641716384589"
/// avatar : "https: //staging-asset.fast-pay.iq/apigw-merchant/version20/users/logos/628a0ee995042VlAKu1653214953.png"

class Recipient {
  Recipient({
      String? name, 
      String? mobileNumber, 
      String? avatar,}){
    _name = name;
    _mobileNumber = mobileNumber;
    _avatar = avatar;
}

  Recipient.fromJson(dynamic json) {
    _name = json['name'];
    _mobileNumber = json['mobile_number'];
    _avatar = json['avatar'];
  }
  String? _name;
  String? _mobileNumber;
  String? _avatar;

  String? get name => _name;
  String? get mobileNumber => _mobileNumber;
  String? get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['mobile_number'] = _mobileNumber;
    map['avatar'] = _avatar;
    return map;
  }

}