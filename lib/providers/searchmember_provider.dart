import 'package:flutter/material.dart';
import '/models/searchmember.dart'; 

class SearchMemberProvider extends ChangeNotifier {
  SearchMemberDetails? _searchMemberDetails = SearchMemberDetails(searchMemberDetails: []);

  SearchMemberDetails? get searchMemberDetails => _searchMemberDetails;

  void setUserDetail(Map<String, dynamic> searchMemberDetails) {
    _searchMemberDetails = SearchMemberDetails.fromJson(searchMemberDetails);
    notifyListeners();
  }

  void setUserDetailFromModel(SearchMemberDetails searchMemberDetails) {
    _searchMemberDetails = searchMemberDetails;
    notifyListeners();
  }

  void clearSearchMembersDetails() {
    _searchMemberDetails = null;
    notifyListeners();
  }
}
