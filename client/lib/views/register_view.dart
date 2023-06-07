import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/signup_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Text('Sign Up!'),
            Selector<RegisterModel, Function>(
              selector: (_, registerProvider) => registerProvider.updateEmail,
              builder: (_, updateEmail, __) {
                return TextField(
                  controller: _emailController,
                  onChanged:(value) {
                    updateEmail(value);
                  },
                );
              }
            ),
            Selector<RegisterModel, Function>(
              selector: (_, registerProvider) => registerProvider.updateUsername,
              builder: (_, updateUsername, __) {
                return TextField(
                  controller: _usernameController,
                  onChanged: (value) {
                    updateUsername(value);
                  },
                );
              }
            ),
            Selector<RegisterModel, Function>(
              selector: (_, registerProvider) => registerProvider.updatePassword,
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
                await context.read<RegisterModel>().signup();
              },
              color: Colors.blue,
              child: const Text('REGISTER ACCOUNT'),
            ),
          ],
        ),
      ),
    );
  }
}