import 'package:client/components/myscaffold.dart';
import 'package:client/views/login/login_view.dart';
import 'package:client/views/protected_view.dart';
import 'package:client/views/topic_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked_services/stacked_services.dart';

import '../routes/navigation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SettingsNavigation {
  SettingsNavigation._();

  static const id = 0;
}

class SettingsWrapper extends StatelessWidget {
  const SettingsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(SettingsNavigation.id),
      // initialRoute: Routes.protected,
      onGenerateRoute: (settings) {
        GetPageRoute page;
        switch(settings.name) {
          case Routes.protected:
            page = GetPageRoute(
              routeName: Routes.protected,
              page: () => ProtectedView(),
            );
            break;
          case Routes.topic: 
            page = GetPageRoute(
              routeName: Routes.topic,
              page: () => TopicView(),
            );
            break;
          default: 
            page = GetPageRoute(
              routeName: Routes.home,
              page: () => HomeView(),
            );
            break;
        }
        return page;
      },
    );
  }
}
