import 'dart:convert';

import 'package:client/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../locator.dart';
import '../services/authentication_service.dart';
import '../dio_request.dart';

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

  Future<void> login() async {
    var response = await DioApi.postRequest(
      path: '/auth/signin',
      data: jsonEncode({'username' : _username, 'password' : _password}),
    );
    Map<dynamic, dynamic> data = response.data;
    User user = User(data['username'] as String, data['email'] as String, data['id'] as int);
    await locator<SharedPreferencesService>().setUser('user', json.encode(user.toJson()));
    await locator<AuthenticaionService>().setUser(user).then((value) {
      Get.toNamed('/protected');
    });
  }

  Future<void> goToSignup() async {
    await Get.toNamed('/register');
  }
}