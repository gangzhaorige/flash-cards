import 'package:flutter/material.dart';

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
    
    return Container(child: const Text('protected'),);
  }
}