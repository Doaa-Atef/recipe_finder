import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder/features/shared/widgets/recipe_card.dart';
import '../../home/domain/entities/recipes_entity.dart';

class RecipeGridView extends StatefulWidget {
  final List<Recipe> recipes;
  final Set<int> favoriteIds;
  final void Function(Recipe recipe, bool isFavorite) onToggleFavorite;
  final VoidCallback? onLoadMore;
  final bool? isLoadingMore;
  final bool? hasMore;

  const RecipeGridView({
    super.key,
    required this.recipes,
    required this.favoriteIds,
    required this.onToggleFavorite,
    this.onLoadMore,
    this.isLoadingMore,
    this.hasMore,
  });

  @override
  State<RecipeGridView> createState() => _RecipeGridViewState();
}

class _RecipeGridViewState extends State<RecipeGridView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (widget.onLoadMore == null ||
        widget.isLoadingMore == null ||
        widget.hasMore == null)
      return;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !widget.isLoadingMore! &&
        widget.hasMore!) {
      widget.onLoadMore!();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(10.w),
            controller: _scrollController,
            itemCount: widget.recipes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 280.h,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemBuilder: (context, index) {
              final recipe = widget.recipes[index];
              final isFavorite = widget.favoriteIds.contains(recipe.id);

              return RecipeItem(
                id: recipe.id,
                title: recipe.title,
                imageUrl: recipe.image,
                readyInMinutes: recipe.readyInMinutes,
                isFavorite: isFavorite,
                onPressed: () => widget.onToggleFavorite(recipe, isFavorite),
              );
            },
          ),
        ),
        if (widget.isLoadingMore ?? false)
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        if ((widget.hasMore == false) && widget.recipes.length >= 10)
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "No more recipes available.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }
}
