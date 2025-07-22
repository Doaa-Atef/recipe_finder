import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../domain/entities/user_entities.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit(this.loginUseCase, this.registerUseCase) : super(AuthInitial());
  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(email, password);
      await SharedPrefs.setUserId(user.uid);

      emit(AuthSuccess(user));

    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void register(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(email, password, name);
      await SharedPrefs.setUserId(user.uid);
      emit(AuthSuccess(user));

    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(AuthFailure(e.message ?? "Unknown error"));
      } else {
        emit(AuthFailure("An error occurred"));
      }
    }

  }


}
