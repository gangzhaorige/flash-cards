import 'package:client/view_models/protected_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProtectedView extends StatefulWidget {
  const ProtectedView({super.key});

  @override
  State<ProtectedView> createState() => _ProtectedViewState();
}

class _ProtectedViewState extends State<ProtectedView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProtectedViewModel>(context, listen: false).fetchUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Protected View')),
      body: MaterialButton(
        onPressed: () {
          Provider.of<ProtectedViewModel>(context, listen: false).logout();
        }
      ),
    );
  }
}