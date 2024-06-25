import 'dart:convert';
import 'package:flutter/material.dart';
import '/models/dashboard.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardModel? _dashboardModel;

  DashboardModel? get dashboardDetails => _dashboardModel;

  void setdashboardDetails(String dashboard) {
    _dashboardModel = DashboardModel.fromJson(jsonDecode(dashboard));
    notifyListeners();
  }

  void setUserFromModel(DashboardModel dashboardModel) {
    _dashboardModel = dashboardModel;
    notifyListeners();
  }
}
