import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {

  String _username = '';

  String _password = '';

  String get username => _username;

  String get password => _password;

  void updateUsernameText(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }

  void updatePasswordText(String newPassword) {
    _password = newPassword;
    notifyListeners();
  }
}