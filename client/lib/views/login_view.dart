import 'dart:convert';

import 'package:client/services/dio_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/login_model.dart';
import '../services/auth.dart';
import '../services/user.dart';

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
                LoginModel provider = context.read<LoginModel>();
                var response = await DioApi.postRequest(
                  path: '/auth/signin',
                  data: jsonEncode({'username' : provider.username, 'password' : provider.password}),
                );
                print(response.data);
                Map<dynamic, dynamic> data = response.data;
                User user = User(username: data['username'] as String, email: data['email'] as String, id: data['id'] as int);
                final authService = Get.find<AuthService>();
                await authService.setUser(user).then((value) {
                  Get.toNamed('/protected');
                });
              },
              child: Text('LOGIN'),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}