import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/provider/auth.dart';
import 'package:tinder_clone/screens/profile_detail_screen.dart';
import 'package:tinder_clone/widgets/customized_button.dart';
import 'package:tinder_clone/widgets/forms.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();
    final TextEditingController _dobController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Register',
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
                          'Please register to continue.',
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Forms(
                        controller: _nameController,
                        validation: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Name cannot be empty';
                          }
                        },
                        labelText: 'Full Name',
                        hintText: 'John Doe',
                        iconData: Icons.person,
                        errorText: null,
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, auth, _) => Forms(
                          controller: _emailController,
                          validation: (val) {
                            bool _emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_emailController.text);
                            if (val == null || val.isEmpty) {
                              return 'Email cannot be empty';
                            } else if (!_emailValid) {
                              return 'Not a valid email id';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Email',
                          hintText: 'abc@xyz.com',
                          iconData: Icons.email,
                          errorText: auth.emailErrorText,
                        ),
                      ),
                      Forms(
                        controller: _dobController,
                        validation: (val) {
                          if (val == null || val.isEmpty) {
                            return 'DOB cannot be empty';
                          }
                        },
                        readOnly: true,
                        labelText: 'DOB',
                        hintText: 'dd/mm/yyyy',
                        iconData: Icons.date_range_rounded,
                        errorText: null,
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now()
                                .subtract(Duration(days: 18 * 365)),
                          );
                          _dobController.text =
                              DateFormat('dd/MM/yyyy').format(date!);
                        },
                      ),
                      Forms(
                        controller: _passwordController,
                        validation: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          if (val.length < 8) {
                            return 'Password cannot be less than 8 characters long';
                          }
                        },
                        labelText: 'Password',
                        hintText: '****',
                        obscureText: true,
                        iconData: Icons.lock,
                        errorText: null,
                      ),
                      Forms(
                        controller: _confirmPasswordController,
                        validation: (val) {
                          if (val == null ||
                              val.isEmpty ||
                              _confirmPasswordController.text !=
                                  _passwordController.text) {
                            return 'Passwords do not match';
                          }
                        },
                        labelText: 'Confirm Password',
                        hintText: '****',
                        obscureText: true,
                        iconData: Icons.lock,
                        errorText: null,
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, auth, _) => Container(
                          margin: EdgeInsets.only(left: 15.0),
                          child: auth.loading == false
                              ? CustomizedButton(
                                  buttonText: 'Register',
                                  buttonRadius: 30.0,
                                  onClick: () {
                                    auth.changeEmail(null);
                                    if (_formKey.currentState!.validate()) {
                                      auth.loadingIndicator();
                                      _formKey.currentState!.save();
                                      Map _data = {
                                        'email': _emailController.text,
                                        'password': _passwordController.text,
                                      };
                                      String body = json.encode(_data);
                                      auth.registerUser(body).then((val) {
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
                                        } else if (val == null) {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  ProfileDetailScreen(
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                dob: _dobController.text,
                                              ),
                                            ),
                                          );
                                        } else {
                                          auth.changeEmail(val.toString());
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
        ),
      ),
    );
  }
}
