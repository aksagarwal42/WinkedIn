import 'package:flutter/foundation.dart';

class GenderProvider extends ChangeNotifier {
  String gender = 'Male';
  String preference = 'Both';
  void onChangedGender(value) {
    gender = value;
    notifyListeners();
  }
  
    void onChangedPrefernce(value) {
    preference = value;
    notifyListeners();
  }
}
