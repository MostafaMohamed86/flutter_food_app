import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/app/app_prefs.dart';
import 'package:shopping_app/data/data_source/remote_data_source.dart';
import 'package:shopping_app/data/network/app_api.dart';
import 'package:shopping_app/data/network/dio_factory.dart';
import 'package:shopping_app/data/network/network_info.dart';
import 'package:shopping_app/data/repository/repository_impl.dart';
import 'package:shopping_app/domain/repository/repository.dart';
import 'package:shopping_app/domain/usecase/forgot_password_usecase.dart';
import 'package:shopping_app/domain/usecase/login_usecase.dart';
import 'package:shopping_app/presentation/forgot_password/forgot_password_view/forgot_password_view.dart';
import 'package:shopping_app/presentation/login/login_viewmodel/login_viewmodel.dart';

import '../presentation/forgot_password/forgot_password_viewModel/forgot_password_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  // app service client
  instance
      .registerLazySingleton<AppServicesClient>(() => AppServicesClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServicesClient>()));

  // repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}
