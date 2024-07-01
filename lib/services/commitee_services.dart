import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/custom_member.dart';
import '../screens/commitee/commiteeList.dart';
import '../screens/commitee/viewCommitee.dart';
import '/providers/commitee_provider.dart';
import '/utils/constants.dart';
import '/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommiteeService {
  void createCommitee({
    required BuildContext context,
    required int fineAmount,
    required String meetingDate,
    required String status,
    required String remark,
    required bool isAddAttendance,
    required String title,   
    required String description, 
    required List<CustomMemberDetail> userDetails,
  }) async {
    try {
      var commiteeProvider = Provider.of<CommiteeProvider>(context, listen: false);
      Map data = {
        'fineAmount': fineAmount,
        'meetingDate': meetingDate,
        'status': status,
        'remark': remark,
        'isAddAttendance': isAddAttendance,
        'title': title,
        'description': description,
        'userDetails': userDetails
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/committeeMeeting/create'),
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
          commiteeProvider.setCommitee(jsonResponsenew);
          
          // Show success SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Commitee created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          
          // Navigate to ChantaListing page after a delay
          await Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => CommiteeList(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), backgroundColor: Colors.red);
    }
  }

  void updateCommitee({
    required BuildContext context,
    required String id,
    required int fineAmount,
    required String meetingDate,
    required String status,
    required String remark,
    required bool isAddAttendance,
    required String title,   
    required String description, 
  }) async {
    try {
      var commiteeProvider = Provider.of<CommiteeProvider>(context, listen: false);
      Map data = {
        'id': id,
        'fineAmount': fineAmount,
        'meetingDate': meetingDate,
        'status': status,
        'remark': remark,
        'isAddAttendance': isAddAttendance,
        'title': title,
        'description': description
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/committeeMeeting/update'),
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
          commiteeProvider.setCommitee(jsonResponsenew);
          
          // Show success SnackBar
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Chantha updated successfully!'),
          //     backgroundColor: Colors.green,
          //   ),
          // );
          showSnackBar(context, 'Commitee updated successfully!', backgroundColor: Colors.green);
          
          // Navigate to ChantaListing page after a delay
          await Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => CommiteeList(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), backgroundColor: Colors.red);
    }
  }

  getCommiteeList(
    BuildContext context,
  ) async {
    try {
      var commiteeProvider = Provider.of<CommiteeProvider>(context, listen: false);
      Map data = {"status":"active"};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/committeeMeeting/list'),
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
          commiteeProvider.setCommitee(jsonResponsenew);
        },
      );      
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  void getCommiteeDetails({ 
    required BuildContext context,
    required String commiteeid,
  }) async {
    try {
      var commiteeProvider = Provider.of<CommiteeProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      Map data = {
        '_id': commiteeid
      };
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/committeeMeeting/detail'),
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
          //chanthaProvider.setChantha(jsonResponsenew);
          var jsonResult = json.encode(jsonResponsenew['committeeMeetingDetail']);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ViewCommitee(commiteeData: json.decode(jsonResult)),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  void deleteCommiteeDetails({ 
    required BuildContext context,
    required String commiteeid,
    required String reason
  }) async {
    try {
      // Get provider
      var commiteeProvider = Provider.of<CommiteeProvider>(context, listen: false);
      // Get navigator
      final navigator = Navigator.of(context);
      // Get shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      
      if (accessToken == null) {
        throw Exception('Access token is null');
      }
      
      // Prepare URI
      Uri uri = Uri.parse('${Constants.uri}/api/committeeMeeting/delete').replace(queryParameters: {'_id': commiteeid, 'reason': reason});
      
      // Perform HTTP GET request
      http.Response res = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': accessToken,
        },
      );
      
      // Handle HTTP response
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // Parse response
          var jsonResponsenew = json.decode(res.body);
          print(jsonResponsenew);

          // Update provider with new data
          commiteeProvider.setCommitee(jsonResponsenew);

          // Navigate to ChanthaList page
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => CommiteeList(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      // Log the error and show error snackbar
      print('Error: $e');
      showSnackBar(context, e.toString(), backgroundColor: Colors.red);
    }
  }

  getCommiteeMemberList(
    BuildContext context,
  ) async {
    try {
      var commiteeProvider = Provider.of<CommiteeProvider>(context, listen: false);
      Map data = {};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/committeeMeeting/list'),
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
          commiteeProvider.setCommitee(jsonResponsenew);
        },
      );      
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }
}

