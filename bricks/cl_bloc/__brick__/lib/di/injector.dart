import 'package:core/core_exports.dart';

class Injector {
  static GetIt instance = GetIt.instance;

  Injector._();

  static void init() {
    DioProvider.setup();
    NetworkService.setup();
    instance.registerLazySingleton<AppPreference>(() => AppPreferenceImp());
    instance.registerLazySingleton<NetworkProvider>(
      () => NetworkProviderImp(
        internetConnectionChecker: instance.get<InternetConnectionChecker>(),
      ),
    );
    instance.registerLazySingleton<BaseApiProvider>(
      () => APIProvider(
        dio: instance.get<Dio>(),
        networkProvider: instance.get<NetworkProvider>(),
      ),
    );
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
