import 'package:ecommerce_app/core/database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  final productDatabase =
      await $FloorProductDatabase.databaseBuilder('product.db').build();
  sl.registerLazySingleton<ProductDatabase>(() => productDatabase);
}
