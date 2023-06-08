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
                alignment: Alignment.center,
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                child: Text('${topic.subject}')
              );
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TopicViewModel>().addTopicForUser(1, '2', false);
        },
        child: const Icon(
          Icons.plus_one,
        ),
      ),
    );
  }
}