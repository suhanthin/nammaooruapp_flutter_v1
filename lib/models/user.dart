import 'dart:convert';
class User {
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
  String enrollDate;
  String enrolledType;
  String reJoiningDate;
  bool isChanthaRequired;
  bool isEnrolledAfterRecord;
  bool statusDismisstoActive;
  String jobProfessional;

  User({
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
    required this.enrollDate,
    required this.enrolledType,
    required this.reJoiningDate,
    required this.isChanthaRequired,
    required this.isEnrolledAfterRecord,
    required this.statusDismisstoActive,
    required this.jobProfessional,
  });

  factory User.fromMap(Map<String, dynamic>? json) {
    if (json == null) return User(
      id: "",
      memberId: "",
      username: "",
      password: "",
      roleName: "",
      isAdministrator: false,
      position: "",
      isChitCommitteeMember: false,
      chitCommitteePosition: "",
      firstname: "",
      lastname: "",
      phoneno: "",
      fathername: "",
      mothername: "",
      gender: "",
      avatar: "",
      address: "",
      dob: "",
      balanceTribute: 0,
      userType: "",
      usertypeSavedhalf: "",
      userTypefullchangedDate: "",
      maritalStatus: "",
      maritalStatusSavedsingle: "",
      maritalchangedDate: "",
      memberType: "",
      memberTypeSavedbclass: "",
      memberTypebclasschangedDate: "",
      memberTypebclassAddedDate: "",
      memberTypeSavedcclass: "",
      identityProof: "",
      identityProofNo: "",
      nationality: "",
      qualification: "",
      jobType: "",
      jobportal: "",
      jobdetails: "",
      familyId: "",
      status: "",
      remark: "",
      token: "",
      refreshToken: "",
      enrollDate: "",
      enrolledType: "",
      reJoiningDate: "",
      isChanthaRequired: false,
      isEnrolledAfterRecord: false,
      statusDismisstoActive: false,
      jobProfessional:''
    );

    return User(
      id: json['_id'],
      memberId: json['memberId'],
      username: json['username'],
      password: json['password'],
      roleName: json['roleName'],
      isAdministrator: json['isAdministrator'],
      position: json['position'],
      isChitCommitteeMember: json['isChitCommitteeMember'],
      chitCommitteePosition: json['chitCommitteePosition'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phoneno: json['phoneno'],
      fathername: json['fathername'],
      mothername: json['mothername'],
      gender: json['gender'],
      avatar: json['avatar'] ?? '',
      address: json['address']?? '',
      dob: json['dob']?? '',
      balanceTribute: json['balanceTribute']?? '',
      userType: json['userType']?? '',
      usertypeSavedhalf: json['usertypeSavedhalf']?? '',
      userTypefullchangedDate: json['userTypefullchangedDate']?? '',
      maritalStatus: json['maritalStatus']?? '',
      maritalStatusSavedsingle: json['maritalStatusSavedsingle']?? '',
      maritalchangedDate: json['maritalchangedDate']?? '',
      memberType: json['memberType']?? '',
      memberTypeSavedbclass: json['memberTypeSavedbclass']?? '',
      memberTypebclasschangedDate: json['memberTypebclasschangedDate']?? '',
      memberTypebclassAddedDate: json['memberTypebclassAddedDate']?? '',
      memberTypeSavedcclass: json['memberTypeSavedcclass']?? '',
      identityProof: json['identityProof']?? '',
      identityProofNo: json['identityProofNo']?? '',
      nationality: json['nationality']?? '',
      qualification: json['qualification']?? '',
      jobType: json['jobType']?? '',
      jobportal: json['jobportal']?? '',
      jobdetails: json['jobdetails']?? '',
      familyId: json['familyId']?? '',
      status: json['status']?? '',
      remark: json['remark']?? '',
      token: json['token']?? '',
      refreshToken: json['refresh_token']?? '',
      enrollDate: json['enrollDate']?? '',
      enrolledType: json['enrolledType']?? '',
      reJoiningDate: json['reJoiningDate']?? '',
      isChanthaRequired: json['isChanthaRequired']?? false,
      isEnrolledAfterRecord: json['isEnrolledAfterRecord'] ?? false,
      statusDismisstoActive: json['statusDismisstoActive'] ?? false,
      jobProfessional:json['jobProfessional'] ??''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'memberId': memberId,
      'username': username,
      'password': password,
      'roleName': roleName,
      'isAdministrator': isAdministrator,
      'position': position,
      'isChitCommitteeMember': isChitCommitteeMember,
      'chitCommitteePosition': chitCommitteePosition,
      'firstname': firstname,
      'lastname': lastname,
      'phoneno': phoneno,
      'fathername': fathername,
      'mothername': mothername,
      'gender': gender,
      'avatar': avatar,
      'address': address,
      'dob': dob,
      'balanceTribute': balanceTribute,
      'userType': userType,
      'usertypeSavedhalf': usertypeSavedhalf,
      'userTypefullchangedDate': userTypefullchangedDate,
      'maritalStatus': maritalStatus,
      'maritalStatusSavedsingle': maritalStatusSavedsingle,
      'maritalchangedDate': maritalchangedDate,
      'memberType': memberType,
      'memberTypeSavedbclass': memberTypeSavedbclass,
      'memberTypebclasschangedDate': memberTypebclasschangedDate,
      'memberTypebclassAddedDate': memberTypebclassAddedDate,
      'memberTypeSavedcclass': memberTypeSavedcclass,
      'identityProof': identityProof,
      'identityProofNo': identityProofNo,
      'nationality': nationality,
      'qualification': qualification,
      'jobType': jobType,
      'jobportal': jobportal,
      'jobdetails': jobdetails,
      'familyId': familyId,
      'status': status,
      'remark': remark,
      'token': token,
      'refresh_token': refreshToken,

      'enrollDate': enrollDate,
      'enrolledType': enrolledType,
      'reJoiningDate': reJoiningDate,
      'isChanthaRequired': isChanthaRequired,
      'isEnrolledAfterRecord': isEnrolledAfterRecord,
      'statusDismisstoActive': statusDismisstoActive,
      'jobProfessional':jobProfessional
    };
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
