import 'package:get/get.dart';

import 'user.dart';

class AuthService extends GetxService {
  AuthService({this.user});

  Future<AuthService> init() async => this;

  User? user;

  Future<void> setUser(User? user) async {
    this.user = user;
  }
}