import '../models/users_data.dart';

abstract class UsersEvent {}

class LoadUsers extends UsersEvent {}

class UpdateUser extends UsersEvent {
  final UserDetails updatedUser;
  UpdateUser(this.updatedUser);
}
