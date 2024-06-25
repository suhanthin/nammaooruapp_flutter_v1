class FamilyMember {
  String id;
  bool isnewFamily;
  bool isMarriedSamePlace;
  String marriedPersonId;
  String familyId;
  String familyName;
  String subId;
  String levelNo;
  bool isMember;
  String member_Id;
  String memberId;
  String firstName;
  String lastName;
  String gender;
  String dob;
  String phoneNumber;
  String relation;
  String maritalStatus;
  String husbandOrWifeName;
  String identityProof;
  String identityProofNo;
  String address;
  String nationality;
  String qualification;
  String jobType;
  String jobPortal;
  String jobDetails;
  String status;
  String remark;
  bool isSameParent;
  String sameParentFatherFamilyId;
  String sameParentMotherFamilyId;
  bool family_isaddBelowMember;
  String familySubId;
  String jobProfessional;
  bool isDelete;

  FamilyMember({
    required this.id,
    required this.isnewFamily,
    required this.isMarriedSamePlace,
    required this.marriedPersonId,
    required this.familyId,
    required this.familyName,
    required this.subId,
    required this.levelNo,
    required this.isMember,
    required this.member_Id,
    required this.memberId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dob,
    required this.phoneNumber,
    required this.relation,
    required this.maritalStatus,
    required this.husbandOrWifeName,
    required this.identityProof,
    required this.identityProofNo,
    required this.address,
    required this.nationality,
    required this.qualification,
    required this.jobType,
    required this.jobPortal,
    required this.jobDetails,
    required this.status,
    required this.remark,
    required this.isSameParent,
    required this.sameParentFatherFamilyId,
    required this.sameParentMotherFamilyId,
    required this.family_isaddBelowMember,
    required this.familySubId,
    required this.jobProfessional,
    required this.isDelete
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
    id: json['_id']?? '',
    isnewFamily: json['isnewFamily'] ?? false,
    isMarriedSamePlace: json['ismarriedSamePlace'] ?? false,
    marriedPersonId: json['marriedpersionId'] ?? '',
    familyId: json['familyId'] ?? '',
    familyName: json['familyname'] ?? '',
    subId: json['subId'] ?? '',
    levelNo: json['LevelNo'] ?? '',
    isMember: json['ismember'] ?? false,
    member_Id: json['member_Id'] ?? '',
    memberId: json['memberId'] ?? '',
    firstName: json['firstname'] ?? '',
    lastName: json['lastname'] ?? '',
    gender: json['gender'] ?? '',
    dob: json['dob'] ?? '',
    phoneNumber: json['phoneno'] ?? '',
    relation: json['relation'] ?? '',
    maritalStatus: json['maritalStatus'] ?? '',
    husbandOrWifeName: json['husorwife_name'] ?? '',
    identityProof: json['identityProof'] ?? '',
    identityProofNo: json['identityProofNo'] ?? '',
    address: json['address'] ?? '',
    nationality: json['nationality'] ?? '',
    qualification: json['qualification'] ?? '',
    jobType: json['jobType'] ?? '',
    jobPortal: json['jobportal'] ?? '',
    jobDetails: json['jobdetails'] ?? '',
    status: json['status'] ?? '',
    remark: json['remark'] ?? '',
    isSameParent: json['isSameParent'] ?? '',
    sameParentFatherFamilyId: json['sameParentfatherfamilyId'] ?? '',
    sameParentMotherFamilyId: json['sameParentmotherfamilyId'] ?? '',
    family_isaddBelowMember: json['family_isaddBelowMember'] ?? false,
    familySubId:json['familySubId'] ?? '',
    jobProfessional:json['jobProfessional'] ?? '',
    isDelete:json['isDelete'] ?? ''
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'isnewFamily': isnewFamily,
    'ismarriedSamePlace': isMarriedSamePlace,
    'marriedpersionId': marriedPersonId,
    'familyId': familyId,
    'familyname': familyName,
    'subId': subId,
    'LevelNo': levelNo,
    'ismember': isMember,
    'member_Id': member_Id,
    'memberId': memberId,
    'firstname': firstName,
    'lastname': lastName,
    'gender': gender,
    'dob': dob,
    'phoneno': phoneNumber,
    'relation': relation,
    'maritalStatus': maritalStatus,
    'husorwife_name': husbandOrWifeName,
    'IdentityProof': identityProof,
    'IdentityProofNo': identityProofNo,
    'address': address,
    'nationality': nationality,
    'qualification': qualification,
    'jobType': jobType,
    'jobportal': jobPortal,
    'jobdetails': jobDetails,
    'status': status,
    'remark': remark,
    'isSameParent': isSameParent,
    'sameParentfatherfamilyId': sameParentFatherFamilyId,
    'sameParentmotherfamilyId': sameParentMotherFamilyId,
    'family_isaddBelowMember':family_isaddBelowMember,
    'familySubId': familySubId,
    'jobProfessional':jobProfessional,
    'isDelete': isDelete
  };
}
