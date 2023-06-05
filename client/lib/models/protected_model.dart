import 'package:client/services/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../services/authentication/auth.dart';
import '../services/dio_request.dart';

class ProtectedModel extends ChangeNotifier {
  
  Future<void> logout() async {
    var response = await DioApi.postRequest(
      path: '/auth/signout',
    );
    if(response.statusCode == 200) {
      LocalStorageService.removeUser('user');
      final authService = Get.find<AuthService>();
      authService.setUser(null);
      await Get.offAllNamed('/login');
    }
  }
}