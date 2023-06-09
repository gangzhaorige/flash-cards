import 'dart:convert';

import 'package:client/services/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../locator.dart';
import '../models/user.dart';
import '../services/authentication_service.dart';

class LoginViewModel extends ChangeNotifier {

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

  Future<bool> login(Function setIsLoggedIn) async {
    Response response = await locator<AuthenticaionService>().login(_username, _password);
    var data = response.data;
    if(response.statusCode == 200) {
      setIsLoggedIn(true);
      User user = User(data['username'] as String, data['email'] as String, data['id'] as int);
      await locator<SharedPreferencesService>().setUser(json.encode(user.toJson()));
      await locator<AuthenticaionService>().setUser(user).then((value) {
        Get.toNamed('/protected');
      });
      return true;
    }
    return false;
  }

  Future<void> goToSignup() async {
    await Get.toNamed('/register');
  }
}