class CustomMemberDetail {
  String id;
  //String member_id;
  String memberId;
  String firstname;
  String lastname;
  String status;
  bool attendance;

  CustomMemberDetail({
    required this.id,
    //required this.member_id,
    required this.memberId,
    required this.firstname,
    required this.lastname,
    required this.status,
    required this.attendance,
  });

  factory CustomMemberDetail.fromJson(Map<String, dynamic> json) => CustomMemberDetail(
    id: json["_id"],
    //member_id: json["member_id"],
    memberId: json["memberId"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    status: json["status"]?? '',
    attendance: json["attendance"]?? false,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    //"member_id": member_id,
    "memberId": memberId,
    "firstname": firstname,
    "lastname": lastname,
    "status": status,
    "attendance": attendance,
  };
}

class CustomMemberDetails {
  List<CustomMemberDetail> customMemberDetails;

  CustomMemberDetails({required this.customMemberDetails});

  factory CustomMemberDetails.fromJson(Map<String, dynamic> json) {
    var customMemberDetailList = json['userDetails'] as List<dynamic>?;

    if (customMemberDetailList == null) {
      return CustomMemberDetails(customMemberDetails: []);
    }

    List<CustomMemberDetail> customMemberDetailsList = customMemberDetailList.map((i) => CustomMemberDetail.fromJson(i)).toList();
    return CustomMemberDetails(customMemberDetails: customMemberDetailsList);
  }

}
