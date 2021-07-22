import 'package:flutter/material.dart';

class CustomizedButton extends StatelessWidget {
  final String buttonText;
  final double buttonSize; // Padding for the buttons
  final Function onClick;
  final double buttonRadius;
  CustomizedButton(
      {required this.buttonText,
      required this.onClick,
      this.buttonSize = 50.0,
      this.buttonRadius = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            Color(0xFFFFFFFF),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: buttonSize),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        onPressed: () => onClick(),
      ),
    );
  }
}
