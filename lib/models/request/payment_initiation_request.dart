class PaymentInitiationRequest{
  final String storeId;
  final String storePassword;
  final String billAmount;
  final String orderId;
  final String currency;


  PaymentInitiationRequest(this.storeId, this.storePassword, this.billAmount,
      this.orderId, this.currency);

  Map<String, dynamic> toJson() {
    return {
      'storeId': storeId,
      'storePassword': storePassword,
      'billAmount': billAmount,
      'orderId': orderId,
      'currency': currency,
    };
  }
}