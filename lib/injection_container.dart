import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_constants.dart';
import 'features/posts/data/models/post_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
 
  // Hive Box
  final box = await Hive.openBox<PostModel>(AppConstants.hiveBoxName);
  sl.registerLazySingleton<Box<PostModel>>(() => box);

  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}