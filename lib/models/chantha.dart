class ChanthaDetail {
  String id;
  int amount;
  String effectiveDate;
  String status;
  String remark;

  ChanthaDetail({
    required this.id,
    required this.amount,
    required this.effectiveDate,
    required this.status,
    required this.remark,
  });

  factory ChanthaDetail.fromJson(Map<String, dynamic> json) => ChanthaDetail(
    id: json['_id'],
    amount: json['amount'],
    effectiveDate: json['effectiveDate'],
    status: json['status']?? '',
    remark: json['remark']?? '',
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
      'amount': amount,
      'effectiveDate': effectiveDate,
      'status': status,
      'remark': remark,
  };
}

class ChanthaDetails {
  List<ChanthaDetail> chanthaDetails;

  ChanthaDetails({required this.chanthaDetails});

  factory ChanthaDetails.fromJson(Map<String, dynamic> json) {
    var chanthaDetailList = json['chanthaDetails'] as List<dynamic>?;

    if (chanthaDetailList == null) {
      return ChanthaDetails(chanthaDetails: []);
    }

    List<ChanthaDetail> chanthaDetailsList = chanthaDetailList.map((i) => ChanthaDetail.fromJson(i)).toList();
    return ChanthaDetails(chanthaDetails: chanthaDetailsList);
  }

}
