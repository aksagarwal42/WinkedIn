import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forms extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final IconData iconData;
  final Function validation;
  final dynamic errorText;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType keyboardType;
  final dynamic maxLines;
  final Function? onTap;
  Forms(
      {required this.labelText,
      required this.hintText,
      required this.iconData,
      required this.validation,
      this.obscureText = false,
      required this.errorText,
      required this.controller,
      this.onTap,
      this.readOnly = false,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
     });

  @override
  build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: () => onTap!(),
          controller: controller,
          validator: (val) => validation(val),
          obscureText: obscureText,
          style: GoogleFonts.roboto(),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(iconData),
            ),
            labelText: labelText,
            labelStyle: GoogleFonts.mateSc(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.mateSc(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            errorText: errorText,
            errorStyle : TextStyle(color: Colors.pink),
          ),
        ),
      ),
    );
  }
}