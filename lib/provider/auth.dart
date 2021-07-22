import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  var emailErrorText;
  var passwordErrorText;
  var loading = false;

  void loadingIndicator() {
    loading = !loading;
    notifyListeners();
  }

  void changeEmail(var error) {
    emailErrorText = error;
    notifyListeners();
  }

  void changePassword(var error) {
    passwordErrorText = error;
    notifyListeners();
  }

  Future loginUser(body) async {
    final res = await http
        .post(Uri.parse('https://winkedinapi.herokuapp.com/login'), body: body);
    if (res.statusCode == 404) {
      return res.statusCode;
    }
    if (res.statusCode == 403) {
      return res.body;
    }

    if (res.statusCode == 200) {
      return res.body;
    }
  }

  Future registerUser(body) async {
    final res = await http
        .post(Uri.parse('https://winkedinapi.herokuapp.com/register'), body: body);
    if (res.statusCode == 404) {
      return res.statusCode;
    }
    if (res.statusCode == 409) {
      return res.body;
    }
  }

  Future profileUser(body) async {
    final res = await http.post(
        Uri.parse('https://winkedinapi.herokuapp.com/profileRegister'),
        body: body);
    if (res.statusCode == 404) {
      return res.statusCode;
    } else {
      return res.body;
    }
  }
}
