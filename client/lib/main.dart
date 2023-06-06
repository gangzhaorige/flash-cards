import 'dart:convert';

import 'package:client/services/authentication_service.dart';
import 'package:client/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'models/login_model.dart';
import 'models/protected_model.dart';
import 'models/signup_model.dart';
import 'routes/navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  final SharedPreferencesService sharedPreferencesService = locator<SharedPreferencesService>();
  String? userInfo = sharedPreferencesService.getUser('user');
  if(userInfo != null) {
    final authService = locator<AuthenticaionService>();
    await authService.setUser(User.fromJson(jsonDecode(userInfo)));
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginModel()),
        ChangeNotifierProvider(create: (_) => RegisterModel()),
        ChangeNotifierProvider(create: (_) => ProtectedModel()),
      ],
      child: const FlashCards(),
    ),
  );
}

class FlashCards extends StatelessWidget {
  const FlashCards({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FlashCards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      defaultTransition: Transition.noTransition, //this would be the solution
      transitionDuration: const Duration(seconds: 0),
      initialRoute: Routes.login,
      getPages: appPages,
    );
  }
}