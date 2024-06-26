import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../administrator/administratorList.dart';
import '../dashboard/dashboard.dart';
import '../member/membersList.dart';
import '../profile/myProfile.dart';
import '../../services/auth_services.dart';
import '/Styles/colors.dart';
import 'addChantha.dart';
import '../../providers/chantha_provider.dart';
import '../../services/chantha_services.dart';

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
int _selectedTab = 0;

final TextEditingController _searchController = TextEditingController();


final _formKey = GlobalKey<FormState>();

List<dynamic> useritems = [];
List<dynamic> tempitems = [];

DateFormat dateFormat = DateFormat("dd-MM-yyyy");

class ChanthaList extends StatefulWidget {
  const ChanthaList({Key? key}) : super(key: key);
  @override
  _ChanthaListState createState() => _ChanthaListState();
}

void signOutUser(BuildContext context) {
  AuthService().signOut(context);
}


class _ChanthaListState extends State<ChanthaList> {
  final AuthService authService = AuthService();
  final ScrollController _firstController = ScrollController();

  late ChanthaService chanthaService;
  late Function getChanthaList;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    chanthaService = ChanthaService();
    Future.delayed(const Duration(milliseconds: 1), () {
      getChanthaList();
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
    getChanthaList = () async {
      await chanthaService.getChanthaList(context);
      setState(() {
        _isLoading = !_isLoading;
      });
    };
    final chantha = Provider.of<ChanthaProvider>(context, listen: true).chanthaDetails;
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
            "Chantha List",
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
                    child:ListView.builder(
                      controller: _firstController,
                      itemCount: chantha!.chanthaDetails.length,
                      itemBuilder: (context,index) {
                        final chanthaid = chantha.chanthaDetails[index].id;
                        final amount = chantha.chanthaDetails[index].amount;
                        final effectiveDate = chantha.chanthaDetails[index].effectiveDate;
                        final remark = chantha.chanthaDetails[index].remark;
                        final status = chantha.chanthaDetails[index].status; 
                        final CardNo = index + 1; 
                        Color statusColor = Colors.green;
                        if(status == 'active'){
                          statusColor= Colors.green;
                        } else if(status == 'close'){
                          statusColor= Colors.red;
                        } else if(status == 'delete'){
                          statusColor= Colors.black;
                        }
                        return GestureDetector(
                          onTap: () {
                            chanthaService.getChanthaDetails(
                              context: context,
                              chanthaid: chanthaid,
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
                                        backgroundColor: statusColor,
                                        child: Text(CardNo.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),),
                                      ),
                                      title: Text('Chantha Amount: '+amount.toString(),style: TextStyle(fontSize: 16)),
                                      subtitle: Text('Effective Date: '+effectiveDate.toString(),style: TextStyle(fontSize: 15)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddChantha(chanthaData: {}, pageaction : 'add')),
            );
          },
          child: Icon(Icons.add,  color: Colors.white70),
          backgroundColor: primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
