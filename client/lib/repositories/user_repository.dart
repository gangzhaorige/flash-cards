import 'package:client/models/user_info.dart';
import 'package:dio/dio.dart';

import '../services/dio_request.dart';

class UserRepository {
  Future<List<UserInfo>> fetchUsers() async {
    try {
      Response<dynamic> response = await DioApi.postRequest(
        path: '/users',
      );
      Map<String, dynamic> data = response.data;
      List<UserInfo> result = [];
      if(response.statusCode == 200) {
       
      }
      return result;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}