import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc.dart';
import '../blocs/user_state.dart';
import '../models/users_data.dart';
import 'update_user_screen.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Details'),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return ListView(
              children: state.users.map((user) {
                return _customExpansionTile(
                    userDetails: user, context: context);
              }).toList(),
            );
          } else {
            return const Center(child: Text('Failed to load users'));
          }
        },
      ),
    );
  }

  Widget _customExpansionTile(
      {required UserDetails userDetails, required BuildContext context}) {
    final ExpansionTileController controller = ExpansionTileController();
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.2), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          ExpansionTile(
            showTrailingIcon: userDetails.child.isNotEmpty,
            dense: true,
            controller: controller,
            shape: const Border(), // Removes default borders
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            title: Text(
              userDetails.name ?? '',
              style: const TextStyle(fontSize: 18),
            ),

            subtitle: Text(
              '${userDetails.age} years old',
              style: TextStyle(color: Colors.black.withOpacity(0.3)),
            ),

            children: userDetails.child.map((user) {
              return _customExpansionTile(userDetails: user, context: context);
            }).toList(),
          ),
          Positioned(
            top: 8,
            right: 30,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  debugPrint(userDetails.toJson().toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserUpdateScreen(userDetails: userDetails),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_note_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
