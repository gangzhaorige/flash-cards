import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../dio_request.dart';
import '../locator.dart';
import '../models/user.dart';
import '../services/authentication_service.dart';
import '../services/shared_preferences_service.dart';

class AuthViewModel extends ChangeNotifier {

  late bool _isLoggedIn;

  AuthViewModel(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  void setIsLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;

  Future<void> logout(Function setIsLoggedIn) async {
    var response = await DioApi.postRequest(
      path: '/auth/signout',
    );
    if(response.statusCode == 200) {
      setIsLoggedIn(false);
      locator<SharedPreferencesService>().removeUser();
      locator<AuthenticaionService>().setUser(null);
      await Get.offAllNamed('/login');
    }
  }
}