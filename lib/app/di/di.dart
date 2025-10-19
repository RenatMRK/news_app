import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// 🌐 CORE
import 'package:news_app/core/network/api_client.dart';
import 'package:news_app/core/network/http_api_client.dart';
import 'package:news_app/core/storage/i_local_storage.dart';
import 'package:news_app/core/storage/shared_prefs_storage.dart';

// 📰 NEWS FEATURE
import 'package:news_app/features/news/data/datasources/news_remote_data_source.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/repository/i_news_repository.dart';
import 'package:news_app/features/news/domain/usecases/get_news.dart';
import 'package:news_app/features/news/presentation/logic/news/news_bloc.dart';
import 'package:news_app/features/news/presentation/logic/favorites/favorites_bloc.dart';

// 💛 SHARED FAVORITES CORE
import 'package:news_app/features/shared/favorites_core/data/datasources/favorites_local_data_source.dart';
import 'package:news_app/features/shared/favorites_core/data/repositories/favorites_repository_impl.dart';
import 'package:news_app/features/shared/favorites_core/domain/repository/i_favorites_repository.dart';
import 'package:news_app/features/shared/favorites_core/domain/usecases/is_favorite.dart';
import 'package:news_app/features/shared/favorites_core/domain/usecases/toggle_favorite.dart';
import 'package:news_app/features/shared/favorites_core/domain/usecases/get_favorites.dart';

// ⭐ FAVORITES FEATURE
import 'package:news_app/features/favorites/presentation/logic/favorites_list_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // 🌍 ---------------- CORE ----------------
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<ILocalStorage>(
    () => SharedPrefsStorage(prefs),
  );

  sl.registerLazySingleton<ApiClient>(
    () => HttpApiClient(http.Client()),
  );

  // 📰 ---------------- NEWS ----------------
  sl.registerLazySingleton<INewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(
      httpClient: sl<ApiClient>(),
      apiKey: 'ad5bf4b1609e4315b6d5f17cfe28138e',
    ),
  );

  sl.registerLazySingleton<INewsRepository>(
    () => NewsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetNews(sl()));
  sl.registerFactory(() => NewsBloc(sl()));

  // 💛 ---------------- SHARED FAVORITES CORE ----------------
  sl.registerLazySingleton<IFavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(sl<ILocalStorage>()),
  );

  sl.registerLazySingleton<IFavoritesRepository>(
    () => FavoritesRepositoryImpl(sl<IFavoritesLocalDataSource>()),
  );

  sl.registerLazySingleton(() => ToggleFavorite(sl<IFavoritesRepository>()));
  sl.registerLazySingleton(() => IsFavorite(sl<IFavoritesRepository>()));
  sl.registerLazySingleton(() => GetFavorites(sl<IFavoritesRepository>()));

  // ⭐ ---------------- FEATURE BLOCS ----------------
  sl.registerFactory(() => FavoritesBloc(sl(), sl())); // toggle / check (news)
  sl.registerFactory(() => FavoritesListBloc(sl()));    // get all (favorites)
}
