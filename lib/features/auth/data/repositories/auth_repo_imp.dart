
import '../../domain/entities/user_entities.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_source/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity> login(String email, String password) {
    return remote.login(email, password);
  }

  @override
  Future<UserEntity> register(String email, String password, String name) {
    return remote.register(email, password, name);
  }
}
