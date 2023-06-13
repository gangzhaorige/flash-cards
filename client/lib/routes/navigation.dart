import 'package:client/views/home_view.dart';
import 'package:client/routes/middleware/protected_route.dart';
import 'package:client/views/login/login_view.dart';
import 'package:client/views/topic_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/protected_view.dart';
import '../views/register_view.dart';

abstract class Routes {
  static const home = '/';
  static const protected = '/protected';
  static const login = '/login';
  static const register = '/register';
  static const topic = '/topic';
}

final rootPages = [
  GetPage(
    name: Routes.home,
    page: () => const HomeView(),
    middlewares: [ProtectedGuard()],
  ),
  GetPage(
    name: Routes.login,
    page: () => const LoginView(),
    middlewares: []
  ),
  GetPage(
    name: Routes.register,
    page: () => const RegisterView(),
    middlewares: []
  ),
  GetPage(
    name: Routes.protected,
    page: () => const ProtectedView(),
  ),
  GetPage(
    name: Routes.topic,
    page: () => const TopicView(),
  ),
];