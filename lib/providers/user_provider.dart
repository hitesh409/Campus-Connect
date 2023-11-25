import 'package:campus_connect_app/models/user.dart';
import 'package:campus_connect_app/resources/auth_methods.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User get getUser => _user!; //getter method to access private member

  Future<void> refreshUser() async {
    User user = await AuthMethods().getUserDetails();
    _user = user;
    notifyListeners();
  }
}
