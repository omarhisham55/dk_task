import 'package:dakahlia_task/config/sharedPrefs/shared_prefs.dart';
import 'package:dakahlia_task/core/api/api_consumer.dart';
import 'package:dakahlia_task/core/api/app_interceptor.dart';
import 'package:dakahlia_task/core/api/dio_consumer.dart';
import 'package:dakahlia_task/features/authentication/data/datasources/user_datasource.dart';
import 'package:dakahlia_task/features/authentication/data/repositories/user_repo_impl.dart';
import 'package:dakahlia_task/features/authentication/domain/repositories/user_repo.dart';
import 'package:dakahlia_task/features/authentication/domain/usecases/get_user_usecase.dart';
import 'package:dakahlia_task/features/authentication/domain/usecases/save_user_usecase.dart';
import 'package:dakahlia_task/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:dakahlia_task/features/home/data/datasources/products_datasource.dart';
import 'package:dakahlia_task/features/home/data/datasources/user_products_datasource.dart';
import 'package:dakahlia_task/features/home/data/repositories/products_repo_impl.dart';
import 'package:dakahlia_task/features/home/data/repositories/user_products_repo_impl.dart';
import 'package:dakahlia_task/features/home/domain/repositories/products_repo.dart';
import 'package:dakahlia_task/features/home/domain/repositories/user_products_repo.dart';
import 'package:dakahlia_task/features/home/domain/usecases/get_products_usecase.dart';
import 'package:dakahlia_task/features/home/domain/usecases/get_user_products_usecase.dart';
import 'package:dakahlia_task/features/home/presentation/cubit/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DpiController {
  static final getIt = GetIt.instance;
  static Future<void> init() async {
    // await dotenv.load(fileName: '.env');
    //database
    // getIt.registerLazySingletonAsync<PostgreSqlDB>(
    //   () async {
    //     final connection = await Connection.open(
    //       Endpoint(
    //         host: dotenv.env['DB_HOST'].toString(),
    //         port: int.parse(dotenv.env['DB_PORT'].toString()),
    //         database: dotenv.env['DB_NAME'].toString(),
    //         username: dotenv.env['DB_USERNAME'].toString(),
    //         password: dotenv.env['DB_PASSWORD'].toString(),
    //       ),
    //     ).then((value) {
    //       debugPrint('value: $value');
    //       return value;
    //     }).catchError((e) {
    //       debugPrint('e: $e');
    //       return Future<Connection>.error(e.toString());
    //     });
    //     return PostgreSqlDB(connection: connection);
    //   },
    // );
    // await getIt.isReady<PostgreSqlDB>();

    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(
      () => SharedPrefsController(sharedPrefs: getIt()),
    );
    //dio
    getIt.registerLazySingleton(() => sharedPreferences);
    getIt.registerLazySingleton(() => Dio());
    getIt
        .registerLazySingleton<ApiConsumer>(() => DioConsumer(client: getIt()));
    getIt
        .registerLazySingleton<DioConsumer>(() => DioConsumer(client: getIt()));
    getIt.registerLazySingleton(() => AppInterceptor());
    getIt.registerLazySingleton(() => LogInterceptor(
          request: false,
          requestHeader: false,
          requestBody: false,
          responseBody: true,
          responseHeader: false,
          error: true,
        ));
    //bloc
    getIt.registerFactory(
      () => AuthenticationCubit(
        getUserUsecase: getIt(),
        saveUserUsecase: getIt(),
      ),
    );
    getIt.registerFactory(
      () => HomeCubit(
        getProductsUsecase: getIt(),
        getUserProductsUsecase: getIt(),
      ),
    );
    //datasource
    getIt.registerLazySingleton<ProductsDatasource>(
        () => ProductsDatasourceImpl(client: getIt()));
    getIt.registerLazySingleton<UserProductsDatasource>(
        () => UserProductsDatasourceImpl(client: getIt()));
    getIt.registerLazySingleton<UserDatasource>(
        () => UserDatasourceImpl(client: getIt()));
    //repos
    getIt.registerLazySingleton<ProductsRepo>(
        () => ProductsRepoImpl(productsDatasource: getIt()));
    getIt.registerLazySingleton<UserProductsRepo>(
        () => UserProductsRepoImpl(userProductsDatasource: getIt()));
    getIt.registerLazySingleton<UserRepo>(
        () => UserRepoImpl(userDatasource: getIt()));
    //usecases
    getIt
        .registerLazySingleton(() => GetProductsUsecase(productsRepo: getIt()));
    getIt.registerLazySingleton(
        () => GetUserProductsUsecase(userProductsRepo: getIt()));
    getIt.registerLazySingleton(() => GetUserUsecase(userRepo: getIt()));
    getIt.registerLazySingleton(() => SaveUserUsecase(userRepo: getIt()));
  }
}
