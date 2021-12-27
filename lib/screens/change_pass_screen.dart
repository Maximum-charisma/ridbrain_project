import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/services/constants.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';
import 'package:ridbrain_project/services/snack_bar.dart';

class PassScreen extends StatefulWidget {
  PassScreen({Key? key}) : super(key: key);

  @override
  _PassScreenState createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  TextEditingController _oldPass = TextEditingController();
  TextEditingController _newPass = TextEditingController();
  TextEditingController _secondNewPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Пароль',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: TextField(
                    controller: _oldPass,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: 'Старый пароль',
                        focusedBorder: OutlineInputBorder(borderRadius: radius),
                        border: OutlineInputBorder(borderRadius: radius)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: TextField(
                    controller: _newPass,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: 'Новый пароль',
                        focusedBorder: OutlineInputBorder(borderRadius: radius),
                        border: OutlineInputBorder(borderRadius: radius)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: TextField(
                      controller: _secondNewPass,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Новый пароль',
                        focusedBorder: OutlineInputBorder(borderRadius: radius),
                        border: OutlineInputBorder(borderRadius: radius),
                      )),
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(55, 30, 55, 0),
                  child: Material(
                    color: Colors.black,
                    borderRadius: radius,
                    child: InkWell(
                      borderRadius: radius,
                      onTap: () {
                        checkFields(provider);
                      },
                      child: const Center(
                        child: Text(
                          'Изменить пароль',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                      borderRadius: radius, boxShadow: shadow),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> checkFields(provider) async {
    if (_oldPass.text.isNotEmpty &&
        _newPass.text.isNotEmpty &&
        _secondNewPass.text.isNotEmpty) {
      if (_newPass.text == _secondNewPass.text) {
        var result = await Network(context).changePass(
            provider.driver.driverToken, _oldPass.text, _newPass.text);
      } else {
        StandartSnackBar.show(
          context,
          'Новые пароли не совпадают',
          SnackBarStatus.warning(),
        );
      }
    } else {
      StandartSnackBar.show(
        context,
        'Поля не заполнены',
        SnackBarStatus.warning(),
      );
    }
  }
}
