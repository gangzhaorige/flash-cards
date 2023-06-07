import 'package:client/locator.dart';
import 'package:client/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../locator.dart';
import '../navigation.dart';

class ProtectedGuard extends GetMiddleware {
  final _authenticationService = locator<AuthenticaionService>();

  @override
  RouteSettings? redirect(String? route) {
    return _authenticationService.user != null ? null : const RouteSettings(name: Routes.login);
  }
}

class LoggedInGuard extends GetMiddleware {
  final _authenticationService = locator<AuthenticaionService>();

  @override
  RouteSettings? redirect(String? route) {
    return _authenticationService.user == null ? null : const RouteSettings(name: Routes.protected);
  }
}