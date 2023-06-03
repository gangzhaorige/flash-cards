import 'package:client/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'models/login_model.dart';
import 'routes/navigation.dart';

void main() async {
  await Get.putAsync(() => AuthService().init());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginModel()),
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
        useMaterial3: true,
      ),
      defaultTransition: Transition.noTransition, //this would be the solution
      transitionDuration: const Duration(seconds: 0),
      initialRoute: Routes.home,
      getPages: appPages,
    );
  }
}