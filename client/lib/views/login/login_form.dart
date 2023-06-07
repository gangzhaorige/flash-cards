import 'package:client/components/button.dart';
import 'package:client/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/login_view_model.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final LoginViewModel loginModel = Provider.of<LoginViewModel>(context, listen: false);
    _usernameController = TextEditingController(text: loginModel.username);
    _passwordController = TextEditingController(text: loginModel.password);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 325,
            maxWidth: 500,
            minHeight: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                children: [
                  Icon(
                    Icons.bolt_sharp,
                    size: 80,
                    color: Colors.blue,
                  ),
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Please enter your credentials.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Selector<LoginViewModel, Function>(
                selector: (_, loginProvider) => loginProvider.updateUsernameText,
                builder: (_, updateUsername, __) {
                  return FlashTextField(
                    onChanged: updateUsername,
                    controller: _usernameController,
                    text: 'Username',
                  );
                }
              ),
              const SizedBox(
                height: 25,
              ),
              Selector<LoginViewModel, Function>(
                selector: (_, loginProvider) => loginProvider.updatePasswordText,
                builder: (_, updatePassword, __) {
                  return FlashTextField(
                    onChanged: updatePassword,
                    controller: _passwordController,
                    text: 'Password',
                    obscureText: true,
                  );
                }
              ),
              const SizedBox(
                height: 25,
              ),
              FlashButton(
                onPressed: context.read<LoginViewModel>().login,
                text: 'Login',
              ),
              const SizedBox(
                height: 50,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () async {
                      await context.read<LoginViewModel>().goToSignup();
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}