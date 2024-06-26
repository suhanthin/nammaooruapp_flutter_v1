import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/custom_member_provider.dart';
import '../providers/member_provider.dart';
import '/utils/constants.dart';
import '/utils/utils.dart';

class MemberService {
  getMembersList(
    BuildContext context,
    String memberType,
    String gender,
  ) async {
    try {
      var memberProvider = Provider.of<MemberProvider>(context, listen: false);
      Map data = {
        "usersListquery":[
          {
            "memberType": memberType,
            "gender": gender
          }
        ]
      };
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/usersList'),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          var jsonResponsenew;
          jsonResponsenew = json.decode(res.body);
          memberProvider.setMemberDetail(jsonResponsenew);
        },
      );      
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  getAdministratorsList(
    BuildContext context,
    String memberType,
    String gender,
  ) async {
    try {
      var memberProvider = Provider.of<MemberProvider>(context, listen: false);
      Map data = {
        "usersListquery":[
          {
            "memberType": memberType,
            "gender": gender
          }
        ]
      };
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/administratorList'),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          var jsonResponsenew;
          jsonResponsenew = json.decode(res.body);
          memberProvider.setMemberDetail(jsonResponsenew);
        },
      );      
    } catch (e) {
      debugPrint("Error: $e");
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  getMembersSearch(
    BuildContext context,
    String searchkey,
    String searchType,
  ) async {
    try {
      var memberProvider = Provider.of<MemberProvider>(context, listen: false);
      Map data = {
        "searchvalue": searchkey,
        "searchType": searchType  
      };
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/user/search/'),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          var jsonResponsenew;
          jsonResponsenew = json.decode(res.body);
          memberProvider.setMemberDetail(jsonResponsenew);
        },
      );      
    } catch (e) {
      debugPrint("Error: $e");
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  getCustomMemberList(
    BuildContext context
  ) async {
    try {
      var custommemberProvider =  Provider.of<CustomMemberProvider>(context, listen: false);
      Map data = {};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/user/customMemberList'),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': accessToken.toString(),
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          var jsonResponsenew;
          jsonResponsenew = json.decode(res.body);
          custommemberProvider.setCustomMemberDetail(jsonResponsenew);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }
}