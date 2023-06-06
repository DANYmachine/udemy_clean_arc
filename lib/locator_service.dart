import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_clean_arc/core/platform/network_info.dart';
import 'package:udemy_clean_arc/feature/data/datasources/person_local_data_source.dart';
import 'package:udemy_clean_arc/feature/data/datasources/person_remote_data_source.dart';
import 'package:udemy_clean_arc/feature/data/repositories/person_repository_impl.dart';
import 'package:udemy_clean_arc/feature/domain/repositories/person_repository.dart';
import 'package:udemy_clean_arc/feature/domain/usecases/get_all_persons.dart';
import 'package:udemy_clean_arc/feature/presentation/bloc/get_all_persons_bloc/get_all_persons_bloc.dart';
import 'package:udemy_clean_arc/feature/presentation/bloc/search_bloc/search_bloc.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => GetAllPersonsBloc(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPersons(sl()));

  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(client: http.Client()),
  );
  sl.registerLazySingleton<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
