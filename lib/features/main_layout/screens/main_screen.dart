import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/styles/app_colors.dart';
import 'package:recipe_finder/features/favorites/presentation/screens/favourites_screen.dart';
import '../../../core/dependency_injection/di.dart';
import '../../categories/presentation/screens/category_screen.dart';
import '../../home/presentation/manager/recipes_cubit.dart';
import '../../home/presentation/screens/home_screen.dart';
import '../../search/presentation/screens/search_recipe_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      BlocProvider(
        create: (context) {
          return getIt<RecipeCubit>()..fetchRandomRecipes();
        },
        child: HomeScreen(),
      ),
      CategoriesScreen(),
      SearchScreen(),
      FavoritesScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
