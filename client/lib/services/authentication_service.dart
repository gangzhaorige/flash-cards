import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/user.dart';
import 'dio_request.dart';

class AuthenticaionService {

  static AuthenticaionService getInstance() => AuthenticaionService._();

  AuthenticaionService._();

  User? user;
  
  Future<void> setUser(User? user) async {
    this.user = user;
  }

  Future<Response> login(String username, String password) async {
    try {
      var response = await DioApi.postRequest(
        path: '/auth/signin',
        data: jsonEncode({'username' : username, 'password' : password}),
      );
      return response;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<void> logout() async {
    try {
      await DioApi.postRequest(
        path: '/auth/signout',
      );
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}

