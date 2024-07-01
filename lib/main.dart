import 'package:flutter/material.dart';
import '/providers/commitee_provider.dart';
import '/providers/searchmember_provider.dart';
import '/screens/dashboard/dashboard.dart';
import '/providers/dashboard_provider.dart';
import '/providers/member_provider.dart';
import 'package:provider/provider.dart';
import '/services/auth_services.dart';
import '/providers/user_provider.dart';
import '/screens/login/login_screen.dart';
// import '/screens/user_dashboard_screen.dart';
// import '/screens/chit_dashboard_screen.dart';
import 'Styles/colors.dart';
import '/providers/chantha_provider.dart';
import '/providers/custom_member_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => MemberProvider()),
        ChangeNotifierProvider(create: (_) => SearchMemberProvider()),
        ChangeNotifierProvider(create: (_) => ChanthaProvider()),
        ChangeNotifierProvider(create: (_) => CommiteeProvider()),
        ChangeNotifierProvider(create: (_) => CustomMemberProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }
  
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Check if user is null before accessing properties
    final rolesName = userProvider.user?.roleName;
    final isAdministrator = userProvider.user?.isAdministrator;
    final isChitCommitteeMember = userProvider.user?.isChitCommitteeMember;

    // Check if user or token is null
    final isUserNull = userProvider.user == null;
    final isTokenEmpty = userProvider.user?.token.isEmpty ?? true;

    return MaterialApp(
      title: 'NammaooruApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: secondaryColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      home: isUserNull || isTokenEmpty
          ? const LoginScreen()
          : (rolesName == "superadmin" && isAdministrator == true) ||
                  (rolesName == "admin" && isAdministrator == true) ||
                  (rolesName == "member" && isChitCommitteeMember == true)
              ? dashboardPage()
              : const LoginScreen(),
    );
  }
}
