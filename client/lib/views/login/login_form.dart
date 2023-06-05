import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/login_model.dart';

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
              Selector<LoginModel, Function>(
                selector: (_, loginProvider) => loginProvider.updateUsernameText,
                builder: (_, updateUsername, __) {
                  return TextField(
                    onChanged: (value) => updateUsername(value),
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                      ),
                      labelText: 'Username',
                    ),
                    style: const TextStyle(fontSize: 18),
                  );
                }
              ),
              const SizedBox(
                height: 25,
              ),
              Selector<LoginModel, Function>(
                selector: (_, loginProvider) => loginProvider.updatePasswordText,
                builder: (_, updatePassword, __) {
                  return TextField(
                    onChanged: (value) => updatePassword(value),
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                      ),
                      labelText: 'Username',
                    ),
                    style: const TextStyle(fontSize: 18),
                  );
                }
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: 500,
                child: OutlinedButton(
                  onPressed: () async {
                    await context.read<LoginModel>().login();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
                  ),
                  child : const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),
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
                      await context.read<LoginModel>().goToSignup();
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