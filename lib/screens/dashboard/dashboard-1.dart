import 'package:flutter/material.dart';
import '../../providers/dashboard_provider.dart';
import '/screens/administrator/administratorList.dart'; 
import 'package:provider/provider.dart';
import '../chantha/chanthaList.dart';
import '../commitee/commiteeList.dart';
import '../member/membersList.dart';
import '../profile/myProfile.dart';
import '/providers/user_provider.dart';
import '/services/auth_services.dart';
import '/services/dashboard_services.dart';
import '/Styles/colors.dart';
import 'components/memberCountWidget.dart';
import '../../widgets/iconCircle.dart';
import 'dart:math';

class dashboardPage extends StatefulWidget {
  static const String routeName = '/dashboardPage';
  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

void signOutUser(BuildContext context) {
  AuthService().signOut(context);
}

class _dashboardPageState extends State<dashboardPage> {
  Random _random = Random();
  late DashboardService dashboardService;
  late Function getDashboard;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    
    dashboardService = DashboardService();
    Future.delayed(const Duration(milliseconds: 10), () {
      getDashboard();
    });
  }

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
    if(_selectedTab == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdministratorList(pageTitle: 'Administrators list',pageType:'all'),
        ),
      );
    } else if(_selectedTab == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MembersList(pageTitle: 'Members list',pageType:'all'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _selectedTab = 0;
    });
    // Get Dashboard Api
    getDashboard = () async {
      dashboardService.getDashboardData(context);
    };

    final user = Provider.of<UserProvider>(context).user;
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, 
        actions: [
          PopupMenuButton(
            color:Colors.white,
            onSelected: (result) {
                if (result == "Logout") {
                    signOutUser(context);
                } else if(result == 'MyAccount'){
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
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    width: double.infinity,
                    decoration: BoxDecoration(color: primaryColor.withOpacity(0.8)),
                  ),
                  Positioned(
                    top: -120,
                    left: -70,
                    child: Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(150.0)),
                    ),
                  ),
                  Positioned(
                    top: -100.0,
                    right: -50.0,
                    child: Container(
                      height: 250.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(125.0)),
                    ),
                  ),
                  Positioned(
                    top: 30.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Text('சரக்கல்விளை ஊர்',style: TextStyle(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10.0,
                          ),
                          Center(child: Text('இந்து நாடார் சமுதாயம்',style: TextStyle(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.bold))),
                          SizedBox(
                            height: 10.0,
                          ),
                          Center(child: Text('தேவி ஸ்ரீ முத்தாரம்மன் திருக்கோவில் டிரஸ்ட்',style: TextStyle(fontSize: 12.0, color: Colors.white,fontWeight: FontWeight.bold))),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            user!.firstname.toUpperCase() + " " + user.lastname.toUpperCase() +  " (" + user.memberId + ")",
                            style: TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            user.position == "" ? "MEMBER"  : user.position.toUpperCase(),
                            style: TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Column(children: <Widget>[
                      SizedBox(
                        height: 190.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  buildBalanceContainer('Ledger Balance', 2880),
                                  buildBalanceContainer('Chantha Balance', 2880),
                                  buildBalanceContainer('Accounts Amount', 2880000),
                                ],
                              ),
                              SizedBox(height: 10.0), // Adjusted height
                              buildMembersSection(size),
                              SizedBox(height: 20.0),
                              buildQuickLinksSection(context),
                            ],
                          ),
                        ],
                      ),
                    ]
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: primaryColor,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          type: BottomNavigationBarType.fixed, 
          selectedItemColor: Colors.white,
          unselectedItemColor: Color.fromARGB(217, 0, 0, 0),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp),
              label: 'User',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Members',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBalanceContainer(String label, int amount) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Text(
                '\u{20B9}$amount',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: const Color(0xFF000000),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
              ),
              padding: const EdgeInsets.all(10),
              child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12.0)),
            ),
          ],
        ),
      ),
      onTap: () {
        print("Click $label Container");
      },
    );
  }

  Widget buildMembersSection(Size size) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            "Members",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'A Class'),
                    Tab(text: 'B Class'),
                    Tab(text: 'C Class'),
                  ],
                  labelColor: Colors.black,             // Set the active color here
                  unselectedLabelColor: Colors.grey,   // Set the inactive color here
                  indicator: BoxDecoration(
                    color: primaryColor.withOpacity(0.1), // Background color for the active tab
                    border: Border(
                      bottom: BorderSide(
                        color: primaryColor.withOpacity(0.8),            // Set the active underline color
                        width: 2.0,                    // Set the active underline weight
                      ),
                    ),
                  ),
                  labelPadding: EdgeInsets.symmetric(vertical: 5.0),
                ),
                SizedBox(
                  height: 100, // or any height you need
                  child: TabBarView(
                    children: [
                      Card(
                        child: getTimeDateUI(context),
                      ),
                      Card(
                        child: Icon(Icons.directions_transit),
                      ),
                      Card(
                        child: Icon(Icons.directions_bike),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuickLinksSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            "Quick Links",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildQuickLinkIcon(context, "Chantha", Icons.schedule, Color(0xFF4cd1fe),ChanthaList()),
              buildQuickLinkIcon(context, "Commitee", Icons.calendar_month_sharp, Color(0xFF6db4e0),CommiteeList()),
              buildQuickLinkIcon(context, "Death", Icons.payment, Color(0xFFc4a1ff),null),
              buildQuickLinkIcon(context, "Events", Icons.account_box,Color(0xFFff7bbd), null),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildQuickLinkIcon(context, "Death", Icons.account_box,Color(0xFFff7bbd), null),
              buildQuickLinkIcon(context, "Collection", Icons.currency_rupee,Color(0xFF6db4e0), null),
              buildQuickLinkIcon(context, "Report", Icons.payment,Color(0xFFc4a1ff), null),
              buildQuickLinkIcon(context, "Scan", Icons.barcode_reader,Color(0xFFAAECB2), null),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildQuickLinkIcon(BuildContext context, String label, IconData icon,Color color, Widget? destination) {
    return InkWell(
      child: iconCircle(color, label, icon),
      onTap: () {
        if (destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        } else {
          print("Click $label icon");
        }
      },
    );
  }

  Widget _buildSendMoneySection(context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              "Male",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 2,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25,
                      child: Text(
                        '500',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: Colors.lightGreen,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Active',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              )
            ]
          ),
        ],
      ),
    );
  }

  Widget getTimeDateUI(context) {
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
    return Padding(
      padding: const EdgeInsets.only(left: 18,),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Male',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            aClassMaleMembers.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8,),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Female',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            aClassFemaleMembers.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}