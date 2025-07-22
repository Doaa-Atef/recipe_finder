import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/features/shared/widgets/recipe_grid_shimmer.dart';
import '../../../../core/dependency_injection/di.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/widgets/custom-appbar.dart';
import '../../../favorites/presentation/manager/favourites_cubit.dart';
import '../../../favorites/presentation/manager/favourites_state.dart';
import '../../../shared/widgets/recipe_gridview.dart';
import '../manager/category_recipe_cubit.dart';

class CategoryRecipesScreen extends StatefulWidget {
  final String category;
  final bool isCuisine;

  const CategoryRecipesScreen({
    required this.category,
    required this.isCuisine,
    super.key,
  });

  @override
  State<CategoryRecipesScreen> createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CategoryRecipesCubit>().fetchRecipes(
      widget.category,
      widget.isCuisine,
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoadingMore(context)) {
        context.read<CategoryRecipesCubit>().loadMoreRecipes(
          widget.category,
          widget.isCuisine,
        );
      }
    });
  }

  bool _isLoadingMore(BuildContext context) {
    final state = context.read<CategoryRecipesCubit>().state;
    return state is CategoryRecipesLoadingMore;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<FavoritesCubit>()
            ..loadFavorites(SharedPrefs.getUserId() ?? ''),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(titleKey: widget.category),
        body: BlocBuilder<CategoryRecipesCubit, CategoryRecipeState>(
          builder: (context, state) {
            if (state is CategoryRecipesLoading) {
              return RecipeGridShimmer();
            } else if (state is CategoryRecipesLoaded ||
                state is CategoryRecipesLoadingMore) {
              final recipes = state is CategoryRecipesLoaded
                  ? state.recipes
                  : (state as CategoryRecipesLoadingMore).recipes;
              final hasMore = state is CategoryRecipesLoaded
                  ? state.hasMore
                  : (state as CategoryRecipesLoadingMore).hasMore;

              return Column(
                children: [
                  Expanded(
                    child: BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, favState) {
                        final favoriteIds = favState is FavoritesLoaded
                            ? favState.favorites.map((e) => e.id).toSet()
                            : <int>{};

                        return RecipeGridView(
                          recipes: recipes,
                          favoriteIds: favoriteIds,
                          onToggleFavorite: (recipe, isFav) {
                            isFav
                                ? context
                                      .read<FavoritesCubit>()
                                      .removeFavourite(recipe.id)
                                : context.read<FavoritesCubit>().addFavourite(
                                    recipe,
                                  );
                          },
                          onLoadMore: () => context
                              .read<CategoryRecipesCubit>()
                              .loadMoreRecipes(
                                widget.category,
                                widget.isCuisine,
                              ),
                          isLoadingMore: state is CategoryRecipesLoadingMore,
                          hasMore: hasMore,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is CategoryRecipesError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
