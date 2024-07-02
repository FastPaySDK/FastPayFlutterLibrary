class BaseResponseModel{
  int? code;
  String? message;
  List<dynamic>? errors;
  dynamic data;

  BaseResponseModel(this.code, this.message, this.errors, this.data);

  BaseResponseModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    errors = json['errors'];
    data = json['data'];
  }

}