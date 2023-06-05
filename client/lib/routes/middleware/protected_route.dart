import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation.dart';
import '../../services/authentication/auth.dart';

class ProtectedGuard extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.user != null ? null : const RouteSettings(name: Routes.login);
  }
}

class LoggedInGuard extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.user == null ? null : const RouteSettings(name: Routes.protected);
  }
}