class PaymentValidateRequest{
  final String storeId;
  final String storePassword;
  final String orderId;


  PaymentValidateRequest(this.storeId, this.storePassword,
      this.orderId);

  Map<String, dynamic> toJson() {
    return {
      'storeId': storeId,
      'storePassword': storePassword,
      'orderId': orderId,
    };
  }
}