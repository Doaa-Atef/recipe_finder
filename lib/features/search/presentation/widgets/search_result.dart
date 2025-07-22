import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../favorites/presentation/manager/favourites_cubit.dart';
import '../../../favorites/presentation/manager/favourites_state.dart';
import '../../../shared/widgets/recipe_grid_shimmer.dart';
import '../../../shared/widgets/recipe_gridview.dart';
import '../manager/search_recipe_cubit.dart';

class SearchResults extends StatelessWidget {
  final TextEditingController controller;

  const SearchResults({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return RecipeGridShimmer();
        }

        if (state is SearchSuccess || state is SearchLoadingMore) {
          final recipes = state is SearchSuccess
              ? state.recipes
              : (state as SearchLoadingMore).recipes;

          final hasMore = state is SearchSuccess
              ? state.hasMore
              : (state as SearchLoadingMore).hasMore;

          final isLoadingMore = state is SearchLoadingMore;

          final favoriteIds = context.select<FavoritesCubit, Set<int>>((cubit) {
            final favState = cubit.state;
            if (favState is FavoritesLoaded) {
              return favState.favorites.map((e) => e.id).toSet();
            }
            return <int>{};
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0.h),
              ),
              Expanded(
                child: RecipeGridView(
                  recipes: recipes,
                  favoriteIds: favoriteIds,
                  isLoadingMore: isLoadingMore,
                  hasMore: hasMore,
                  onToggleFavorite: (recipe, isFavorite) {
                    final cubit = context.read<FavoritesCubit>();
                    isFavorite
                        ? cubit.removeFavourite(recipe.id)
                        : cubit.addFavourite(recipe);
                  },
                  onLoadMore: () =>
                      context.read<SearchCubit>().loadMoreResults(),
                ),
              ),
            ],
          );
        }
        if (state is SearchError) {
          return Center(child: Text(state.message));
        }

        return SizedBox();
      },
    );
  }
}
