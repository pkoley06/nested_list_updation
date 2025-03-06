import '../models/users_data.dart';

abstract class UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserDetails> users;
  UsersLoaded(this.users);
}

class UsersError extends UsersState {}
