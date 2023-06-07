import 'package:client/view_models/protected_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;
import '../models/user_info.dart';

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
      appBar: AppBar(title: const Text('Protected View')),
      body: Consumer<ProtectedViewModel>(
        builder: (context, viewModel, child) {
          if(viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: viewModel.list.length,
            itemBuilder:(context, index) {
              UserInfo userInfo = viewModel.list[index];
              return Container(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.face_2),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ID: ${userInfo.id}'),
                              Text('Username: ${userInfo.username}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Email: ${userInfo.email}'),
                              Text('Authorization: ${userInfo.roles.toString()}'),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          );
        },
      ),
    );
  }
}