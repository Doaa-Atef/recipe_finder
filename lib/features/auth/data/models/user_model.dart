import '../../domain/entities/user_entities.dart';



class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    required super.name,
  });

  factory UserModel.fromFirebase(user, String name) {
    return UserModel(
      uid: user.uid,
      email: user.email??'',
      name: name,
    );
  }
}
