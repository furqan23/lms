import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splashapp/Controller/cart_controller.dart';
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/view/auth/login/login_view.dart';
import 'package:splashapp/view/home/home_screen.dart';
import 'package:splashapp/view/splash/splach_screen.dart';
import 'package:splashapp/view/walk.dart';
import 'dart:developer' as developer;
// Define your HiveBoxes class as before
class HiveBoxes {
  static const String settingsBox = 'settingsBox';
}

// Define your authentication logic here (replace this with your actual logic)
bool isUserLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open the settings box
  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.settingsBox);
  await Hive.openBox<String>('tokenBox');
  Get.put(CartController());

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (dynamic error, dynamic stack) {
    developer.log("Something went wrong!", error: error, stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check whether the user has seen onboarding
    final settingsBox = Hive.box(HiveBoxes.settingsBox);
    final hasSeenOnboarding =
        settingsBox.get('hasSeenOnboarding', defaultValue: false);

    // Determine the initial route based on whether the user is logged in
    final initialRoute = hasSeenOnboarding
        ? (isUserLoggedIn ? '/main' : '/login')
        : '/splachScreen';

    return GetMaterialApp(
      title: 'QCAa',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        primarySwatch: Colors.green,
      ),
      initialRoute: initialRoute,
      routes: {
        '/main': (context) => const HomeScreen(),
        '/splachScreen': (context) => const SplachScreen(),
        '/login': (context) => LoginView(),
        // Replace with your login screen widget
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
