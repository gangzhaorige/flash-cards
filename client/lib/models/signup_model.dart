import 'dart:convert';

import 'package:client/routes/navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dio_request.dart';

class RegisterModel extends ChangeNotifier {

  String _username = '';

  String _password = '';

  String _email = '';

  String get username => _username;

  String get password => _password;

  String get email => _email;

  void updateUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    _password = newPassword;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  Future<void> signup() async {
    var response = await DioApi.postRequest(
      path: '/auth/signup',
      data: jsonEncode({'email' : _email,'username' : _username, 'password' : _password}),
    );
    if(response.statusCode == 201) {
      Get.to(Routes.login);
    }
  }
}