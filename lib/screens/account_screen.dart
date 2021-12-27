// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              expandedHeight: 80,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Настройки',
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              // children: [
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.only(left: 15),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.network(
                        'https://tetatet.fun/images/player_one.png',
                        width: 70,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(provider.driver.driverName),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(provider.driver.driverEmail)
                      ],
                    )
                  ],
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black12,
                          offset: Offset(1, 3))
                    ]),
              ),
              Container(
                height: 75,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: RaisedButton(
                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  onPressed: () {},
                  child: const Center(
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Изменить пароль',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black12,
                          offset: Offset(1, 3))
                    ]),
              ),
              Container(
                height: 75,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: RaisedButton(
                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  onPressed: () {},
                  child: const Center(
                    child: ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: Text(
                        'Выйти',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black12,
                          offset: Offset(1, 3))
                    ]),
              ),
              // ],
            ]))
          ],
        ));
  }
}
