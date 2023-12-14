import 'package:campus_connect_app/models/user.dart';
import 'package:campus_connect_app/resources/auth_methods.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user;

  User get user {
    if (_user == null) {
      // Handle the case when _user is null, e.g., throw an exception or return a default user.
      throw Exception(
          "User is null. Make sure to call refreshUser() before accessing the user.");
    }
    return _user!;
  }

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
