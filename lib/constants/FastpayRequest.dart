import 'Environment.dart';

class FastpayRequest {
  String storeId;
  String storePassword;
  String amount;
  String orderId;
  Environment environment;

  FastpayRequest({
    required this.storeId,
    required this.storePassword,
    required this.amount,
    required this.orderId,
    required this.environment,
  });

  String get getStoreId => storeId;

  set setStoreId(String storeId) {
    this.storeId = storeId;
  }

  String get getStorePassword => storePassword;

  set setStorePassword(String storePassword) {
    this.storePassword = storePassword;
  }

  String get getAmount => amount;

  set setAmount(String amount) {
    this.amount = amount;
  }

  String get getOrderId => orderId;

  set setOrderId(String orderId) {
    this.orderId = orderId;
  }

  Environment get getEnvironment => environment;

  set setEnvironment(Environment environment) {
    this.environment = environment;
  }
}