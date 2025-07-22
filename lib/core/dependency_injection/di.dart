import 'package:get_it/get_it.dart';
import 'package:recipe_finder/features/search/presentation/manager/search_recipe_cubit.dart';
import '../../features/auth/data/data_source/auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repo_imp.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/manager/auth_cubit.dart';
import '../../features/categories/domain/usecases/category_usecase.dart';
import '../../features/categories/presentation/manager/category_recipe_cubit.dart';
import '../../features/favorites/data/data_source/favourites_local_datasource.dart';
import '../../features/favorites/data/repositories/favourites_repo_imp.dart';
import '../../features/favorites/domain/repositories/favourites_repository.dart';
import '../../features/favorites/domain/usecases/add_to_fav_usecase.dart';
import '../../features/favorites/domain/usecases/get_fav_usecase.dart';
import '../../features/favorites/domain/usecases/remove_from_fav_usecase.dart';
import '../../features/favorites/presentation/manager/favourites_cubit.dart';
import '../../features/home/data/data_source/recipe_remote_datasource.dart';
import '../../features/home/data/repositories/recipe_repo_imp.dart';
import '../../features/home/domain/repositories/recipe_repository.dart';
import '../../features/home/domain/usecases/random_recipes_usecase.dart';
import '../../features/home/presentation/manager/recipes_cubit.dart';
import '../../features/recipe_details/data/data_source/recipe_details_remote_datasource.dart';

import '../../features/recipe_details/data/repository/recipe_details_repo_impl.dart';
import '../../features/recipe_details/domain/repository/recipe_details_repo.dart';
import '../../features/recipe_details/domain/usecase/recipe_details_usecase.dart';
import '../../features/recipe_details/presentation/manager/recipe_details_cubit.dart';
import '../../features/search/domain/usescases/search_recipe_usecase.dart';
import '../network/network_services.dart';
import '../shared_prefs/shared_prefs.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  NetworkServices.init();

  getIt.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(getIt<RecipeRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetRandomRecipes>(
    () => GetRandomRecipes(getIt<RecipeRepository>()),
  );

  getIt.registerLazySingleton<GetRecipesByCategory>(
    () => GetRecipesByCategory(getIt<RecipeRepository>()),
  );

  getIt.registerFactory<RecipeCubit>(
    () => RecipeCubit(getIt<GetRandomRecipes>()),
  );

  getIt.registerFactory<CategoryRecipesCubit>(
    () => CategoryRecipesCubit(getIt<GetRecipesByCategory>()),
  );

  getIt.registerLazySingleton<RecipeDetailsRemoteDataSource>(
    () => RecipeDetailsRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<RecipeDetailsRepository>(
    () => RecipeDetailsRepositoryImpl(getIt<RecipeDetailsRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetRecipeDetailsUseCase>(
    () => GetRecipeDetailsUseCase(getIt<RecipeDetailsRepository>()),
  );

  getIt.registerFactory<RecipeDetailsCubit>(
    () => RecipeDetailsCubit(getIt<GetRecipeDetailsUseCase>()),
  );

  getIt.registerLazySingleton<SearchRecipesUseCase>(
    () => SearchRecipesUseCase(getIt<RecipeRepository>()),
  );

  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(getIt<SearchRecipesUseCase>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(getIt()));
  getIt.registerFactory(() => AuthCubit(getIt(), getIt()));

  getIt.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(SharedPrefs.instance),
  );

  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt<FavoritesLocalDataSource>()),
  );

  getIt.registerLazySingleton<AddToFavoritesUseCase>(
    () => AddToFavoritesUseCase(getIt<FavoritesRepository>()),
  );

  getIt.registerLazySingleton<RemoveFromFavoritesUseCase>(
    () => RemoveFromFavoritesUseCase(getIt<FavoritesRepository>()),
  );

  getIt.registerLazySingleton<GetFavoritesUseCase>(
    () => GetFavoritesUseCase(getIt<FavoritesRepository>()),
  );

  getIt.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(
      getFavoritesUseCase: getIt<GetFavoritesUseCase>(),
      addToFavoritesUseCase: getIt<AddToFavoritesUseCase>(),
      removeFromFavoritesUseCase: getIt<RemoveFromFavoritesUseCase>(),
    ),
  );
}
