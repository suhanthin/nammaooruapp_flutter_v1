import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import '/services/auth_services.dart';
import '/Styles/colors.dart';
import '/Styles/commonicons.dart';

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}

class MyProfile extends StatefulWidget {


  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  void signOutUser(BuildContext context) {
    AuthService().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final gender = user!.gender;
    final status = user.status;  
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          PopupMenuButton(
            color: Colors.white,
            onSelected: (result) {
              if (result == "Logout") {
                signOutUser(context);
              } else if (result == 'MyAccount') {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MyProfile(),
                //   ),
                // );
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
                      left: 16.0, right: 16.0, top: 74.0),
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
                                              user.lastname+' '+ user.firstname,
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    50, 50, 93, 1),
                                                fontSize: 28.0,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible: user.position != 'null' &&  user.position.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Align(
                                                    child: Text(
                                                      capitalize(user.position.toString().toLowerCase()),
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
                                              user.memberId,
                                              style: TextStyle(
                                                color: Color.fromRGBO(52, 52, 53, 1),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          
                                          Divider(
                                            height: 40.0,
                                            thickness: 1.5,
                                            indent: 32.0,
                                            endIndent: 32.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32.0, right: 32.0, bottom: 5),
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
                                            visible: user.firstname != 'null' &&  user.firstname.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'First Name:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(user.firstname.toString()),
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
                                            visible: user.lastname != 'null' && user.lastname.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Last Name:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(user.lastname.toString()),
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
                                            visible:  user.fathername != 'null' &&  user.fathername.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Father Name:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(user.fathername.toString()),
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
                                            visible: user.mothername != 'null' &&  user.mothername.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Mother Name:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(user.mothername.toString()),
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
                                            visible: user.phoneno != 'null' &&  user.phoneno.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Phone No:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(user.phoneno.toString()),
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
                                            visible: user.dob != 'null' && user.dob.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Date of Birth:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(user.dob.toString()),
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
                                            visible: user.gender != 'null' && user.gender.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Gender:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.gender.toString().toLowerCase()))
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
                                            visible: user.userType != 'null' &&  user.userType.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'User Type:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.userType.toString().toLowerCase()))
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
                                            visible: user.maritalStatus != 'null' &&  user.maritalStatus.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Marital Status:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.maritalStatus.toString().toLowerCase()))
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
                                            visible: user.memberType != 'null' && user.memberType.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Member Type:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.memberType.toString().toLowerCase()))
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
                                            visible: user.nationality != 'null' && user.nationality.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Nationality:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.nationality.toString().toLowerCase()))
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
                                            visible: user.status != 'null' && user.status.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Status:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.status.toString().toLowerCase()))
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
                                            visible: user.address != 'null' && user.address.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Address:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.address.toString().toLowerCase()))
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
                                            visible: user.identityProof != 'null' && user.identityProof.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Identity Proof:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.identityProof.toString().toLowerCase()))
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
                                            visible: user.identityProofNo != 'null' && user.identityProofNo.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Identity Proof No:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.identityProofNo.toString().toLowerCase()))
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
                                            visible: user.qualification != 'null' && user.qualification.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Qualification:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.qualification.toString().toLowerCase())),
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
                                            visible: user.jobType != 'null' && user.jobType.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Job Type:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.jobType.toString().toLowerCase())),
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
                                            visible: user.jobportal != 'null' && user.jobportal.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Job portal:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.jobportal.toString().toLowerCase())),
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
                                            visible:  user.jobdetails != 'null' && user.jobdetails.isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 32.0, right: 32.0),
                                                    child: Align(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Job details:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(user.jobdetails.toString().toLowerCase())),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ]
                                              )
                                            ),
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