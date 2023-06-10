import 'dart:convert';
import 'package:client/repositories/topic_repository.dart';
import 'package:client/repositories/user_repository.dart';
import 'package:client/services/shared_preferences_service.dart';
import 'package:client/view_models/auth_view_model.dart';
import 'package:client/view_models/topic_view_model.dart';
import 'package:client/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart' hide Transition;

import 'custom_dialog_ui.dart';
import 'locator.dart';
import 'models/user.dart';
import 'services/authentication_service.dart';
import 'view_models/login_view_model.dart';
import 'view_models/protected_view_model.dart';
import 'view_models/signup_view_model.dart';
import 'routes/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  String? userInfo = locator<SharedPreferencesService>().getUser('user');
  bool isLoggedIn = userInfo != null;
  if(userInfo != null) {
    final authService = locator<AuthenticaionService>();
    await authService.setUser(User.fromJson(jsonDecode(userInfo)));
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => ProtectedViewModel(locator<UserRepository>())),
        ChangeNotifierProvider(create: (_) => TopicViewModel(locator<TopicRepository>())),
        ChangeNotifierProvider(create: (_) => AuthViewModel(isLoggedIn)),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: false,
      ),
      navigatorKey: StackedService.navigatorKey,
      getPages: rootPages,
      defaultTransition: Transition.noTransition, //this would be the solution
      transitionDuration: const Duration(seconds: 0),
      initialRoute: '/',
      builder: (context, child) {
        return BaseWidget(child: child);
      },
    );
  }
}

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, required this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (_, authModel, __) {
        return Scaffold(
          appBar: authModel.isLoggedIn ? AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Text('to Protected Page'),
                  onTap: () {
                    Get.toNamed('/protected');
                  },
                ),
                GestureDetector(
                  child: Text('to Topic Page'),
                  onTap: () {
                    Get.toNamed('/topic');
                  },
                ),
                GestureDetector(
                  child: Text('LOGOUT'),
                  onTap: () {
                    authModel.logout(authModel.setIsLoggedIn);
                  },
                ),
              ],
            ),
          ) : null,
          body: child,
        );
      
      }
    );
  }
}