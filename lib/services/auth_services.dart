import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nammaooruapp/providers/member_provider.dart';
import '../models/user.dart';
import '../models/member.dart';
import '../models/family.dart';
import '../providers/searchmember_provider.dart';
import '../screens/administrator/administratorProfile.dart';
import '../screens/dashboard/dashboard.dart';
import '../screens/member/memberProfile.dart';
import '/screens/login/login_screen.dart';
import '/providers/user_provider.dart';
import '/utils/constants.dart';
import '/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String id,
    required String memberId,
    required String username,
    required String password,
    required String roleName,
    required bool isAdministrator,
    required String position,
    required bool isChitCommitteeMember,
    required String chitCommitteePosition,
    required String firstname,
    required String lastname,
    required String phoneno,
    required String fathername,
    required String mothername,
    required String gender,
    required String avatar,
    required String address,
    required String dob,
    required int balanceTribute,
    required String userType,
    required String usertypeSavedhalf,
    required String userTypefullchangedDate,
    required String maritalStatus,
    required String maritalStatusSavedsingle,
    required String maritalchangedDate,
    required String memberType,
    required String memberTypeSavedbclass,
    required String memberTypebclasschangedDate,
    required String memberTypebclassAddedDate,
    required String memberTypeSavedcclass,
    required String identityProof,
    required String identityProofNo,
    required String nationality,
    required String qualification,
    required String jobType,
    required String jobportal,
    required String jobdetails,
    required String familyId,
    required String status,
    required String remark,
    required String token,
    required String refreshToken,
    required String enrollDate,
    required String enrolledType,
    required String reJoiningDate,
    required bool isChanthaRequired,
    required bool isEnrolledAfterRecord,
    required bool statusDismisstoActive,
    required String jobProfessional,
  }) async {
    try {
      User user = User(
        id: '',
        firstname: firstname,
        password: password,
        username: username,
        token: token,
        memberId: memberId,
        roleName: 'member',
        isAdministrator: isAdministrator,
        position: position == 'Select' ? '' : position,
        isChitCommitteeMember: isChitCommitteeMember,
        chitCommitteePosition: chitCommitteePosition == 'Select' ? '' : chitCommitteePosition,
        lastname: lastname,
        phoneno: phoneno,
        fathername: fathername,
        mothername: mothername,
        gender: gender,
        avatar: avatar,
        address: address,
        dob: dob,
        balanceTribute: balanceTribute,
        userType: userType,
        usertypeSavedhalf:usertypeSavedhalf,
        userTypefullchangedDate: userTypefullchangedDate,
        maritalStatus: maritalStatus,
        maritalStatusSavedsingle: maritalStatusSavedsingle,
        maritalchangedDate: maritalchangedDate,
        memberType: memberType,
        memberTypeSavedbclass: memberTypeSavedbclass,
        memberTypebclasschangedDate: memberTypebclasschangedDate,
        memberTypebclassAddedDate: memberTypebclassAddedDate,
        memberTypeSavedcclass:memberTypeSavedcclass,
        identityProof: identityProof == 'Select' ? '' : identityProof,
        identityProofNo: identityProofNo,
        nationality: nationality,
        qualification: qualification,
        jobType: jobType == 'Select' ? '' : jobType,
        jobdetails: jobdetails == 'Select' ? '' : jobdetails,
        jobportal: jobportal,
        familyId: familyId,
        status: status,
        remark: remark,
        refreshToken:refreshToken,
        enrollDate: enrollDate,
        enrolledType: enrolledType,
        reJoiningDate: reJoiningDate,
        isChanthaRequired: isChanthaRequired,
        isEnrolledAfterRecord: isEnrolledAfterRecord,
        statusDismisstoActive: statusDismisstoActive,
        jobProfessional:jobProfessional
      );
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/auth/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Member added successfully!',
            backgroundColor: Colors.green
          );
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  void signInUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      Map data = {
        'username': username,
        'password': password
      };
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/auth/signin'),
        body: json.encode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Map<String, dynamic> userJson = json.decode(res.body);
          User user = User.fromMap(userJson);
          userProvider.setUser(user);

          await prefs.setString('x-access-token', jsonDecode(res.body)['token']);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => (jsonDecode(res.body)['roleName'] == "superadmin" && jsonDecode(res.body)['isAdministrator'] == true ) || (jsonDecode(res.body)['roleName'] == "admin" && jsonDecode(res.body)['isAdministrator'] == true) ? dashboardPage() : (jsonDecode(res.body)['roleName'] == "member" && jsonDecode(res.body)['isChitCommitteeMember'] == true) ? LoginScreen() : LoginScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), backgroundColor: Colors.red);
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-access-token');

      if (token == null) {
        prefs.setString('x-access-token', '');
      }

      var tokenRes = await http.get(
        Uri.parse('${Constants.uri}/api/auth/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': token!,
        },
      );
      var jsonResponse = null;
      jsonResponse = json.decode(tokenRes.body);
      String? userid =jsonResponse['userid'];
      if (userid != null) {
        Map data = {
          'userid': userid
        };
        http.Response res = await http.post(
          Uri.parse('${Constants.uri}/api/user/detail/'),
          body: json.encode(data),
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
            var userList = jsonResponsenew['users'];
            if (userList != null && userList.isNotEmpty) {
                var userData = userList[0];
                var user = User.fromMap(userData);
                userProvider.setUser(user);
            }            
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-access-token', '');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  void getMemberDetails({ 
    required BuildContext context,
    required String userid,
    required String page
  }) async {
    try {
      final navigator = Navigator.of(context);
      Map data = {
        'userid': userid
      };
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/user/detail/'),
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
          var jsonResult = json.encode(jsonResponsenew['users']);
          if(page == 'admin'){
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => AdministratorProfile(memberData: json.decode(jsonResult)),
              ),
              (route) => false,
            );
          } else{
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MemberProfile(memberData: json.decode(jsonResult)),
              ),
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  void userUpdate({
    required BuildContext context,
    required String id,
    required String memberId,
    required String username,
    required String password,
    required String roleName,
    required bool isAdministrator,
    required String position,
    required bool isChitCommitteeMember,
    required String chitCommitteePosition,
    required String firstname,
    required String lastname,
    required String phoneno,
    required String fathername,
    required String mothername,
    required String gender,
    required String avatar,
    required String address,
    required String dob,
    required int balanceTribute,
    required String userType,
    required String usertypeSavedhalf,
    required String userTypefullchangedDate,
    required String maritalStatus,
    required String maritalStatusSavedsingle,
    required String maritalchangedDate,
    required String memberType,
    required String memberTypeSavedbclass,
    required String memberTypebclasschangedDate,
    required String memberTypebclassAddedDate,
    required String memberTypeSavedcclass,
    required String identityProof,
    required String identityProofNo,
    required String nationality,
    required String qualification,
    required String jobType,
    required String jobportal,
    required String jobdetails,
    required String familyId,
    required String status,
    required String remark,
    required String token,
    required String refreshToken,
    required String enrollDate,
    required String enrolledType,
    required String reJoiningDate,
    required bool isChanthaRequired,
    required bool isEnrolledAfterRecord,
    required bool statusDismisstoActive,
    required String jobProfessional,
    required List<FamilyMember> familyMembers,
  })async {
    try {
      User user = User(
        id: id,
        firstname: firstname,
        password: password,
        username: username,
        token: token,
        memberId: memberId,
        roleName: roleName,
        isAdministrator: isAdministrator,
        position: position == 'Select' ? '' : position,
        isChitCommitteeMember: isChitCommitteeMember,
        chitCommitteePosition: chitCommitteePosition == 'Select' ? '' : chitCommitteePosition,
        lastname: lastname,
        phoneno: phoneno,
        fathername: fathername,
        mothername: mothername,
        gender: gender,
        avatar: avatar,
        address: address,
        dob: dob,
        balanceTribute: balanceTribute,
        userType: userType,
        usertypeSavedhalf:usertypeSavedhalf,
        userTypefullchangedDate: userTypefullchangedDate,
        maritalStatus: maritalStatus,
        maritalStatusSavedsingle: maritalStatusSavedsingle,
        maritalchangedDate: maritalchangedDate,
        memberType: memberType,
        memberTypeSavedbclass: memberTypeSavedbclass,
        memberTypebclasschangedDate: memberTypebclasschangedDate,
        memberTypebclassAddedDate: memberTypebclassAddedDate,
        memberTypeSavedcclass:memberTypeSavedcclass,
        identityProof: identityProof == 'Select' ? '' : identityProof,
        identityProofNo: identityProofNo,
        nationality: nationality,
        qualification: qualification,
        jobType: jobType == 'Select' ? '' : jobType,
        jobdetails: jobdetails == 'Select' ? '' : jobdetails,
        jobportal: jobportal,
        familyId: familyId,
        status: status,
        remark: remark,
        refreshToken:refreshToken,
        enrollDate: enrollDate,
        enrolledType: enrolledType,
        reJoiningDate: reJoiningDate,
        isChanthaRequired:isChanthaRequired,
        isEnrolledAfterRecord:isEnrolledAfterRecord,
        statusDismisstoActive:statusDismisstoActive,
        jobProfessional:jobProfessional
      );
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/auth/userupdate'),
        body: jsonEncode({
          'user': user.toJson(),
          'familyMembers': familyMembers.map((member) => member.toJson()).toList(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Member Updated successfully!',
            backgroundColor: Colors.green
          );
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }

  void memberSearch({ 
    required BuildContext context,
    required String searchvalue,
    required String searchType
  }) async {
    try {
      var searchMemberProvider = Provider.of<SearchMemberProvider>(context, listen: false);
      Map data = {
        'searchvalue': searchvalue,
        'searchType': searchType
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
          //var jsonResult = json.encode(jsonResponsenew['users']);
          //debugPrint(jsonResult);
          searchMemberProvider.setUserDetail(jsonResponsenew);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(),backgroundColor: Colors.red);
    }
  }
}

