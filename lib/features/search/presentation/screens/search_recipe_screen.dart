import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/dependency_injection/di.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/widgets/custom-appbar.dart';
import '../../../favorites/presentation/manager/favourites_cubit.dart';
import '../manager/search_recipe_cubit.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_result.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider.value(
          value: getIt<FavoritesCubit>()
            ..loadFavorites(SharedPrefs.getUserId() ?? ''),
        ),
      ],
      child: Scaffold(
        appBar: const CustomAppBar(titleKey: "Search"),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchSuccess || state is SearchLoadingMore) {}

            return Column(
              children: [
                SearchInputField(
                  controller: controller,
                  onSearch: (query) {
                    context.read<SearchCubit>().search(query);
                  },
                ),
                Expanded(child: SearchResults(controller: controller)),
              ],
            );
          },
        ),
      ),
    );
  }
}
