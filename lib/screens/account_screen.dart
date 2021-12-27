// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/change_pass_screen.dart';
import 'package:ridbrain_project/services/constants.dart';
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
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 60,
                          color: Colors.grey[400],
                        )),
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
                    boxShadow: shadow),
              ),
              Container(
                height: 75,
                margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: Material(
                  color: Colors.white,
                  borderRadius: radius,
                  child: InkWell(
                    borderRadius: radius,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PassScreen(),
                          ));
                    },
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
                  ),
                ),
                decoration: const BoxDecoration(
                    borderRadius: radius, boxShadow: shadow),
              ),
              Container(
                height: 75,
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Material(
                  color: Colors.white,
                  borderRadius: radius,
                  child: InkWell(
                    borderRadius: radius,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PassScreen(),
                          ));
                    },
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
                  ),
                ),
                decoration: const BoxDecoration(
                    borderRadius: radius, boxShadow: shadow),
              ),
            ]))
          ],
        ));
  }
}
