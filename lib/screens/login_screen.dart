import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/provider/auth.dart';
import 'package:tinder_clone/screens/userDisplayScreens/user_profile_screen.dart';
import 'package:tinder_clone/widgets/customized_button.dart';
import 'package:tinder_clone/widgets/forms.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: SafeArea(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Login',
                      style: GoogleFonts.limelight(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: Text(
                      'Please sign in to continue.',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  Consumer<AuthProvider>(
                    builder: (context, auth, _) => Forms(
                      controller: _emailController,
                      validation: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Email cannot be empty';
                        }
                      },
                      labelText: 'Email',
                      hintText: 'abc@xyz.com',
                      iconData: Icons.email,
                      errorText: auth.emailErrorText,
                    ),
                  ),
                  Consumer<AuthProvider>(
                    builder: (context, auth, _) => Forms(
                      controller: _passwordController,
                      validation: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Password cannot be empty';
                        }
                      },
                      labelText: 'Password',
                      hintText: '********',
                      obscureText: true,
                      iconData: Icons.lock,
                      errorText: auth.passwordErrorText,
                    ),
                  ),
                  Consumer<AuthProvider>(
                    builder: (context, auth, _) => Container(
                      margin: EdgeInsets.only(left: 15.0),
                      child: auth.loading == false
                          ? CustomizedButton(
                              buttonText: 'Login',
                              buttonRadius: 30.0,
                              onClick: () {
                                auth.changeEmail(null);
                                auth.changePassword(null);
                                if (_formKey.currentState!.validate()) {
                                  auth.loadingIndicator();
                                  _formKey.currentState!.save();
                                  Map _data = {
                                    'email': _emailController.text,
                                    'password': _passwordController.text,
                                  };
                                  String body = json.encode(_data);
                                  auth.loginUser(body).then((val) {
                                    auth.loadingIndicator();
                                    if (val == 404) {
                                      print('404 successful $val');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors
                                              .redAccent[400]!
                                              .withOpacity(0.5),
                                          content: Text(
                                            'SERVER ERROR',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                      return;
                                    } else if (_emailController.text ==
                                        val.toString()) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              UserProfileScreen(
                                            email: _emailController.text,
                                          ),
                                        ),
                                      );
                                    } else {
                                      val.toString().contains('email')
                                          ? auth.changeEmail(val.toString())
                                          : auth.changePassword(val.toString());
                                    }
                                  });
                                }
                              },
                            )
                          : Container(
                              margin: EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
