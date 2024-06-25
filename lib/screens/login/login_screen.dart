import 'package:flutter/material.dart';
import '/services/auth_services.dart';
import '/../widgets/header_widget.dart';
import '/../common/theme_helper.dart';
// import 'forgot_password_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void loginUser() {
    authService.signInUser(
      context: context,
      username: usernameController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 240;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container( 
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    Text(
                      'Welcome to Namma Ooru App!',
                      style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: TextFormField(
                                controller: usernameController,
                                decoration: ThemeHelper().textInputDecoration("User Name", "Enter your user name", Icon(Icons.person, color: Colors.grey)),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "User Name can't be empty";
                                  }
                                  return null;
                                },
                              ),
                              //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration("Password", "Enter your Password", Icon(Icons.password, color: Colors.grey)),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Password can't be empty";
                                  }
                                  return null;
                                },
                              ),
                              //decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 15.0),
                            // Container(
                            //   margin: EdgeInsets.fromLTRB(10,0,10,20),
                            //   alignment: Alignment.topRight,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                            //     },
                            //     child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Login'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: () {
                                  if(_formKey.currentState!.validate()) {
                                    loginUser();
                                  }
                                },
                                //onPressed: loginUser,
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
