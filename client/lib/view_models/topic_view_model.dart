import 'package:client/locator.dart';
import 'package:client/repositories/topic_repository.dart';
import 'package:client/view_models/loading_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

import '../custom_dialog_ui.dart';
import '../models/topic.dart';

class TopicViewModel extends LoadingViewModel {
  final TopicRepository _topicRepository;

  final DialogService _dialogService = locator<DialogService>();

  TopicViewModel(this._topicRepository);

  List<Topic> list = [];

  Future<void> fetchTopicsForUser(int userId) async {
    try {
      isLoading = true;
      // simulating delay from server
      await _topicRepository.fetchTopicsForUser(userId).then((value) {
        list = value;
        isLoading = false;
      });
      notifyListeners();
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
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future showCreateTableDialog() async {
    var response = await _dialogService.showCustomDialog(
      variant: DialogType.basic,
      title: 'Create your topic!',
      description: 'Fill the following descriptions',
      mainButtonTitle: 'Create',
      additionalButtonTitle: 'Cancel',
    );
    if(response!.confirmed) {
      addTopicForUser(1, response.data['topic'], response.data['isPublic']);
    }
  }
}