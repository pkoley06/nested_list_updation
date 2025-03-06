// BLoC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested_list_updation/blocs/user_state.dart';

import '../models/users_data.dart';
import 'user_event.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateUser>(_onUpdateUser);
  }

  void _onLoadUsers(LoadUsers event, Emitter<UsersState> emit) {
    List<UserDetails> users = [
      UserDetails(id: 1, name: 'Pranay', age: 30),
      UserDetails(
        id: 2,
        name: 'Satyam',
        age: 25,
        child: [
          UserDetails(id: 3, name: 'Subhabrata', age: 5, child: [
            UserDetails(
              id: 4,
              name: 'Animesh',
              age: 25,
              child: [
                UserDetails(id: 7, name: 'Sohom', age: 5),
                UserDetails(id: 9, name: 'Chinmoy', age: 5),
              ],
            ),
          ]),
        ],
      ),
    ];
    emit(UsersLoaded(users));
  }

  void _onUpdateUser(UpdateUser event, Emitter<UsersState> emit) {
    if (state is UsersLoaded) {
      final users = (state as UsersLoaded).users;
      final updatedUsers = users.map((user) {
        debugPrint('${user.id} ${event.updatedUser.id}');
        return _updateNestedUser(user, event.updatedUser);
      }).toList();
      emit(UsersLoaded(updatedUsers));
    }
  }

  UserDetails _updateNestedUser(
      UserDetails currentUser, UserDetails updatedUser) {
    if (currentUser.id == updatedUser.id) {
      return updatedUser;
    }

    return currentUser.copyWith(
      child: currentUser.child
          ?.map((child) => _updateNestedUser(child, updatedUser))
          .toList(),
    );
  }
}
