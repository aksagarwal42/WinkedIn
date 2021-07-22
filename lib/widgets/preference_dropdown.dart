import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/provider/gender.dart';

class PreferenceDropDown extends StatelessWidget {
  const PreferenceDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _preference = [
      "Male",
      "Female",
      "Both",
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
                labelText: 'Select your preference',
                labelStyle: GoogleFonts.mateSc(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: provider.preference,
                  isDense: true,
                  onChanged: (newValue) => provider.onChangedPrefernce(newValue),
                  items: _preference.map((String value) {
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
