import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/data/passions.dart';
import 'package:tinder_clone/provider/auth.dart';
import 'package:tinder_clone/provider/gender.dart';
import 'package:tinder_clone/provider/image_picker.dart';
import 'package:tinder_clone/screens/userDisplayScreens/user_profile_screen.dart';
import 'package:tinder_clone/widgets/customized_button.dart';
import 'package:tinder_clone/widgets/gender_dropdown.dart';
import 'package:tinder_clone/widgets/forms.dart';
import 'package:tinder_clone/widgets/preference_dropdown.dart';

class ProfileDetailScreen extends StatelessWidget {
  final String name;
  final String email;
  final String dob;
  ProfileDetailScreen({required this.name, required this.email, required this.dob});

  final _items = passions
      .map((passion) => MultiSelectItem(passion, passion['passion']))
      .toList();
  @override
  Widget build(BuildContext context) {
    final List passion = [];
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _bioController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();
    final _name = name.split(' ')[0];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<ImagePickerProvider>(
          create: (_) => ImagePickerProvider(),
        ),
        ChangeNotifierProvider<GenderProvider>(
          create: (_) => GenderProvider(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
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
                        'Welcome,\n$_name',
                        style: GoogleFonts.limelight(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        'Please tell us about yourself',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Consumer<ImagePickerProvider>(
                      builder: (context, provider, _) => Container(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Wrap(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Camera'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        provider.getImage(ImageSource.camera);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.photo),
                                      title: Text('Gallery'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        provider.getImage(ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: provider.image == null
                                  ? AssetImage(
                                      'assets/icons/profile_picture_icon_2.png')
                                  : Image.file(provider.image!).image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GenderDropDown(),
                    SizedBox(
                      height: 20,
                    ),
                    Forms(
                      controller: _cityController,
                      validation: (val) {
                        if (val == null || val.isEmpty) {
                          return 'City cannot be empty';
                        }
                      },
                      labelText: 'Where do you live?',
                      hintText: 'Mumbai',
                      iconData: Icons.location_on_outlined,
                      errorText: null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Forms(
                      controller: _bioController,
                      validation: (val) {},
                      labelText: 'Tell us about yourself',
                      hintText: '',
                      iconData: Icons.add_box_outlined,
                      maxLines: null,
                      errorText: null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PreferenceDropDown(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      child: MultiSelectBottomSheetField(
                        initialChildSize: 0.4,
                        listType: MultiSelectListType.CHIP,
                        searchable: true,
                        buttonIcon: Icon(null),
                        buttonText: Text(
                          "Tell us about the things that you enjoy !",
                          style: GoogleFonts.mateSc(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        title: Text("Passions"),
                        items: _items,
                        onConfirm: (values) {
                          passion.add(values);
                        },
                        confirmText: Text('OK'),
                        cancelText: Text('Cancel'),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Consumer<AuthProvider>(builder: (_context, auth, _) {
                      return Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: auth.loading == false
                            ? Consumer<ImagePickerProvider>(
                                builder: (context, provider, _) =>
                                    CustomizedButton(
                                  buttonText: 'Get Started',
                                  buttonRadius: 30.0,
                                  onClick: () {
                                    if (_formKey.currentState!.validate()) {
                                      auth.loadingIndicator();
                                      _formKey.currentState!.save();
                                      List<String> _passion = [];
                                      final String _passions;
                                      if (passion.length != 0) {
                                        for (var item in passion[0]) {
                                          _passion.add(item['passion']);
                                        }
                                        _passions = _passion.join(',');
                                      } else {
                                        _passions = '';
                                      }
                                      Map _data = {
                                        'name': name,
                                        'dob' : dob,
                                        'email': email,
                                        'city': _cityController.text,
                                        'bio': _bioController.text,
                                        'passion': _passions,
                                        'gender': Provider.of<GenderProvider>(
                                                context,
                                                listen: false)
                                            .gender,
                                        'preference': Provider.of<GenderProvider>(
                                                context,
                                                listen: false)
                                            .preference,
                                        'image': provider.imageData
                                      };
                                      print('Validated');
                                      String body = json.encode(_data);
                                      auth.profileUser(body).then((val) {
                                        auth.loadingIndicator();
                                        if (val == 404) {
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
                                        } else {
                                          Navigator.of(_context)
                                              .pushReplacement(
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  UserProfileScreen(
                                                email: email,
                                              ),
                                            ),
                                          );
                                        }
                                      });
                                    }
                                  },
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.all(10.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
