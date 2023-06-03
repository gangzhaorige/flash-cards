
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/login_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Text('LOGIN'),
            Selector<LoginModel, Function>(
              selector: (_, loginProvider) => loginProvider.updateUsernameText,
              builder: (_, updateUsername, __) {
                return TextField(
                  controller: _usernameController,
                  onChanged: (value) {
                    updateUsername(value);
                  },
                );
              }
            ),
            Selector<LoginModel, Function>(
              selector: (_, loginProvider) => loginProvider.updatePasswordText,
              builder: (_, updatePassword, __) {
                return TextField(
                  controller: _passwordController,
                  onChanged:(value) {
                    updatePassword(value);
                  },
                );
              }
            ),
            MaterialButton(
              onPressed:() async {
                await context.read<LoginModel>().login();
              },
              color: Colors.blue,
              child: const Text('LOGIN'),
            ),
          ],
        ),
      ),
    );
  }
}