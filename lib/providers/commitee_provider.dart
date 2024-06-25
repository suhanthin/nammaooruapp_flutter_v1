import 'package:flutter/material.dart';
import '/models/commitee.dart';


class CommiteeProvider extends ChangeNotifier {
  CommiteeDetails? _commiteeDetails = CommiteeDetails(commiteeDetails: []);

  CommiteeDetails? get commiteeDetails => _commiteeDetails;

  void setCommitee(Map<String, dynamic> commiteeDetails) {
    _commiteeDetails = CommiteeDetails.fromJson(commiteeDetails);
    notifyListeners();
  }

  void setMemberDetailFromModel(CommiteeDetails commiteeDetails) {
    _commiteeDetails = commiteeDetails;
    notifyListeners();
  }

  void clearUserDetails() {
    _commiteeDetails = null;
    notifyListeners();
  }
  
}

