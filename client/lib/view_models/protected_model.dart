import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../locator.dart';
import '../services/authentication_service.dart';
import '../services/dio_request.dart';
import '../services/shared_preferences_service.dart';

class ProtectedModel extends ChangeNotifier {
  
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