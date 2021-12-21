import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/check_screen.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';
import 'package:ridbrain_project/screens/auth_screen.dart';
import 'package:ridbrain_project/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var driverProvider = await DriverProvider.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => driverProvider,
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CheckToken(),
      ),
    ),
  );
}
