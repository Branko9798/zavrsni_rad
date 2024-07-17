import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/user/user.dart';
import 'package:zavrsni_rad/user/user_model.dart';

class UserInputScreen extends StatelessWidget {
  UserInputScreen({super.key});

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final userModel = getIt<UserModel>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userModel.getUserFuture(),
      builder: (context, snapshot) {
        firstName.text = snapshot.data?.firstName ?? "";
        lastName.text = snapshot.data?.lastName ?? "";

        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.white,
            ),
            backgroundColor: Colors.tealAccent[400],
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.userLarge,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  "User",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    saveButton();
                    Navigator.of(context).pop();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "SAVE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ))
            ],
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "User Input",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: firstName,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (value) {
                        saveButton();
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'First Name: ',
                        suffixIcon: IconButton(
                          onPressed: firstName.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: lastName,
                      textInputAction: TextInputAction.go,
                      validator: (value) {
                        RegExp regex = RegExp(r'^[a-zA-Z ]+$');
                        if (value?.isEmpty ?? true) {
                          return 'Cannot be empty';
                        }
                        if (!regex.hasMatch(value ?? "")) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        saveButton();
                      },
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Last Name: ',
                        suffixIcon: IconButton(
                          onPressed: lastName.clear,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              )),
        );
      },
    );
  }

  Future<void> saveButton() async {
    final userUuid =
        (await SharedPreferences.getInstance()).getString('userId');

    if (userUuid != null) {
      final user = User(
        userId: userUuid,
        firstName: firstName.text,
        lastName: lastName.text,
      );

      userModel.updateUser(user);
    }
  }
}
