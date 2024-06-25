import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/member_provider.dart';
import '../../services/member_services.dart';
import '../dashboard/dashboard.dart';
import '../member/membersList.dart';
import '../profile/myProfile.dart';
import '/services/auth_services.dart';
import '/Styles/colors.dart';
import '/Styles/commonicons.dart';

String selectedStatusValue = 'active';
List<String> statusDropdownItems = ['active', 'death', 'dismiss'];

String selectedTypeValue = 'full';
List<String> typeDropdownItems = ['full', 'half'];

String selectedGenderValue = 'male';
List<String> genderDropdownItems = ['male', 'female'];

bool ShowGenderFilter = false;
bool isShowSearch = false;
bool isShowfilter = false;
bool isDisabled = false;
int _selectedTab = 1;

final TextEditingController _searchController = TextEditingController();


final _formKey = GlobalKey<FormState>();

List<dynamic> useritems = [];
List<dynamic> tempitems = [];

DateFormat dateFormat = DateFormat("dd-MM-yyyy");

class AdministratorList extends StatefulWidget {
  final String pageTitle;
  final String pageType;
  AdministratorList({required this.pageTitle, required this.pageType});
  @override
  _AdministratorListState createState() => _AdministratorListState();
}

void signOutUser(BuildContext context) {
  AuthService().signOut(context);
}


class _AdministratorListState extends State<AdministratorList> {
  final AuthService authService = AuthService();
  final ScrollController _firstController = ScrollController();

  late MemberService memberService;
  late Function getMembersList;

  bool _isListView = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    memberService = MemberService();
    Future.delayed(const Duration(milliseconds: 1), () {
      getMembersList();
      setState(() {
        _isLoading = !_isLoading;
      });
    });

    setState(() {
      selectedStatusValue = 'active';
      selectedTypeValue = 'full';
      selectedGenderValue = 'male';
      useritems = tempitems;
      isShowSearch = false;
      isShowfilter = false;
    });
  }

  resetFilter(){
    setState(() {
      selectedStatusValue = 'active';
      selectedTypeValue = 'full';
      selectedGenderValue = 'male';
      useritems = tempitems;
    });
  }

  @override
  Widget build(BuildContext context) {
    getMembersList = () async {
      String memberType = "";
      String gender = '';

      if(widget.pageType == "all"){
        memberType = "";
        gender = '';
        setState(() {
          ShowGenderFilter = true;
        });
      }

      await memberService.getAdministratorsList(context, memberType, gender);
      setState(() {
        _isLoading = !_isLoading;
      });
    };
    final members = Provider.of<MemberProvider>(context, listen: true).memberDetails;

    _changeTab(int index) {
      setState(() {
        _selectedTab = index;
      });
      if(_selectedTab == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => dashboardPage(),
          ),
        );
      } else if(_selectedTab == 1) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          color:Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => dashboardPage(),
              ),
            );
          },
        ),
        actions: [
          ToggleButtons(
            isSelected: [_isListView, !_isListView],
            onPressed: (int newIndex) {
              setState(() {
                _isListView = newIndex == 0;
              });
            },
            children: [
              Icon(Icons.list),
              Icon(Icons.grid_view),
            ],
          ),
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
      body: Column(
        children: [
          SizedBox(height: 10,),
          Text(
            widget.pageTitle,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          SizedBox(height: 2),
          _isLoading ? Center(child: CircularProgressIndicator()) :
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Expanded(
                  child: Scrollbar(
                    thickness: 10.0,
                    thumbVisibility: true,
                    controller: _firstController,
                    child: _isListView
                        ? ListView.builder(
                            controller: _firstController,
                            itemCount: members!.memberDetails.length,
                            itemBuilder: (context,index) {
                              final userid = members.memberDetails[index].id;
                              final firstname = members.memberDetails[index].firstname;
                              final lastname = members.memberDetails[index].lastname;
                              final memberId = members.memberDetails[index].memberId;
                              final gender = members.memberDetails[index].gender;
                              final status = members.memberDetails[index].status;  
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
                              return GestureDetector(
                                onTap: () {
                                  authService.getMemberDetails(
                                    context: context,
                                    userid: userid,
                                    page: 'admin'
                                  );
                                },
                                child: SingleChildScrollView(
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.only(left:0,top: 2,bottom:2),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: statusColor,
                                              child: Container(
                                                padding: EdgeInsets.all(2),
                                                child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: AssetImage(imgeIcon),
                                                  backgroundColor: statusColor,
                                                ),
                                              ),
                                            ),
                                            title: Text(lastname + ' ' +firstname,style: TextStyle(fontSize: 16)),
                                            subtitle: Text('Member Id: '+memberId.toString(),style: TextStyle(fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : GridView.count(
                            childAspectRatio: 1.0,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: members!.memberDetails.map((data) {
                              final gender = data.gender;
                              final status = data.status;  
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
                              return GestureDetector(
                                onTap: () {
                                  authService.getMemberDetails(
                                    context: context,
                                    userid: data.id,
                                    page: 'admin'
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: statusColor,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: AssetImage(imgeIcon),
                                            backgroundColor: statusColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(data.lastname + ' ' + data.firstname ,style: TextStyle(fontSize: 12), textAlign: TextAlign.center,softWrap: true, ),
                                      SizedBox(height: 8),
                                      Text(
                                        data.memberId
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                  ),
                ),
              ],
            ),
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
