import 'package:client/models/topic.dart';
import 'package:dio/dio.dart';


class TopicRepository {
  Future<List<Topic>> fetchTopicsForUser(int userId) async {
    try {
      // Response<dynamic> response = await DioApi.getRequest(
      //   path: '/users/$userId/topics',
      // );
      // Map<String, dynamic> data = response.data;
      // List<UserInfo> result = [];
      // fake backend
      List<Topic> topics = [
        Topic(1, 1, 'Computer Science', false),
        Topic(2, 1, 'Math', false),
        Topic(3, 1, 'Physics', false),
        Topic(1, 1, 'Computer Science', false),
        Topic(2, 1, 'Math', false),
        Topic(3, 1, 'Physics', false),
        Topic(1, 1, 'Computer Science', false),
        Topic(2, 1, 'Math', false),
        Topic(3, 1, 'Physics', false),
      ];
      // if(response.statusCode == 200) {
      //   for(Map<String, dynamic> user in data['users']) {
      //     result.add(UserInfo.fromJson(user));
      //   }
      // }
      return topics;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Topic?> createTopicForUser(int userId, String subject, bool isPublic) async {
    try {
      // Response<dynamic> response = await DioApi.postRequest(
      //   path: '/users/$userId/topics',
      //   data: jsonEncode({'subject' : subject, 'isPublic' : isPublic}),
      // );
      // if(response.statusCode == 200) {
      //   return Topic.fromJson(response.data['topic']);
      // }
      return Topic(userId, userId, subject, isPublic);
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}