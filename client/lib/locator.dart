import 'package:client/repositories/topic_repository.dart';
import 'package:client/services/authentication_service.dart';
import 'package:client/services/shared_preferences_service.dart';
import 'package:get_it/get_it.dart';

import 'repositories/user_repository.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton(await SharedPreferencesService.getInstance());
  locator.registerLazySingleton(() => AuthenticaionService.getInstance());
  locator.registerFactory(() => UserRepository());
  locator.registerFactory(() => TopicRepository());
}