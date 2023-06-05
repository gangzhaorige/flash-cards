import 'package:client/models/protected_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('THIS IS HOME VIEW'),
    );
  }
}
class ProtectedView extends StatelessWidget {
  const ProtectedView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Row(
        children: [
          const Text('Protected View'),
          MaterialButton(
            onPressed: () async {
              await context.read<ProtectedModel>().logout();
            },
            child: const Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}