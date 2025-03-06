import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user_bloc.dart';
import '../blocs/user_event.dart';
import '../models/users_data.dart';

class UserUpdateScreen extends StatelessWidget {
  final UserDetails userDetails;
  UserUpdateScreen({super.key, required this.userDetails});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = userDetails.name ?? '';
    ageController.text = userDetails.age?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _textFieldWithHeader(title: 'Name', controller: nameController),
            SizedBox(
              height: 30,
            ),
            _textFieldWithHeader(title: 'Age', controller: ageController),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // padding: EdgeInsets.all(10),

            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            context.read<UsersBloc>().add(
                  UpdateUser(userDetails.copyWith(
                    name: nameController.text,
                    age: int.tryParse(ageController.text),
                  )),
                );
            Navigator.pop(context);
          },
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _textFieldWithHeader(
      {required String title, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.5)),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 189, 188, 188),
                  width: 1), // Default color
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
