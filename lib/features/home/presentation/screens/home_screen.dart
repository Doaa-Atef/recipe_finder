import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/styles/app_colors.dart';
import '../../../../core/dependency_injection/di.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/widgets/custom-appbar.dart';
import '../../../favorites/presentation/manager/favourites_cubit.dart';
import '../../../favorites/presentation/manager/favourites_state.dart';
import '../../../shared/widgets/recipe_grid_shimmer.dart';
import '../../../shared/widgets/recipe_gridview.dart';
import '../manager/recipes_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<RecipeCubit>().fetchRandomRecipes();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoadingMore(context)) {
        context.read<RecipeCubit>().loadMoreRecipes();
      }
    });
  }

  bool _isLoadingMore(BuildContext context) {
    final state = context.read<RecipeCubit>().state;
    return state is RecipeLoadingMore;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<FavoritesCubit>()
        ..loadFavorites(SharedPrefs.getUserId() ?? ''),
      child: Scaffold(
        appBar: CustomAppBar(
          titleKey: "Recipes",
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: AppColors.offWhite),
              onPressed: () async {
                await SharedPrefs.remove('user_uid');
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<RecipeCubit, RecipesState>(
          builder: (context, state) {
            if (state is RecipeLoading) {
              return RecipeGridShimmer();
            }

            if (state is RecipeLoaded || state is RecipeLoadingMore) {
              final recipes = state is RecipeLoaded
                  ? state.recipes
                  : (state as RecipeLoadingMore).recipes;

              final hasMore = state is RecipeLoaded
                  ? state.hasMore
                  : (state as RecipeLoadingMore).hasMore;

              return BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) {
                  final favoriteIds = favState is FavoritesLoaded
                      ? favState.favorites.map((e) => e.id).toSet()
                      : <int>{};

                  return Column(
                    children: [
                      Expanded(
                        child: RecipeGridView(
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
                          onLoadMore: () =>
                              context.read<RecipeCubit>().loadMoreRecipes(),
                          isLoadingMore: state is RecipeLoadingMore,
                          hasMore: hasMore,
                        ),
                      ),
                    ],
                  );
                },
              );
            }

            return Center(child: Text('Something went wrong.'));
          },
        ),
      ),
    );
  }
}
