import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import '../../member/membersList.dart';
import '/providers/dashboard_provider.dart';
import '/Styles/colors.dart';
import '/Styles/Styles.dart';

class MembersCountWidget extends StatelessWidget {
  const MembersCountWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final dashboard = Provider.of<DashboardProvider>(context).dashboardDetails;
    String? aClassMaleMembers;
    String? aClassFemaleMembers;
    String? bClassMaleMembers;
    String? bClassFemaleMembers;
    String? cClassFemaleMembers;
    if (dashboard != null) {
      aClassMaleMembers = dashboard.aClassMaleMembers.toString();
      aClassFemaleMembers = dashboard.aClassFemaleMembers.toString();
      bClassMaleMembers = dashboard.bClassMaleMembers.toString();
      bClassFemaleMembers = dashboard.bClassFemaleMembers.toString();
      cClassFemaleMembers = dashboard.cClassFemaleMembers.toString();
    } else {
      aClassMaleMembers = "0";
      aClassFemaleMembers = "0";
      bClassMaleMembers = "0";
      bClassFemaleMembers = "0";
      cClassFemaleMembers = "0";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              child: SizedBox(
                height: size.width * .33,
                width: size.width * .26,
                child: Center(
                  child: Column(children: [
                    Container(
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.male, color: Colors.orange),
                                Text(
                                  "Male",
                                  style: styleDate,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  aClassMaleMembers.toString(),
                                  style: tStyleDate,
                                )
                              ],
                            ),
                            onTap: () { 
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MembersList(pageTitle: 'A class Male Members list',pageType:'aclass_male'),
                                ),
                              );
                            },
                          ),

                          InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.female, color: Colors.orange),
                                Text(
                                  "Female",
                                  style: styleDate,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  aClassFemaleMembers.toString(),
                                  style: tStyleDate,
                                )
                              ],
                            ),
                            onTap: () { 
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MembersList(pageTitle: 'A class Female Members list',pageType:'aclass_female'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 28.5,
                      width: size.width * .26,
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(color: primaryColor),
                      child: Center(
                        child: Text(
                          'A Class',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Card(
              child: SizedBox(
                height: size.width * .33,
                width: size.width * .26,
                child: Center(
                  child: Column(children: [
                    Container(
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.female, color: Colors.orange),
                                    Text(
                                      "Male",
                                      style: styleDate,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      bClassMaleMembers.toString(),
                                      style: tStyleDate,
                                    )
                                  ],
                                ),
                                onTap: () { 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MembersList(pageTitle: 'B class Male Members list',pageType:'bclass_male'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.female, color: Colors.orange),
                                    Text(
                                      "Female",
                                      style: styleDate,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      bClassFemaleMembers.toString(),
                                      style: tStyleDate,
                                    )
                                  ],
                                ),
                                onTap: () { 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MembersList(pageTitle: 'B class Female Members list',pageType:'bclass_female'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 28.5,
                      width: size.width * .26,
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(color: primaryColor),
                      child: Center(
                        child: Text(
                          'B Class',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Card(
              child: SizedBox(
                height: size.width * .33,
                width: size.width * .26,
                child: Center(
                  child: Column(children: [
                    Container(
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.female, color: Colors.orange),
                                    Text(
                                      "Female",
                                      style: styleDate,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      cClassFemaleMembers.toString(),
                                      style: tStyleDate,
                                    )
                                  ],
                                ),
                                onTap: () { 
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MembersList(pageTitle: 'C class Female Members list',pageType:'cclass_female'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 28.5,
                      width: size.width * .26,
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(color: primaryColor),
                      child: Center(
                        child: Text(
                          'C Class',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
