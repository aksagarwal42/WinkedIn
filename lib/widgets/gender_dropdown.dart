import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/provider/gender.dart';

class GenderDropDown extends StatelessWidget {
  const GenderDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _genders = [
      "Male",
      "Female",
      "Prefer Not to say",
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return Consumer<GenderProvider>(
            builder: (context, provider, _) => InputDecorator(
              decoration: InputDecoration(
                prefixIcon: Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.person),
              ),
                labelText: 'Select your gender',
                labelStyle: GoogleFonts.mateSc(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                // errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                // hintText: 'Select your gender',
                // hintStyle: GoogleFonts.mateSc(
                //   fontSize: 10.0,
                //   fontWeight: FontWeight.bold,
                //   color: Colors.white,
                // ),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(5.0),
                // ),
              ),
              child: DropdownButtonHideUnderline(

                child: DropdownButton<String>(
                  value: provider.gender,
                  isDense: true,
                  onChanged: (newValue) => provider.onChangedGender(newValue),
                  items: _genders.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
