class PaygateResponse {
  final String? txRef;
  final int? status;

  PaygateResponse({this.status, this.txRef});

  factory PaygateResponse.fromJson(Map<String, dynamic> json) =>
      PaygateResponse(
        txRef: json["tx_reference"],
        status: json['status'],
      );
}
