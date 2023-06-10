import 'package:client/locator.dart';
import 'package:client/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../models/topic.dart';
import '../view_models/topic_view_model.dart';

class TopicView extends StatefulWidget {
  const TopicView({super.key});

  @override
  State<TopicView> createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      int userId = locator<AuthenticaionService>().user!.id;
      Provider.of<TopicViewModel>(context, listen: false).fetchTopicsForUser(userId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TopicViewModel>(
        builder: (context, viewModel, child) {
          if(viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 6 / 3,
            ),
            itemCount: viewModel.list.length,
            padding: EdgeInsets.all(16),
            itemBuilder:(context, index) {
              Topic topic = viewModel.list[index];
              return Container(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          viewModel.list[index].isPublic ?
                          Icons.public : Icons.private_connectivity,
                          size: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(child: Text('${viewModel.list[index].subject}')),
                    ),
                  ],
                ),
              );
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TopicViewModel>().showCreateTableDialog();
        },
        child: const Icon(
          Icons.plus_one,
        ),
      ),
    );
  }
}