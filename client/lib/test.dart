import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';

class TestWidget extends StatelessWidget {

  TestWidget({super.key});
  final BrowserClient client = BrowserClient()..withCredentials = true;

  Future<void> login() async {
    var headers = {
      'Content-Type':'application/json',
    };
    var body = jsonEncode({'username' : 'tony', 'password' : 'tony'});
    var response = await client.post(
      Uri.parse('http://localhost:8080/api/auth/signin'),
      headers: headers,
      body: body);
    print(response.body);
  }

  Future<void> signup() async {
    var headers = {
      'Content-Type':'application/json',
    };
    var body = jsonEncode({'username' : 'tony2', 'password' : 'tony', 'email' : 'tony2@tony.com'});
    var response = await client.post(
      Uri.parse('http://localhost:8080/api/auth/signup'),
      headers: headers,
      body: body);
    print(response.body);
  }

  Future<void> logout() async {
    var headers = {
      'Content-Type':'application/json',
    };
    var response = await client.post(
      Uri.parse('http://localhost:8080/api/auth/signout'),
      headers: headers
    );
    print(response.body);
  }

  Future<void> fetchUser() async {
    var response = await client.get(
      Uri.parse('http://localhost:8080/api/test/user'),
    );
    print(response.body);
  }

  Future<void> fetchAll() async {
    var response = await client.get(
      Uri.parse('http://localhost:8080/api/test/all'),
    );
    print(response.body);
  }

  Future<void> fetchAllUser() async {
    var response = await client.get(
      Uri.parse('http://localhost:8080/api/users'),
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: fetchUser,
              color: Colors.red,
              child: const Text('Fetch User ROLE'),
            ),
            MaterialButton(
              onPressed: fetchAll,
              color: Colors.red,
              child: const Text('Fetch All'),
            ),
            MaterialButton(
              onPressed: fetchAllUser,
              color: Colors.red,
              child: const Text('Fetch All Users in db'),
            ),
            MaterialButton(
              onPressed: login,
              color: Colors.blue,
              child: const Text('Login'),
            ),
            MaterialButton(
              onPressed: signup,
              color: Colors.blue,
              child: const Text('Signup'),
            ),
            MaterialButton(
              onPressed: logout,
              color: Colors.blue,
              child: const Text('Logout'),
            ),
          ]
        ),
      ),
    );
  }
}