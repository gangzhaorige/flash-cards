import 'package:client/models/protected_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dio_request.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('THIS IS HOME VIEW'),
    );
  }
}
class ProtectedView extends StatefulWidget {
  const ProtectedView({super.key});

  @override
  State<ProtectedView> createState() => _ProtectedViewState();
}

class _ProtectedViewState extends State<ProtectedView> {
   Future<List<UserInfo>> fetchUsers() async {
    var response = await DioApi.getRequest(path: '/users');
    List<UserInfo> result = [];
    if(response.statusCode == 200) {
      List<dynamic> list = response.data['users'];
      for(Map<String, dynamic> item in list) {
        List<String> roles = [];
        for(String role in item['roles']) {
          roles.add(role);
        }
        UserInfo userInfo = UserInfo(item['id'] as int, item['username'], item['email'], roles);
        result.add(userInfo);
      }
    }
    return result;
  }

  late final Future<List<UserInfo>> _users;
  late ScrollController controller;
  @override
  void initState() {
    super.initState();
    _users = fetchUsers();
    controller = ScrollController();
    // final ProtectedModel model = Provider.of<ProtectedModel>(context, listen: false);
    // list = model.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Protected View'),
          MaterialButton(
            onPressed: () async {
              await context.read<ProtectedModel>().logout();
            },
            child: const Text('LOGOUT'),
          ),
          MaterialButton(
            onPressed: () async {
              // await context.read<ProtectedModel>().fetchUsers();
            },
            child: const Text('FETCH USERS'),
          ),
          FutureBuilder(
            future: _users,
            builder:(context, snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                List<UserInfo>? users = snapshot.data;
                return Container(
                  height: 100,
                  color: Colors.blue,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    controller: controller,
                    children: [
                      for(UserInfo user in users!)
                        Text(user.username)
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}