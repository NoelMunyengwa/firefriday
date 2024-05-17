import 'package:firebase_core/firebase_core.dart';
import 'package:firefriday/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routerino/routerino.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDUCTI4gtEG5dE58T69ReMjvHvKSdKimtM',
    appId: '1:29580101553:android:a42b6784cef1f7abc61f90',
    messagingSenderId: '29580101553',
    projectId: 'uz-connect',
    storageBucket: 'uz-connect.appspot.com',
  ));
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();
  // SharedPreferences prefs;

// Initialize shared preferences
  // prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      navigatorKey: Routerino.navigatorKey,
      navigatorObservers: [RouterinoObserver()],
      home: RouterinoHome(
        builder: () => const HomePage(),
      ),
    );
  }
}
