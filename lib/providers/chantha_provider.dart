import 'package:flutter/material.dart';
import '/models/chantha.dart';


class ChanthaProvider extends ChangeNotifier {
  ChanthaDetails? _chanthaDetails = ChanthaDetails(chanthaDetails: []);

  ChanthaDetails? get chanthaDetails => _chanthaDetails;

  void setChantha(Map<String, dynamic> chanthaDetails) {
    _chanthaDetails = ChanthaDetails.fromJson(chanthaDetails);
    notifyListeners();
  }

  void setMemberDetailFromModel(ChanthaDetails chanthaDetails) {
    _chanthaDetails = chanthaDetails;
    notifyListeners();
  }

  void clearUserDetails() {
    _chanthaDetails = null;
    notifyListeners();
  }
  
}

