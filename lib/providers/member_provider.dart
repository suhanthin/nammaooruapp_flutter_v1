import 'package:flutter/material.dart';
import '/models/member.dart';


class MemberProvider extends ChangeNotifier {
  // Member? _member;

  // Member? get member => _member;

  // void setMember(Member newMember) {
  //   _member = newMember;
  //   notifyListeners();
  // }

  // void setUserFromModel(Member member) {
  //   _member = member;
  //   notifyListeners();
  // }
  MemberDetails? _memberDetails = MemberDetails(memberDetails: []);

  MemberDetails? get memberDetails => _memberDetails;

  void setMemberDetail(Map<String, dynamic> memberDetails) {
    _memberDetails = MemberDetails.fromJson(memberDetails);
    notifyListeners();
  }

  void setMemberDetailFromModel(MemberDetails memberDetails) {
    _memberDetails = memberDetails;
    notifyListeners();
  }

  void clearUserDetails() {
    _memberDetails = null;
    notifyListeners();
  }
  
}

