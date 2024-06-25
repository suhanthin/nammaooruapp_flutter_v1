class ChanthaHistory {
  final String id;
  final List<Record> records;

  ChanthaHistory({
    required this.id,
    required this.records,
  });

  factory ChanthaHistory.fromJson(Map<String, dynamic> json) {
    return ChanthaHistory(
      id: json['_id'],
      records: List<Record>.from(json['records'].map((record) => Record.fromJson(record))),
    );
  }
}

class Record {
  final String id;
  final String chanthaId;
  final String userId;
  final String addedDate;
  final int amount;
  final String effectiveDate;
  final String status;
  final String remark;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  final String paidDate;
  final String memberId;
  final String firstname;
  final String lastname;
  final String phoneno;
  final String payeefirstname;
  final String payeelastname;
  final String payeeposition;

  Record({
    required this.id,
    required this.chanthaId,
    required this.userId,
    required this.addedDate,
    required this.amount,
    required this.effectiveDate,
    required this.status,
    required this.remark,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.paidDate,
    required this.memberId,
    required this.firstname,
    required this.lastname,
    required this.phoneno,
    required this.payeefirstname,
    required this.payeelastname,
    required this.payeeposition,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['_id'],
      chanthaId: json['chantha_id'],
      userId: json['user_id'],
      addedDate: json['addedDate'],
      amount: json['amount'],
      effectiveDate: json['effectiveDate'],
      status: json['status'],
      remark: json['remark'],
      createdBy: json['created_by'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      paidDate: json['paidDate'],
      memberId: json['memberId'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phoneno: json['phoneno'],
      payeefirstname: json['payeefirstname'],
      payeelastname: json['payeelastname'],
      payeeposition: json['payeeposition'],
    );
  }
}
