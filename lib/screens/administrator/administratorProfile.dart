import 'dart:core';
import 'package:flutter/material.dart';
import '../family/familymemberProfile.dart';
import '../profile/myProfile.dart';
import '/services/auth_services.dart';
import '/Styles/colors.dart';
import '/Styles/commonicons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'administratorList.dart';

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}
class AdministratorProfile extends StatefulWidget {

  final Map<String, dynamic> memberData;

  AdministratorProfile({required this.memberData});

  @override
  _AdministratorProfileState createState() => _AdministratorProfileState();
}

class _AdministratorProfileState extends State<AdministratorProfile> {
  void signOutUser(BuildContext context) {
    AuthService().signOut(context);
  }

  void _launchDialPad(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    final gender = widget.memberData["gender"];
    final status = widget.memberData["status"];  
    String imgeIcon = "";
    if(gender == 'male'){
      imgeIcon = maleImage;
    } else if(gender == 'female'){
      imgeIcon = femaleImage;
    }
    Color statusColor = Colors.green;
    if(status == 'active'){
      statusColor= Colors.green;
    } else if(status == 'suspended'){
      statusColor= Colors.yellow;
    } else if(status == 'dismiss'){
      statusColor= Colors.red;
    } else if(status == 'death'){
      statusColor= Colors.black;
    }
    int balance = widget.memberData["balanceTribute"];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "View Member Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AdministratorList(pageTitle: 'Administrator list', pageType: 'all'),
              ),
            );
          },
        ),
        actions: [
          PopupMenuButton(
            color: Colors.white,
            onSelected: (result) {
              if (result == "Logout") {
                signOutUser(context);
              } else if (result == 'MyAccount') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfile(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  child: Text("My Profile"),
                  value: 'MyAccount',
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: 'Settings',
                ),
                PopupMenuItem(
                  child: Text("Logout"),
                  value: 'Logout',
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/OR7WBG0.jpg"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 70.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0,
                                      3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: .0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 50.0, bottom: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Align(
                                            child: Text(
                                              widget.memberData["lastname"] +' '+ widget.memberData["firstname"],
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    50, 50, 93, 1),
                                                fontSize: 28.0,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible: widget.memberData["position"] != 'null' ,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Align(
                                                    child: Text(
                                                      capitalize(widget.memberData["position"].toString().toLowerCase()),
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 18.0,
                                                        fontWeight: FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Align(
                                            child: Text(
                                              widget.memberData["memberId"],
                                              style: TextStyle(
                                                color: Color.fromRGBO(52, 52, 53, 1),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      17, 205, 239, 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _launchDialPad(widget.memberData["phoneno"]);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        color: Color(0xFFFFFFFF),
                                                        size: 20.0, // Adjust size as needed
                                                      ),
                                                      SizedBox(width: 5), // Add spacing between icon and text
                                                      Text(
                                                        "CONNECT",
                                                        style: TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      23, 43, 77, 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                   // _launchDialPad('7200716128');
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.message,
                                                        color: Color(0xFFFFFFFF),
                                                        size: 20.0, // Adjust size as needed
                                                      ),
                                                      SizedBox(width: 5), // Add spacing between icon and text
                                                      Text(
                                                        "MESSAGE",
                                                        style: TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(255, 186, 101, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                   // _launchDialPad('7200716128');
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.currency_rupee,
                                                        color: Color(0xFFFFFFFF),
                                                        size: 20.0, // Adjust size as needed
                                                      ),
                                                      SizedBox(width: 5), // Add spacing between icon and text
                                                      Text(
                                                        balance.toString(),
                                                        style: TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0,
                                                ),
                                              )
                                            ],
                                          ),
                                          Divider(
                                            height: 40.0,
                                            thickness: 1.5,
                                            indent: 32.0,
                                            endIndent: 32.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0, right: 32.0, bottom: 5),
                                            child: Align(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Member Details',
                                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Color.fromRGBO(50, 50, 93, 1),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["firstname"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'First Name:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.memberData["firstname"].toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["lastname"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Last Name:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.memberData["lastname"].toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible:  widget.memberData["fathername"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Father Name:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.memberData["fathername"].toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["mothername"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Mother Name:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.memberData["mothername"].toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["phoneno"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Phone No:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.memberData["phoneno"].toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["dob"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Date of Birth:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.memberData["dob"].toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["gender"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Gender:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["gender"].toString().toLowerCase()))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["userType"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'User Type:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["userType"].toString().toLowerCase()))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["maritalStatus"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Marital Status:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["maritalStatus"].toString().toLowerCase()))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["memberType"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Member Type:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["memberType"].toString().toLowerCase()))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["nationality"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Nationality:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["nationality"].toString().toLowerCase()))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["status"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Status:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["status"].toString().toLowerCase()))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData.containsKey("address") &&  widget.memberData["address"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Address:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["address"].toString().toLowerCase()))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData.containsKey("identityProof") &&  widget.memberData["identityProof"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Identity Proof:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["identityProof"].toString().toLowerCase()))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData.containsKey("identityProofNo") &&  widget.memberData["identityProofNo"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Identity Proof No:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["identityProofNo"].toString().toLowerCase()))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData.containsKey("qualification") &&  widget.memberData["qualification"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Qualification:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["qualification"].toString().toLowerCase())),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData.containsKey("jobType") &&  widget.memberData["jobType"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Job Type:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["jobType"].toString().toLowerCase())),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData.containsKey("jobportal") &&  widget.memberData["jobportal"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Job portal:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["jobportal"].toString().toLowerCase())),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Visibility(
                                            visible:  widget.memberData.containsKey("jobdetails") &&  widget.memberData["jobdetails"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 25.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Job details:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(widget.memberData["jobdetails"].toString().toLowerCase())),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
                                          ),
                                          Divider(
                                            height: 40.0,
                                            thickness: 1.5,
                                            indent: 32.0,
                                            endIndent: 32.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0, right: 32.0, bottom: 5),
                                            child: Align(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Family Details',
                                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Color.fromRGBO(50, 50, 93, 1),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.memberData["familyMembers"] != null &&
                                                widget.memberData.containsKey("familyMembers") && widget.memberData["familyMembers"].isNotEmpty,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                columnSpacing: 25,
                                                columns: [
                                                  DataColumn(label: Text('Name')),
                                                  DataColumn(label: Text('Relation')),
                                                  DataColumn(label: Text('Status')),
                                                  DataColumn(label: Text('')),
                                                ],
                                                rows: (widget.memberData["familyMembers"] as List<dynamic>)
                                                    .map<DataRow>(
                                                      (member) {
                                                        return DataRow(
                                                          cells: [
                                                            DataCell(Text(member['lastname'].toString() + ' ' + member['firstname'].toString())),
                                                            DataCell(Text(capitalize(member["relation"].toString().toLowerCase()))),
                                                            DataCell(Text(capitalize(member["status"].toString().toLowerCase()))),
                                                            DataCell(
                                                              IconButton(
                                                                icon: Icon(Icons.remove_red_eye),
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => familyMemberProfile(memberData: member),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            replacement: Text('Family Details not added'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              FractionalTranslation(
                                translation: Offset(0.0, -0.5),
                                child: Align(
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: AssetImage(imgeIcon),
                                    backgroundColor: statusColor,
                                  ),
                                  alignment: FractionalOffset(0.5, 0.0),
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}