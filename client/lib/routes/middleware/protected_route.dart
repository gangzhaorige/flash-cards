import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../locator.dart';
import '../navigation.dart';
import '../../services/authentication_service.dart';

class ProtectedGuard extends GetMiddleware {
  final authService = locator<AuthenticaionService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.user != null ? null : const RouteSettings(name: Routes.login);
  }
}

class LoggedInGuard extends GetMiddleware {
  final authService = locator<AuthenticaionService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.user == null ? null : const RouteSettings(name: Routes.protected);
  }
}