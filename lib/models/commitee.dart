class CommiteeDetail {
  String id;
  bool isAddAttendance;
  int fineAmount;
  String title;
  String meetingDate;
  String status;
  String remark;
  String description;

  CommiteeDetail({
    required this.id,
    required this.isAddAttendance,
    required this.fineAmount,
    required this.title,
    required this.meetingDate,
    required this.status,
    required this.remark,
    required this.description
  });

  factory CommiteeDetail.fromJson(Map<String, dynamic> json) => CommiteeDetail(
    id: json['_id'],
    fineAmount: json['fineAmount']?? '',
    meetingDate: json['meetingDate']?? '',
    status: json['status'] ?? '',
    remark: json['remark'] ?? '',
    isAddAttendance: json['isAddAttendance'] ?? false,
    title: json['title'] ?? '',
    description: json['description'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'fineAmount': fineAmount,
    'meetingDate': meetingDate,
    'status': status,
    'remark': remark,
    'isAddAttendance': isAddAttendance,
    'title': title,
    'description': description,
  };
}

class CommiteeDetails {
  List<CommiteeDetail> commiteeDetails;

  CommiteeDetails({required this.commiteeDetails});

  factory CommiteeDetails.fromJson(Map<String, dynamic> json) {
    var commiteeDetailList = json['commiteeDetails'] as List<dynamic>?;

    if (commiteeDetailList == null) {
      return CommiteeDetails(commiteeDetails: []);
    }

    List<CommiteeDetail> commiteeDetailsList = commiteeDetailList.map((i) => CommiteeDetail.fromJson(i)).toList();
    return CommiteeDetails(commiteeDetails: commiteeDetailsList);
  }

}
