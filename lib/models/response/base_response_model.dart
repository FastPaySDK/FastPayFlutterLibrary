/// code : 200
/// message : "Payment Initiated"
/// errors : []
/// data : {"storeName":"Test Merchant","storeLogo":null,"orderId":"1719913203750777","billAmount":450.0,"currency":"IQD","token":"159706be-63b4-43f4-ab14-1ba3dee35fb2","qrToken":"0002010102120213964171638458952044829530336854034505802IQ5913Test Merchant6005Erbil6105440016232011617199132037507770808PURCHASE6304A424"}

class BaseResponseModel {
  BaseResponseModel({
      int? code, 
      String? message, 
      List<dynamic>? errors,
      dynamic data,}){
    _code = code;
    _message = message;
    _errors = errors;
    _data = data;
}

  BaseResponseModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['errors'] != null) {
      _errors = [];
      json['errors'].forEach((v) {
        _errors?.add(v);
      });
    }
    _data = json['data'];
  }
  int? _code;
  String? _message;
  List<dynamic>? _errors;
  dynamic _data;

  int? get code => _code;
  String? get message => _message;
  List<dynamic>? get errors => _errors;
  dynamic get data => _data;

}
