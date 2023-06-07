import 'package:client/services/authentication_service.dart';
import 'package:client/services/shared_preferences_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton(await SharedPreferencesService.getInstance());
  locator.registerLazySingleton(() => AuthenticaionService.getInstance());
  // locator.registerFactory(() => UserRepository());
}