import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder/features/shared/widgets/recipe_grid_shimmer.dart';
import '../../../../core/dependency_injection/di.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/widgets/custom-appbar.dart';
import '../../../shared/widgets/recipe_gridview.dart';
import '../manager/favourites_cubit.dart';
import '../manager/favourites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: Future.value(SharedPrefs.getUserId()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final userId = snapshot.data;
        if (userId == null) {
          return Scaffold(body: Center(child: Text('Please login first.')));
        }
        return BlocProvider(
          create: (context) => getIt<FavoritesCubit>()..loadFavorites(userId),
          child: Scaffold(
            appBar: CustomAppBar(titleKey: "Favorites"),
            body: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoading) {
                  return RecipeGridShimmer();
                } else if (state is FavoritesLoaded) {
                  if (state.favorites.isEmpty) {
                    return Center(
                      child: Text(
                        'No Favorites yet.',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    );
                  }

                  return RecipeGridView(
                    recipes: state.favorites,
                    favoriteIds: state.favorites.map((e) => e.id).toSet(),
                    onToggleFavorite: (recipe, isFavorite) {
                      final cubit = context.read<FavoritesCubit>();
                      isFavorite
                          ? cubit.removeFavourite(recipe.id)
                          : cubit.addFavourite(recipe);
                    },
                  );
                } else {
                  return Center(child: Text('Something went wrong.'));
                }
              },
            ),
          ),
        );
      },
    );
  }
}
