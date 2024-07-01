import 'dart:core';
import 'package:flutter/material.dart';
import '../../common/theme_helper.dart';
import '../../services/commitee_services.dart';
import '../profile/myProfile.dart';
import '/services/auth_services.dart';
import '/Styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'addCommitee.dart';
import 'commiteeList.dart';
import '../../services/chantha_services.dart';

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}

class ViewCommitee extends StatefulWidget {
  final Map<String, dynamic> commiteeData;
  ViewCommitee({required this.commiteeData});
  @override
  _ViewCommiteeState createState() => _ViewCommiteeState();
}

class _ViewCommiteeState extends State<ViewCommitee> {
  late CommiteeService commiteeService;
  void signOutUser(BuildContext context) {
    AuthService().signOut(context);
  }

  @override
  void initState() {
    super.initState();

    commiteeService = CommiteeService();
  }

  void _showInfoDialog(BuildContext context, Map<String, dynamic> userDetails) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pay Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Name: ${userDetails['firstname']} ${userDetails['lastname']}'),
              Text('Payee Status: ${userDetails['paystatus']}'),
              if (userDetails['payeefirstname'] != null && userDetails['payeefirstname'].isNotEmpty)
                Text('Payee Name: ${userDetails['payeefirstname']} ${userDetails['payeelastname']}'),
              if (userDetails['payeeposition'] != null && userDetails['payeeposition'].isNotEmpty)
                Text('Payee Position: ${userDetails['payeeposition']}'),
              if (userDetails['paidDate'] != null && userDetails['paidDate'].isNotEmpty)
                Text('paid Date: ${userDetails['paidDate']}'),
              if (userDetails['receiptNo'] != null && userDetails['receiptNo'].isNotEmpty)
                Text('Receipt No: ${userDetails['receiptNo']}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (userDetails['receiptNo'] != null && userDetails['receiptNo'].isNotEmpty)
              TextButton(
                child: Text('View Receipt'),
                onPressed: () {
                  _showReceiptInfoDialog(context);
                },
              ),
          ],
        );
      },
    );
  }

  void _showReceiptInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'View Receipt',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0),
                // Add your content here
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    final meetingDate = widget.commiteeData["meetingDate"];
    final isAddAttendance = widget.commiteeData["isAddAttendance"];  
    final title = widget.commiteeData["title"];  
    final status = widget.commiteeData["status"];  
    final remark = widget.commiteeData["remark"];
    final description = widget.commiteeData["description"];
    final commiteeid = widget.commiteeData["_id"];
    Color statusColor = Colors.green;
    if(status == 'active'){
      statusColor= Colors.green;
    } else if(status == 'close'){
      statusColor= Colors.red;
    } else if(status == 'delete'){
      statusColor= Colors.black;
    }
    int fineAmount = widget.commiteeData["fineAmount"];
    final List<dynamic> rawData = widget.commiteeData["committeeMeetingHistory"];
    final List<Map<String, dynamic>> userDetails  = List<Map<String, dynamic>>.from(rawData);
    print(userDetails);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "View Commitee Details",
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
                    CommiteeList(),
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
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: .0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25.0, right: 32.0, bottom: 5),
                                            child: Align(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Commitee Details',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                      color: Color.fromRGBO(50, 50, 93, 1),
                                                    ),
                                                  ),
                                                  FractionalTranslation(
                                                    translation: Offset(2.50, 0),
                                                    child: IconButton(
                                                      color: Colors.blue,
                                                      icon: Icon(Icons.edit),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => AddCommitee(
                                                                  commiteeData:
                                                                      widget.commiteeData,
                                                                  pageaction: 'edit')),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FractionalTranslation(
                                                    translation: Offset(2.50, 0),
                                                    child: IconButton(
                                                      color: Colors.blue,
                                                      icon: Icon(Icons.delete),
                                                      onPressed: () {
                                                        print(commiteeid);
                                                        _showDeleteConfirmationDialog(context,commiteeid);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isAddAttendance,
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
                                                            'isAddAttendance:',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(isAddAttendance.toString().toLowerCase())),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: title != '',
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
                                                            'Title:',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(title.toString().toLowerCase())),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: fineAmount != '',
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
                                                            'Fine Amount:',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(fineAmount.toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                meetingDate != '',
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
                                                            'Meeting Date:',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(meetingDate.toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: description != '',
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
                                                            'Description:',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(description.toString().toLowerCase())),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: status != '',
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
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(status.toString().toLowerCase()), style: TextStyle(fontWeight: FontWeight.w800,color: statusColor)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: remark != '',
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
                                                            'Remark:',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(capitalize(remark.toString().toLowerCase()), style: TextStyle(fontWeight: FontWeight.w800,color: statusColor)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
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
                                                    'Commitee Attendance History',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                      color: Color.fromRGBO(50, 50, 93, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: List.generate(
                                              userDetails.length,
                                              (index) => Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                child: CheckboxListTile(
                                                  controlAffinity: ListTileControlAffinity.leading,
                                                  contentPadding: EdgeInsets.zero,
                                                  dense: true,
                                                  title: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          '${userDetails[index]['lastname']} ${userDetails[index]['firstname']}',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: (userDetails[index]['status'] == 'active') ? Colors.black : Colors.redAccent,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  secondary: (userDetails[index]['paystatus'] == 'no fine' || userDetails[index]['paystatus'] == 'paid')
                                                      ? IconButton(
                                                          icon: Icon(Icons.info_outline),
                                                          onPressed: () {
                                                            _showInfoDialog(context, userDetails[index]);
                                                          },
                                                        )
                                                      : null,
                                                  value: userDetails[index]['attendance'] == true,
                                                  onChanged: null,
                                                ),
                                              ),
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

  void _showDeleteConfirmationDialog(BuildContext context, String commiteeid) {
    TextEditingController reasonController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
                Divider(
                  height: 40.0,
                  thickness: 1.5,
                  indent: 32.0,
                  endIndent: 32.0,
                ),
                TextFormField(
                  controller: reasonController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  decoration: ThemeHelper().textInputDecorationNoicon("Reason for deletion", "Enter Reason", Icon(Icons.person, color: Colors.grey)),
                  onSaved: (String? value) { 
                    if (value != null) { 
                      reasonController.text = value;
                    }
                  },
                  maxLines: 1,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter Reason";
                    } else {
                      reasonController.text = val;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  String reason = reasonController.text;
                  Navigator.of(context).pop();
                  commiteeService.deleteCommiteeDetails(
                    context: context,
                    commiteeid: commiteeid,
                    reason: reason,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

