import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder_clone/models/user_profile.dart';
import 'package:tinder_clone/provider/account_details.dart';
import '../../widgets/passion_card.dart';

class AccountPage extends StatefulWidget {
  final String email;
  AccountPage({required this.email});
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Future<UserProfile> userProfile;
  void initState() {
    super.initState();
    userProfile = AccountDetailsProvider().getUserProfile(widget.email);
  }

  // String gender = 'Male';
  List<Widget> passionWidget = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> passionWidgetListBuilder(List<dynamic> _passions) {
      passionWidget = [];
      int i = 0;
      for (; i < _passions.length; i++)
        passionWidget.add(PassionCard(passion: _passions[i]));
      return passionWidget;
    }

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<UserProfile>(
          future: userProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Container(
                  child: ListView(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Image(
                          fit: BoxFit.cover,
                          image: snapshot.data!.image == ''
                              ? AssetImage(
                                  'assets/icons/profile_picture_icon_2.png')
                              : Image.memory(base64Decode(snapshot.data!.image))
                                  .image,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              snapshot.data!.name,
                              style: GoogleFonts.robotoSlab(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              snapshot.data!.dob,
                              style: GoogleFonts.robotoSlab(
                                fontWeight: FontWeight.w300,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text('  Lives in ${snapshot.data!.city}', style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Text('  ${snapshot.data!.gender}', style: TextStyle(fontSize: 18),),
                          ],
                        ),
                      ),
                      snapshot.data!.about == ''
                          ? Container()
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Divider(
                                    indent: 5,
                                    endIndent: 5,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    snapshot.data!.about,
                                    // maxLines: 8,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                      // snapshot.data!.about == ''
                      //     ? Container()
                      snapshot.data!.passions[0] == ''
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Divider(
                                    indent: 5,
                                    endIndent: 5,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(13),
                                  child: Text(
                                    'Passions',
                                    style: GoogleFonts.robotoSlab(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Wrap(
                                  children: passionWidgetListBuilder(
                                      snapshot.data!.passions),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('null');
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
