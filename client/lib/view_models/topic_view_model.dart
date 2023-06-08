import 'package:client/repositories/topic_repository.dart';
import 'package:client/view_models/loading_view_model.dart';

import '../models/topic.dart';

class TopicViewModel extends LoadingViewModel {
  final TopicRepository _topicRepository;

  TopicViewModel(this._topicRepository);

  List<Topic> list = [];

  Future<void> fetchTopicsForUser(int userId) async {
    try {
      isLoading = true;
      // simulating delay from server
      Future.delayed(const Duration(seconds: 3)).then((value) async {
        await _topicRepository.fetchTopicsForUser(userId).then((value) {
          list = value;
          isLoading = false;
        });
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  } 

  Future<void> addTopicForUser(int userId, String subject, bool isPublic) async {
    try {
      await _topicRepository.createTopicForUser(userId, subject, isPublic ).then((value) {
        list.add(value!);
      }).then((value) => notifyListeners());
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}