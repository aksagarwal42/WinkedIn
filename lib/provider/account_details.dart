import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tinder_clone/models/user_profile.dart';

class AccountDetailsProvider extends ChangeNotifier {
  Future<UserProfile> getUserProfile(String email) async {
    final res = await http.get(
      Uri.parse('https://winkedinapi.herokuapp.com/user/$email'),
    );

    if (res.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Cannot fetch details');
    }
  }
}
