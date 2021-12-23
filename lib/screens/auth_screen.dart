// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _loginController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        title: const Text(
          'Авторизация',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            width: 300,
            margin: const EdgeInsets.fromLTRB(40, 40, 40, 0),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: _loginController,
                  decoration: InputDecoration(
                      hintText: 'Логин',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: _passController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: 'Пароль',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 300, // <-- match_parent
            height: 100,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
              child: RaisedButton(
                child: const Text('Войти',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 15),
                    textAlign: TextAlign.center),
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(20),
                onPressed: () {
                  if (_loginController.text.isNotEmpty &&
                      _passController.text.isNotEmpty) {
                    Network.getDriver(
                            _loginController.text, _passController.text)
                        .then(
                      (answer) {
                        Provider.of<DriverProvider>(context, listen: false)
                            .setDriver(answer);
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
