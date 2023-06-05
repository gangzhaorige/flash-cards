import 'package:client/views/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginDesktop extends StatelessWidget {
  const LoginDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 4,
          child: LoginForm(),
        ),
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}