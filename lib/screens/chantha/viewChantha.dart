import 'dart:core';
import 'package:flutter/material.dart';
import '../../common/theme_helper.dart';
import '../profile/myProfile.dart';
import '/services/auth_services.dart';
import '/Styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'addChantha.dart';
import 'chanthaList.dart';
import '../../services/chantha_services.dart';

String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}

class ViewChantha extends StatefulWidget {

  final Map<String, dynamic> chanthaData;

  ViewChantha({required this.chanthaData});

  @override
  _ViewChanthaState createState() => _ViewChanthaState();
}

class _ViewChanthaState extends State<ViewChantha> {
  late ChanthaService chanthaService;
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
  void initState() {
    super.initState();

    chanthaService = ChanthaService();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDate = widget.chanthaData["effectiveDate"];
    final status = widget.chanthaData["status"];  
    final remark = widget.chanthaData["remark"];
    final chanthaid = widget.chanthaData["_id"];
    Color statusColor = Colors.green;
    if(status == 'active'){
      statusColor= Colors.green;
    } else if(status == 'close'){
      statusColor= Colors.red;
    } else if(status == 'delete'){
      statusColor= Colors.black;
    }
    int amount = widget.chanthaData["amount"];
    final List<dynamic> rawData = widget.chanthaData["chanthaHistory"];
    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(rawData);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "View Chantha Details",
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
                    ChanthaList(),
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
                                                    'Chantha Details',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16.0,
                                                      color: Color.fromRGBO(50, 50, 93, 1),
                                                    ),
                                                  ),
                                                  FractionalTranslation(
                                                    translation: Offset(2.75, 0),
                                                    child: IconButton(
                                                      color: Colors.blue,
                                                      icon: Icon(Icons.edit),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => AddChantha(
                                                                  chanthaData:
                                                                      widget.chanthaData,
                                                                  pageaction: 'edit')),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  FractionalTranslation(
                                                    translation: Offset(3, 0),
                                                    child: IconButton(
                                                      color: Colors.blue,
                                                      icon: Icon(Icons.delete),
                                                      onPressed: () {
                                                        print(chanthaid);
                                                        _showDeleteConfirmationDialog(context,chanthaid);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: widget.chanthaData["amount"] != 'null',
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
                                                            'Amount:',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.chanthaData["amount"]
                                                              .toString()),
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
                                                widget.chanthaData["effectiveDate"] != 'null',
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
                                                            'Effective Date:',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(widget.chanthaData[
                                                                  "effectiveDate"]
                                                              .toString()),
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
                                            visible: widget.chanthaData["status"] != 'null',
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
                                                          Text(widget.chanthaData["status"]
                                                              .toString()),
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
                                                    'Chantha Payed History',
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
                                          // Add the ListView.builder here
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 0, bottom: 5),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                final record = data[index];
                                                return ExpansionTile(
                                                  title: Text('Date: ${record["_id"]}'),
                                                  children: List.generate(record["records"].length, (recordIndex) {
                                                    final item = record["records"][recordIndex];
                                                    return Column(
                                                      children: [
                                                        ListTile(
                                                          title: Text('Member ID: ${item["memberId"]}'),
                                                          subtitle: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text('Member Name: ${item["firstname"]}'), // additional field
                                                              Text('Amount: \u{20B9} ${item["amount"]}'),
                                                              Text('Payee: ${item["payeefirstname"]} ${item["payeelastname"]}'),
                                                              Text('Payee Position: ${item["payeeposition"]}'),
                                                            ],
                                                          ),
                                                          trailing: Text('Status: ${item["status"]}'), // another additional field
                                                        ),
                                                        if (recordIndex < record["records"].length - 1) Divider(), // Add a divider below the ListTile
                                                      ],
                                                    );
                                                  }),
                                                );
                                              },
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

  void _showDeleteConfirmationDialog(BuildContext context, String chanthaid) {
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
                  chanthaService.deleteChanthaDetails(
                    context: context,
                    chanthaid: chanthaid,
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

