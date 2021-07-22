import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/customized_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 100,
                ),
              ),
            ),
            Text(
              'WinkedIn',
              style: GoogleFonts.limelight(
                fontSize: 40.0,
                color: Color(0xFFD9B372),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomizedButton(
                  buttonText: 'Login',
                  buttonSize: 60.0,
                  buttonRadius: 18.0,
                  onClick: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                ),
                CustomizedButton(
                  buttonText: 'Register',
                  buttonRadius: 18.0,
                  onClick: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
