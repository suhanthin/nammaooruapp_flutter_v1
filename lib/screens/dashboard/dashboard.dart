import 'package:flutter/material.dart';
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

class dashboardPage extends StatefulWidget {
  static const String routeName = '/dashboardPage';
  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

void signOutUser(BuildContext context) {
  AuthService().signOut(context);
}

class _dashboardPageState extends State<dashboardPage> {
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(
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
                                        child: Text(
                                          '\u{20B9}${2880}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: const Color(0xFF000000),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                                        ),
                                        child: Text("Ledger Balance",style: TextStyle(color: Colors.white, fontSize: 12.0,)),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () { 
                                  print("Click Ledger Balance Container"); 
                                },
                              ),
                              
                              InkWell(
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
                                        child: Text(
                                          '\u{20B9}${2880}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: const Color(0xFF000000),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                                        ),
                                        child: Text("Chantha Balance",style: TextStyle(color: Colors.white, fontSize: 12.0)),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () { 
                                  print("Click Chantha Balance Container"); 
                                },
                              ),

                              InkWell(
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
                                        child: Text(
                                          '\u{20B9}${2880000}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: const Color(0xFF000000),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
                                        ),
                                        child: Text("Accounts Amount",style: TextStyle(color: Colors.white, fontSize: 12.0)),
                                        padding: const EdgeInsets.all(10),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () { 
                                  print("Click accounts Container"); 
                                },
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height:20,
                                      ),
                                      Text(
                                        "Members",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height:10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          MembersCountWidget(size: size),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Quick Links",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height:20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            child: iconCircle( Color(0xFF4cd1fe), "Chantha", Icons.schedule),
                                            onTap: () { 
                                              print("Click Chantha icon"); 
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ChanthaList(),
                                                ),
                                              );
                                            },
                                          ),
                                          InkWell(
                                            child: iconCircle( Color(0xFF6db4e0), "Commitee", Icons.calendar_month_sharp),
                                            onTap: () { 
                                              print("Click Commitee icon"); 
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => CommiteeList(),
                                                ),
                                              );
                                            },
                                          ),
                                          InkWell(
                                            child: iconCircle( Color(0xFFc4a1ff), "Death", Icons.payment),
                                            onTap: () { 
                                              print("Click Report icon"); 
                                            },
                                          ),
                                          InkWell(
                                            child: iconCircle( Color(0xFFff7bbd), "Events", Icons.account_box),
                                            onTap: () { 
                                              print("Click Death icon"); 
                                            },
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height:20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            child: iconCircle( Color(0xFFff7bbd), "Death", Icons.account_box),
                                            onTap: () { 
                                              print("Click Death icon"); 
                                            },
                                          ),
                                          InkWell(
                                            child: iconCircle( Color(0xFF6db4e0), "Collection", Icons.currency_rupee),
                                            onTap: () { 
                                              print("Click Collection icon"); 
                                            },
                                          ),
                                          InkWell(
                                            child: iconCircle( Color(0xFFc4a1ff), "Report", Icons.payment),
                                            onTap: () { 
                                              print("Click Report icon"); 
                                            },
                                          ),
                                          InkWell(
                                            child: iconCircle( Color(0xFFAAECB2), "Scan", Icons.barcode_reader),
                                            onTap: () { 
                                              print("Click Report icon"); 
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      )
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
}