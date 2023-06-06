
import 'package:client/services/authentication_service.dart';
import 'package:client/services/shared_preferences_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../dio_request.dart';
import '../locator.dart';

class UserInfo {
  final int id;
  final String username;
  final String email;
  final List<String> roles;

  UserInfo(this.id, this.username, this.email, this.roles);

  UserInfo.fromJson(Map<String, dynamic> json)
    : username = json['username'],
      email = json['email'],
      id = json['id'] as int,
      roles = json['roles'];
  

  Map<String, dynamic> toJson() {
    return {
      'username' : username,
      'email' : email,
      'id' : id,
      'roles' : roles,
    };
  }
  @override
  String toString() {
    return 'id: $id, username: $username, email: $email, roles: ${roles.toString()}';
  }
}


class ProtectedModel extends ChangeNotifier {
  
  Future<void> logout() async {
    var response = await DioApi.postRequest(
      path: '/auth/signout',
    );
    if(response.statusCode == 200) {
      locator<SharedPreferencesService>().removeUser('user');
      locator<AuthenticaionService>().setUser(null);
      await Get.offAllNamed('/login');
    }
  }
}