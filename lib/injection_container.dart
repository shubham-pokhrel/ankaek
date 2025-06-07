import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_constants.dart';
import 'core/network/network_info.dart';
import 'features/posts/data/datasources/post_local_data_source.dart';
import 'features/posts/data/datasources/post_remote_data_source.dart';
import 'features/posts/data/models/post_model.dart';
import 'features/posts/data/repositories/post_repository_impl.dart';
import 'features/posts/domain/repositories/post_repository.dart';
import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/get_posts.dart';
import 'features/posts/domain/usecases/get_saved_posts.dart';
import 'features/posts/domain/usecases/save_post.dart';
import 'features/posts/presentation/cubit/posts_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Posts
  // Cubit
  sl.registerFactory(
    () => PostsCubit(
      getPosts: sl(),
      savePost: sl(),
      getSavedPosts: sl(),
      deletePost: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPosts(sl()));
  sl.registerLazySingleton(() => SavePost(sl()));
  sl.registerLazySingleton(() => GetSavedPosts(sl()));
  sl.registerLazySingleton(() => DeletePost(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImpl(box: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: sl()));

  // External
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Dio());
  
  // Hive Box
  final box = await Hive.openBox<PostModel>(AppConstants.hiveBoxName);
  sl.registerLazySingleton<Box<PostModel>>(() => box);

  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}