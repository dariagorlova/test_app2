import 'package:get_it/get_it.dart';
import 'package:test_app2/core/network_info.dart';
import 'package:test_app2/features/main_screen/data/api_service.dart';
import 'package:test_app2/features/main_screen/data/repository_impl.dart';
import 'package:test_app2/features/main_screen/domain/repository.dart';
import 'package:test_app2/features/main_screen/presentation/bloc/sending_bloc.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  sl.registerLazySingleton(() => SendingBloc(repository: sl()));
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<NetworkInfo>(() => const NetworkInfoImpl());
  sl.registerLazySingleton<ApiService>(() => const ApiServiceImpl());
}
