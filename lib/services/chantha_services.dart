import 'dart:convert';
import 'package:flutter/material.dart';
import '../screens/chantha/chanthaList.dart';
import '../screens/chantha/viewChantha.dart';
import '/providers/chantha_provider.dart';
import '../models/chantha.dart';
import '../screens/dashboard/dashboard.dart';
import '/screens/login/login_screen.dart';
import '/utils/constants.dart';
import '/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChanthaService {
  void createChantha({
    required BuildContext context,
    required int amount,
    required String effectiveDate,
    required String status,
    required String remark,
  }) async {
    try {
      var chanthaProvider = Provider.of<ChanthaProvider>(context, listen: false);
      Map data = {
        'amount': amount,
        'effectiveDate': effectiveDate,
        'status': status,
        'remark': remark
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/chantha/create'),
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
          chanthaProvider.setChantha(jsonResponsenew);
          
          // Show success SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Chantha created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          
          // Navigate to ChantaListing page after a delay
          await Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ChanthaList(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), backgroundColor: Colors.red);
    }
  }

  void updateChantha({
    required BuildContext context,
    required String id,
    required int amount,
    required String effectiveDate,
    required String status,
    required String remark,
  }) async {
    try {
      var chanthaProvider = Provider.of<ChanthaProvider>(context, listen: false);
      Map data = {
        'id': id,
        'amount': amount,
        'effectiveDate': effectiveDate,
        'status': status,
        'remark': remark
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/chantha/update'),
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
          chanthaProvider.setChantha(jsonResponsenew);
          
          // Show success SnackBar
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Chantha updated successfully!'),
          //     backgroundColor: Colors.green,
          //   ),
          // );
          showSnackBar(context, 'Chantha updated successfully!', backgroundColor: Colors.green);
          
          // Navigate to ChantaListing page after a delay
          await Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ChanthaList(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), backgroundColor: Colors.red);
    }
  }

  getChanthaList(
    BuildContext context,
  ) async {
    try {
      var chanthaProvider = Provider.of<ChanthaProvider>(context, listen: false);
      Map data = {};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/chantha/list'),
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
          chanthaProvider.setChantha(jsonResponsenew);
        },
      );      
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  void getChanthaDetails({ 
    required BuildContext context,
    required String chanthaid,
  }) async {
    try {
      var chanthaProvider = Provider.of<ChanthaProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      Map data = {
        '_id': chanthaid
      };
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/chantha/detail'),
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
          var jsonResult = json.encode(jsonResponsenew['chanthaDetails']);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ViewChantha(chanthaData: json.decode(jsonResult)),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  void deleteChanthaDetails({ 
    required BuildContext context,
    required String chanthaid,
    required String reason
  }) async {
    try {
      // Get provider
      var chanthaProvider = Provider.of<ChanthaProvider>(context, listen: false);
      // Get navigator
      final navigator = Navigator.of(context);
      // Get shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('x-access-token');
      
      if (accessToken == null) {
        throw Exception('Access token is null');
      }
      
      // Prepare URI
      Uri uri = Uri.parse('${Constants.uri}/api/chantha/delete').replace(queryParameters: {'_id': chanthaid, 'reason': reason});
      
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
          chanthaProvider.setChantha(jsonResponsenew);

          // Navigate to ChanthaList page
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ChanthaList(),
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
}

