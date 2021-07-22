import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tinder_clone/models/explorer.dart';

class ExploreProfileProvider extends ChangeNotifier {
  Future<List<Explorer>> getExplorerProfile(String email) async {
    final res = await http.get(
      Uri.parse('https://winkedinapi.herokuapp.com/explore/$email'),
    );
    if (res.statusCode == 200) {
      var response = json.decode(res.body);
      return (response as List).map((val)=>Explorer.fromJson(val)).toList();
    } else {
      throw Exception('Cannot fetch details');
    }
  }
}
