import 'package:bloc/bloc.dart';
import '../../../home/domain/entities/recipes_entity.dart';
import '../../domain/usecases/add_to_fav_usecase.dart';
import '../../domain/usecases/get_fav_usecase.dart';
import '../../domain/usecases/remove_from_fav_usecase.dart';
import 'favourites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final AddToFavoritesUseCase addToFavoritesUseCase;
  final RemoveFromFavoritesUseCase removeFromFavoritesUseCase;

  String? _userId;

  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.addToFavoritesUseCase,
    required this.removeFromFavoritesUseCase,
  }) : super(FavoritesInitial());

  String? get userId => _userId;

  Future<void> loadFavorites(String userId) async {
    emit(FavoritesLoading());
    _userId = userId;
    final recipes = await getFavoritesUseCase(userId);
    emit(FavoritesLoaded(recipes));
  }

  Future<void> addFavourite(Recipe recipe) async {
    if (_userId == null) return;
    await addToFavoritesUseCase(_userId!, recipe);
    await loadFavorites(_userId!);
  }

  Future<void> removeFavourite(int recipeId) async {
    if (_userId == null) return;
    await removeFromFavoritesUseCase(_userId!, recipeId);
    await loadFavorites(_userId!);
  }
}
