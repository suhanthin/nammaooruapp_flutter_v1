import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../administrator/administratorList.dart';
import '../dashboard/dashboard.dart';
import '../member/membersList.dart';
import '../profile/myProfile.dart';
import '../../services/auth_services.dart';
import '/Styles/colors.dart';
import 'addCommitee.dart';
import '../../providers/commitee_provider.dart';
import '../../services/commitee_services.dart';

class CommiteeList extends StatefulWidget {
  const CommiteeList({Key? key}) : super(key: key);

  @override
  _CommiteeListState createState() => _CommiteeListState();
}

void signOutUser(BuildContext context) {
  AuthService().signOut(context);
}

class _CommiteeListState extends State<CommiteeList> {
  final ScrollController _firstController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  late CommiteeService commiteeService;
  late Function getCommiteeList;

  bool _isLoading = false;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    commiteeService = CommiteeService();
    getCommiteeList = () async {
      await commiteeService.getCommiteeList(context);
      setState(() {
        _isLoading = false;
      });
    };

    Future.delayed(const Duration(milliseconds: 1), () {
      getCommiteeList();
      setState(() {
        _isLoading = true;
      });
    });
  }

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
    if (_selectedTab == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => dashboardPage(),
        ),
      );
    } else if (_selectedTab == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdministratorList(pageTitle: 'Administrators list', pageType: 'all'),
        ),
      );
    } else if (_selectedTab == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MembersList(pageTitle: 'Members list', pageType: 'all'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final commitee = Provider.of<CommiteeProvider>(context, listen: true).commiteeDetails;

    return Scaffold(
      appBar: AppBar(
        title: Text('Commitee List', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
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
      body: _isLoading
      ? Center(child: CircularProgressIndicator())
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: Scrollbar(
                thickness: 10.0,
                isAlwaysShown: true,
                controller: _firstController,
                child: ListView.builder(
                  controller: _firstController,
                  itemCount: commitee?.commiteeDetails?.length ?? 0,
                  itemBuilder: (context, index) {
                    if (commitee == null || commitee.commiteeDetails.isEmpty) {
                      return Center(child: Text('No committee list available'));
                    }
                    final commiteeid = commitee.commiteeDetails[index].id;
                    final fineAmount = commitee.commiteeDetails[index].fineAmount;
                    final title = commitee.commiteeDetails[index].title;
                    final meetingDate = commitee.commiteeDetails[index].meetingDate;
                    final remark = commitee.commiteeDetails[index].remark;
                    final status = commitee.commiteeDetails[index].status;
                    final cardNo = index + 1;
                    Color statusColor;

                    switch (status) {
                      case 'active':
                        statusColor = Colors.green;
                        break;
                      case 'close':
                        statusColor = Colors.red;
                        break;
                      case 'delete':
                        statusColor = Colors.black;
                        break;
                      default:
                        statusColor = Colors.grey;
                    }

                    return GestureDetector(
                      onTap: () {
                        commiteeService.getCommiteeDetails(
                          context: context,
                          commiteeid: commiteeid,
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: statusColor,
                              child: Text(
                                cardNo.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Text(
                              'Meeting Title: $title',
                              style: TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              'Meeting Date: $meetingDate',
                              style: TextStyle(fontSize: 15),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCommitee(commiteeData: {}, pageaction: 'add')),
          );
        },
        child: Icon(Icons.add, color: Colors.white70),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
