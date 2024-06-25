import 'package:flutter/material.dart';

import '../../Styles/colors.dart';
import '../../Styles/commonicons.dart';
import '../profile/myProfile.dart';
import 'membersList.dart';

class BalanceDetailsPage extends StatefulWidget {
  final Map<String, dynamic> memberData;

  BalanceDetailsPage({required this.memberData});

  @override
  _BalanceDetailsPageState createState() => _BalanceDetailsPageState();
}

class _BalanceDetailsPageState extends State<BalanceDetailsPage> {
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
      appBar: AppBar(
        title: Text(
          "View Balance Details",
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
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text('Member ID: ${widget.memberData['memberId']}', style: TextStyle(fontSize: 18)),
      //       SizedBox(height: 10),
      //       // Text('Balance: \u{20B9} ${widget.balance}', style: TextStyle(fontSize: 18)),
      //       // Add more details or widgets here
      //     ],
      //   ),
      // ),

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
                                          SizedBox(height: 5.0),
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
                                          // SizedBox(height: 5.0),
                                         
                                          Divider(
                                            height: 40.0,
                                            thickness: 1.5,
                                            indent: 32.0,
                                            endIndent: 32.0,
                                          ),
                                          Visibility(
                                            visible: widget.memberData["firstname"] != 'null',
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 25.0, right: 32.0,bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Old  Balance:',
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            print('Button pressed');
                                                          },
                                                          child: Text('\u{20B9}'+ '100',style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),),
                                                          style: TextButton.styleFrom(
                                                            primary: Colors.blue, // Text color 
                                                            padding: EdgeInsets.zero, // Remove padding
                                                            minimumSize: Size(0, 0), // Remove minimum size constraints
                                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
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
                                                    padding: const EdgeInsets.only(left: 25.0, right: 32.0,bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Chantha  Balance:',
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            print('Button pressed');
                                                          },
                                                          child: Text('\u{20B9}'+ '100',style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),),
                                                          style: TextButton.styleFrom(
                                                            primary: Colors.blue, // Text color 
                                                            padding: EdgeInsets.zero, // Remove padding
                                                            minimumSize: Size(0, 0), // Remove minimum size constraints
                                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
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
                                                    padding: const EdgeInsets.only(left: 25.0, right: 32.0,bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Events balance:',
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            print('Button pressed');
                                                          },
                                                          child: Text('\u{20B9}'+ '1600',style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),),
                                                          style: TextButton.styleFrom(
                                                            primary: Colors.blue, // Text color 
                                                            padding: EdgeInsets.zero, // Remove padding
                                                            minimumSize: Size(0, 0), // Remove minimum size constraints
                                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
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
                                                    padding: const EdgeInsets.only(left: 25.0, right: 32.0,bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Committee Meeting Balance:',
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            print('Button pressed');
                                                          },
                                                          child: Text('\u{20B9}'+ '100',style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),),
                                                          style: TextButton.styleFrom(
                                                            primary: Colors.blue, // Text color 
                                                            padding: EdgeInsets.zero, // Remove padding
                                                            minimumSize: Size(0, 0), // Remove minimum size constraints
                                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
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
                                                    padding: const EdgeInsets.only(left: 25.0, right: 32.0,bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Death Balance:',
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            print('Button pressed');
                                                          },
                                                          child: Text('\u{20B9}'+ '100',style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),),
                                                          style: TextButton.styleFrom(
                                                            primary: Colors.blue, // Text color 
                                                            padding: EdgeInsets.zero, // Remove padding
                                                            minimumSize: Size(0, 0), // Remove minimum size constraints
                                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Container(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 25.0, right: 32.0,bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Total Balance:',
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      ),
                                                      Text('\u{20B9}'+ widget.memberData["balanceTribute"].toString(),
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(52, 52, 53, 1),
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 10.0),
                                              ],
                                            ),
                                          )
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
