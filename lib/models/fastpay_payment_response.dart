class FastpayPaymentResponse{
  String? _transactionStatus;
  String? _transactionId;
  String? _orderId;
  String? _paymentAmount;
  String? _paymentCurrency;
  String? _payeeName;
  String? _payeeMobileNumber;
  String? _paymentTime;


  FastpayPaymentResponse(
      this._transactionStatus,
      this._transactionId,
      this._orderId,
      this._paymentAmount,
      this._paymentCurrency,
      this._payeeName,
      this._payeeMobileNumber,
      this._paymentTime
      );

  String? get transactionStatus => _transactionStatus;

  set transactionStatus(String? value) {
    _transactionStatus = value;
  }

  String? get transactionId => _transactionId;

  String? get paymentTime => _paymentTime;

  set paymentTime(String? value) {
    _paymentTime = value;
  }

  String? get payeeMobileNumber => _payeeMobileNumber;

  set payeeMobileNumber(String? value) {
    _payeeMobileNumber = value;
  }

  String? get payeeName => _payeeName;

  set payeeName(String? value) {
    _payeeName = value;
  }

  String? get paymentCurrency => _paymentCurrency;

  set paymentCurrency(String? value) {
    _paymentCurrency = value;
  }

  String? get paymentAmount => _paymentAmount;

  set paymentAmount(String? value) {
    _paymentAmount = value;
  }

  String? get orderId => _orderId;

  set orderId(String? value) {
    _orderId = value;
  }

  set transactionId(String? value) {
    _transactionId = value;
  }

  @override
  String toString() {
    return 'FastpayPaymentResponse{_transactionStatus: $_transactionStatus, _transactionId: $_transactionId, _orderId: $_orderId, _paymentAmount: $_paymentAmount, _paymentCurrency: $_paymentCurrency, _payeeName: $_payeeName, _payeeMobileNumber: $_payeeMobileNumber, _paymentTime: $_paymentTime}';
  }
}