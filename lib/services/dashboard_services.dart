import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '/providers/dashboard_provider.dart';
import '/utils/constants.dart';
import '/utils/utils.dart';

class DashboardService {
  void getDashboardData(
    BuildContext context,
  ) async {
    try {
      var dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}/api/dashboard/dashboardMemberCount'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          var jsonResponsenew = null;
          jsonResponsenew = json.decode(res.body);
          var jsonResult = json.encode(jsonResponsenew['membersDetails']);
          dashboardProvider.setdashboardDetails(jsonResult);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }
}

