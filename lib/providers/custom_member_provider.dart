import 'package:flutter/material.dart';
import '/models/custom_member.dart';


class CustomMemberProvider extends ChangeNotifier {

  CustomMemberDetails? _customMemberDetails = CustomMemberDetails(customMemberDetails: []);

  CustomMemberDetails? get customMemberDetails => _customMemberDetails;

  void setCustomMemberDetail(Map<String, dynamic> customMemberDetails) {
    _customMemberDetails = CustomMemberDetails.fromJson(customMemberDetails);
    notifyListeners();
  }

  void setCustomMemberDetailFromModel(CustomMemberDetails customMemberDetails) {
    _customMemberDetails = customMemberDetails;
    notifyListeners();
  }

  void clearCustomMemberDetails() {
    _customMemberDetails = null;
    notifyListeners();
  }
  
}

