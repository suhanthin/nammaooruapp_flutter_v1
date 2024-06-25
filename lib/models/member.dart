class MemberDetail {
  String id;
  String memberId;
  String username;
  String password;
  String roleName;
  bool isAdministrator;
  String position;
  bool isChitCommitteeMember;
  String chitCommitteePosition;
  String firstname;
  String lastname;
  String phoneno;
  String fathername;
  String mothername;
  String gender;
  String avatar;
  String address;
  String dob;
  int balanceTribute;
  String userType;
  String usertypeSavedhalf;
  String userTypefullchangedDate;
  String maritalStatus;
  String maritalStatusSavedsingle;
  String maritalchangedDate;
  String memberType;
  String memberTypeSavedbclass;
  String memberTypebclasschangedDate;
  String memberTypebclassAddedDate;
  String memberTypeSavedcclass;
  String identityProof;
  String identityProofNo;
  String nationality;
  String qualification;
  String jobType;
  String jobportal;
  String jobdetails;
  String familyId;
  String status;
  String remark;
  String token;
  String refreshToken;

  MemberDetail({
    required this.id,
    required this.memberId,
    required this.username,
    required this.password,
    required this.roleName,
    required this.isAdministrator,
    required this.position,
    required this.isChitCommitteeMember,
    required this.chitCommitteePosition,
    required this.firstname,
    required this.lastname,
    required this.phoneno,
    required this.fathername,
    required this.mothername,
    required this.gender,
    required this.avatar,
    required this.address,
    required this.dob,
    required this.balanceTribute,
    required this.userType,
    required this.usertypeSavedhalf,
    required this.userTypefullchangedDate,
    required this.maritalStatus,
    required this.maritalStatusSavedsingle,
    required this.maritalchangedDate,
    required this.memberType,
    required this.memberTypeSavedbclass,
    required this.memberTypebclasschangedDate,
    required this.memberTypebclassAddedDate,
    required this.memberTypeSavedcclass,
    required this.identityProof,
    required this.identityProofNo,
    required this.nationality,
    required this.qualification,
    required this.jobType,
    required this.jobportal,
    required this.jobdetails,
    required this.familyId,
    required this.status,
    required this.remark,
    required this.token,
    required this.refreshToken,
  });

  factory MemberDetail.fromJson(Map<String, dynamic> json) => MemberDetail(
    id: json["_id"],
    memberId: json["memberId"],
    username: json["username"],
    password: json["password"],
    roleName: json["roleName"],
    isAdministrator: json["isAdministrator"],
    position: json["position"],
    isChitCommitteeMember: json["isChitCommitteeMember"],
    chitCommitteePosition: json["chitCommitteePosition"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phoneno: json["phoneno"],
    fathername: json["fathername"],
    mothername: json["mothername"],
    gender: json["gender"],
    avatar: json["avatar"] ?? '',
    address: json["address"]?? '',
    dob: json["dob"]?? '',
    balanceTribute: json["balanceTribute"]?? '',
    userType: json["userType"]?? '',
    usertypeSavedhalf: json["usertypeSavedhalf"]?? '',
    userTypefullchangedDate: json["userTypefullchangedDate"]?? '',
    maritalStatus: json["maritalStatus"]?? '',
    maritalStatusSavedsingle: json["maritalStatusSavedsingle"]?? '',
    maritalchangedDate: json["maritalchangedDate"]?? '',
    memberType: json["memberType"]?? '',
    memberTypeSavedbclass: json["memberTypeSavedbclass"]?? '',
    memberTypebclasschangedDate: json["memberTypebclasschangedDate"]?? '',
    memberTypebclassAddedDate: json["memberTypebclassAddedDate"]?? '',
    memberTypeSavedcclass: json["memberTypeSavedcclass"]?? '',
    identityProof: json["identityProof"]?? '',
    identityProofNo: json["identityProofNo"]?? '',
    nationality: json["nationality"]?? '',
    qualification: json["qualification"]?? '',
    jobType: json["jobType"]?? '',
    jobportal: json["jobportal"]?? '',
    jobdetails: json["jobdetails"]?? '',
    familyId: json["familyId"]?? '',
    status: json["status"]?? '',
    remark: json["remark"]?? '',
    token: json["token"]?? '',
    refreshToken: json["refresh_token"]?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "memberId": memberId,
    "username": username,
    "password": password,
    "roleName": roleName,
    "isAdministrator": isAdministrator,
    "position": position,
    "isChitCommitteeMember": isChitCommitteeMember,
    "chitCommitteePosition": chitCommitteePosition,
    "firstname": firstname,
    "lastname": lastname,
    "phoneno": phoneno,
    "fathername": fathername,
    "mothername": mothername,
    "gender": gender,
    "avatar": avatar,
    "address": address,
    "dob": dob,
    "balanceTribute": balanceTribute,
    "userType": userType,
    "usertypeSavedhalf": usertypeSavedhalf,
    "userTypefullchangedDate": userTypefullchangedDate,
    "maritalStatus": maritalStatus,
    "maritalStatusSavedsingle": maritalStatusSavedsingle,
    "maritalchangedDate": maritalchangedDate,
    "memberType": memberType,
    "memberTypeSavedbclass": memberTypeSavedbclass,
    "memberTypebclasschangedDate": memberTypebclasschangedDate,
    "memberTypebclassAddedDate": memberTypebclassAddedDate,
    "memberTypeSavedcclass": memberTypeSavedcclass,
    "identityProof": identityProof,
    "identityProofNo": identityProofNo,
    "nationality": nationality,
    "qualification": qualification,
    "jobType": jobType,
    "jobportal": jobportal,
    "jobdetails": jobdetails,
    "familyId": familyId,
    "status": status,
    "remark": remark,
    "token": token,
    "refresh_token": refreshToken,
  };
}

class MemberDetails {
  List<MemberDetail> memberDetails;

  MemberDetails({required this.memberDetails});

  factory MemberDetails.fromJson(Map<String, dynamic> json) {
    var memberDetailList = json['userDetails'] as List<dynamic>?;

    if (memberDetailList == null) {
      return MemberDetails(memberDetails: []);
    }

    List<MemberDetail> memberDetailsList = memberDetailList.map((i) => MemberDetail.fromJson(i)).toList();
    return MemberDetails(memberDetails: memberDetailsList);
  }

}
