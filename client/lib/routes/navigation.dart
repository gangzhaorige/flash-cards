import 'package:client/views/home_view.dart';
import 'package:client/routes/middleware/protected_route.dart';
import 'package:client/views/login_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/register_view.dart';

abstract class Routes {
  static const home = '/home';
  static const protected = '/protected';
  static const login = '/login';
  static const register = '/register';
}

final appPages = [
  GetPage(
    name: Routes.home,
    page: () => HomeView(),
  ),
  GetPage(
    name: Routes.protected,
    page: () => const ProtectedView(),
    middlewares: [ProtectedGuard()]
  ),
  GetPage(
    name: Routes.login,
    page: () => LoginView(),
  ),
  GetPage(
    name: Routes.register,
    page: () => RegisterView(),
  )
];