import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/routes/routes.dart';
import '../../features/auth/presentation/manager/auth_cubit.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/categories/presentation/manager/category_recipe_cubit.dart';
import '../../features/categories/presentation/screens/category_recipes_screen.dart';
import '../../features/favorites/presentation/screens/favourites_screen.dart';
import '../../features/home/presentation/manager/recipes_cubit.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/main_layout/screens/main_screen.dart';
import '../../features/recipe_details/presentation/screens/recipe_details_screen.dart';
import '../../features/search/presentation/manager/search_recipe_cubit.dart';
import '../../features/search/presentation/screens/search_recipe_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../dependency_injection/di.dart';

class RouteServices {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print("name========>${settings.name}");
    }
    if (kDebugMode) {
      print("name========>${settings.arguments}");
    }

    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => getIt<AuthCubit>(),
              child: LoginScreen(),
            );
          },
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: RegisterScreen(),
          ),
        );

      case Routes.main:
        return MaterialPageRoute(
          builder: (context) {
            return MainScreen();
          },
        );
      case Routes.categoryResults:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<CategoryRecipesCubit>()
                  ..fetchRecipes(args['category'], args['isCuisine']),
            child: CategoryRecipesScreen(
              category: args['category'],
              isCuisine: args['isCuisine'],
            ),
          ),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => getIt<RecipeCubit>()..fetchRandomRecipes(),
              child: HomeScreen(),
            );
          },
        );
      case Routes.categoryRecipes:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => CategoryRecipesScreen(
            category: args['category'],
            isCuisine: args['isCuisine'],
          ),
        );
      case Routes.recipeDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => RecipeDetailsScreen(
            recipeId: args['id'],
            recipeTitle: args['title'],
          ),
        );
      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SearchCubit>(),
            child: const SearchScreen(),
          ),
        );
      case Routes.favouritesScreen:
        return MaterialPageRoute(builder: (context) => const FavoritesScreen());

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Center(child: Text("Not Found"));
          },
        );
    }
  }
}
