import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../profile/myProfile.dart';
import '/services/auth_services.dart';
import '/Styles/colors.dart';
import '/Styles/commonicons.dart';

class familyMemberProfile extends StatefulWidget {

  final Map<String, dynamic> memberData;

  familyMemberProfile({required this.memberData});

  @override
  _familyMemberProfileState createState() => _familyMemberProfileState();
}

class _familyMemberProfileState extends State<familyMemberProfile> {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "View Family Member Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
                                            visible: widget.memberData["familyname"] != 'null' &&  widget.memberData["familyname"].isNotEmpty,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Align(
                                                    child: Text(
                                                      widget.memberData["familyname"].toString(),
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
                                              widget.memberData["familyId"],
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
                                            ],
                                          ),
                                          Divider(
                                            height: 40.0,
                                            thickness: 1.5,
                                            indent: 32.0,
                                            endIndent: 32.0,
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       left: 32.0, right: 32.0, bottom: 5),
                                          //   child: Align(
                                          //     child: Row(
                                          //       children: [
                                          //         Text(
                                          //           'Member Details',
                                          //           style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,color: Color.fromRGBO(50, 50, 93, 1),),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(height: 10.0),
                                          Visibility(
                                            visible: widget.memberData.containsKey("firstname") && widget.memberData["firstname"] != 'null' &&  widget.memberData["firstname"].isNotEmpty,
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
                                            visible: widget.memberData.containsKey("lastname") && widget.memberData["lastname"] != 'null' &&  widget.memberData["lastname"].isNotEmpty,
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
                                            visible:  widget.memberData.containsKey("fathername") && widget.memberData["fathername"] != 'null' &&  widget.memberData["fathername"].isNotEmpty,
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
                                            visible: widget.memberData.containsKey("mothername") && widget.memberData["mothername"] != 'null' &&  widget.memberData["mothername"].isNotEmpty,
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
                                            visible: widget.memberData.containsKey("phoneno") && widget.memberData["phoneno"] != 'null' &&  widget.memberData["phoneno"].isNotEmpty,
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
                                            visible: widget.memberData.containsKey("dob") && widget.memberData["dob"] != 'null' &&  widget.memberData["dob"].isNotEmpty,
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
                                            visible: widget.memberData.containsKey("gender") && widget.memberData["gender"] != 'null' &&  widget.memberData["gender"].isNotEmpty,
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
                                                          Text(widget.memberData["gender"].toString()),
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
                                            visible: widget.memberData.containsKey("relation") && widget.memberData["relation"] != 'null' &&  widget.memberData["relation"].isNotEmpty,
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
                                                            'Relation:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.memberData["relation"].toString()),
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
                                            visible: widget.memberData.containsKey("husorwife_name") && widget.memberData["husorwife_name"] != 'null' &&  widget.memberData["husorwife_name"].isNotEmpty,
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
                                                            widget.memberData["relation"] == 'wife' ? 'Husband Name:' : 'Wife Name:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.memberData["husorwife_name"].toString()),
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
                                            visible: widget.memberData.containsKey("nationlaity") &&  widget.memberData["nationlaity"] != 'null' && widget.memberData["nationlaity"].isNotEmpty,
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
                                                            'Nationlaity:',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.memberData["nationlaity"].toString()),
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
                                            visible: widget.memberData.containsKey("status") &&  widget.memberData["status"] != 'null' && widget.memberData["status"].isNotEmpty,
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
                                                          Text(widget.memberData["status"].toString()),
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
                                            visible: widget.memberData.containsKey("address") &&  widget.memberData["address"] != 'null' && widget.memberData["address"].isNotEmpty,
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
                                                          Text(widget.memberData["address"].toString()),
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
                                            visible: widget.memberData.containsKey("identityProof") &&  widget.memberData["identityProof"] != 'null' && widget.memberData["identityProof"].isNotEmpty,
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
                                                          Text(widget.memberData["identityProof"].toString()),
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
                                            visible: widget.memberData.containsKey("identityProofNo") &&  widget.memberData["identityProofNo"] != 'null' && widget.memberData["identityProofNo"].isNotEmpty,
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
                                                          Text(widget.memberData["identityProofNo"].toString()),
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
                                            visible: widget.memberData.containsKey("qualification") &&  widget.memberData["qualification"] != 'null' && widget.memberData["qualification"].isNotEmpty,
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
                                                          Text(widget.memberData["qualification"].toString()),
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
                                            visible: widget.memberData.containsKey("jobType") &&  widget.memberData["jobType"] != 'null' && widget.memberData["jobType"].isNotEmpty,
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
                                                          Text(widget.memberData["jobType"].toString()),
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
                                            visible: widget.memberData.containsKey("jobportal") &&  widget.memberData["jobportal"] != 'null' && widget.memberData["jobportal"].isNotEmpty,
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
                                                          Text(widget.memberData["jobportal"].toString()),
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
                                            visible:  widget.memberData.containsKey("jobdetails") &&  widget.memberData["jobdetails"] != 'null' && widget.memberData["jobdetails"].isNotEmpty,
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
                                                          Text(widget.memberData["jobdetails"].toString()),
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
                          FractionalTranslation(
                            translation: Offset(0.0, -0.5),
                            child: Align(
                              child:CircleAvatar(
                                radius: 50.0,
                                backgroundImage: AssetImage(imgeIcon),
                                backgroundColor: statusColor,
                              ),
                              alignment: FractionalOffset(0.5, 0.0),
                            ),
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

// class MyPersonalDetails extends StatelessWidget //__
// {
//   const MyPersonalDetails({super.key});
//   @override
//   Widget build(context) //__
//   {
//     return Column(
//       children: [
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               'First name:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(width: 10),
//             Text(user.firstname),
//           ],
//         ),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               'Last name:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(width: 10),
//             Text(user.lastname),
//           ],
//         ),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               'Father name:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(width: 10),
//             Text(user.fathername),
//           ],
//         ),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               'Mother name:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(width: 10),
//             Text(user.mothername),
//           ],
//         ),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               'Phone no:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(width: 10),
//             Text(user.phoneno),
//           ],
//         ),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               'Gender:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(width: 10),
//             Text(user.gender),
//           ],
//         ),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               'Date of Birth:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(width: 10),
//             Text(user.dob),
//           ],
//         ),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }