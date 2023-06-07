import 'package:client/models/user_info.dart';
import 'package:client/repositories/user_repository.dart';
import 'package:client/view_models/loading_view_model.dart';
import 'package:get/get.dart';

import '../locator.dart';
import '../services/authentication_service.dart';
import '../services/dio_request.dart';
import '../services/shared_preferences_service.dart';

class ProtectedViewModel extends LoadingViewModel {
  
  final UserRepository _userRepository;

  ProtectedViewModel(this._userRepository);

  List<UserInfo> list = [];

  Future<void> fetchUsers() async {
    try {
      isLoading = true;
      list = await _userRepository.fetchUsers();
    } on Exception catch (e) {
      print(e.toString());
      rethrow;
    }
    isLoading = false;
    notifyListeners();
  }
  
  Future<void> logout() async {
    var response = await DioApi.postRequest(
      path: '/auth/signout',
    );
    if(response.statusCode == 200) {
      locator<SharedPreferencesService>().removeUser();
      locator<AuthenticaionService>().setUser(null);
      await Get.offAllNamed('/login');
    }
  }
}