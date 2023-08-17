class PaygateRequest {
  final int txRef;
  final int status;

  PaygateRequest({required this.status, required this.txRef});

  factory PaygateRequest.fromJson(Map<String, dynamic> json) => PaygateRequest(
        txRef: json["tx_reference"],
        status: json['status'],
      );
}
