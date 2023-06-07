import 'package:client/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../locator.dart';
import '../services/authentication_service.dart';
import '../services/dio_request.dart';
import '../services/shared_preferences_service.dart';

class ProtectedModel extends ChangeNotifier {
  
  final UserRepository _userRepository;

  ProtectedModel(this._userRepository);
  
  Future<void> logout() async {
    var response = await DioApi.postRequest(
      path: '/auth/signout',
    );
    if(response.statusCode == 200) {
      locator<SharedPreferencesService>().removeUser();
      locator<AuthenticaionService>().setUser(null);
      await Get.offAllNamed('/login');
    }
  }
}