
import 'package:client/components/responsive/responsive.dart';
import 'package:client/views/login/login_desktop.dart';
import 'package:client/views/login/login_mobile.dart';
import 'package:flutter/material.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: LoginMobile(),
        table: LoginMobile(),
        desktop: LoginDesktop(),
      ),
    );
  }
}