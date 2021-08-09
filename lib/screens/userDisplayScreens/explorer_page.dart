import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinder_clone/models/explorer.dart';
import 'package:tinder_clone/provider/explorer_profile.dart';

class ExplorerPage extends StatelessWidget {
  final String email;
  ExplorerPage({required this.email});
  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder<List<Explorer>>(
            future: ExploreProfileProvider().getExplorerProfile(email),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var map = snapshot.data!.map(
                  (data) {
                    return Swipable(
                      child: Container(
                        height: availableHeight * 0.9,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Container(
                              height: availableHeight * 0.8,
                              width: MediaQuery.of(context).size.width,
                              child: data.image != ""
                                  ? Image.memory(
                                      base64Decode(data.image),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/img_1.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Container(
                              color: Colors.black,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        '${data.name}  ${data.dob}',
                                        style: GoogleFonts.robotoSlab(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(data.city),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onSwipeRight: (Offset x) {
                        print('Right');
                      },
                      onSwipeLeft: (Offset x) {
                        print('Left');
                      },
                    );
                  },
                ).toList();
                return Stack(
                  children: map,
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text(
                  'null',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
