import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:splashapp/res/color/appcolor.dart';
import 'package:splashapp/view/auth/login/login_view.dart';
import 'package:splashapp/view/home/home_screen.dart';
import 'package:splashapp/view/mycourses/my_courses.dart';
import 'package:splashapp/view/splash/splach_screen.dart';
import 'dart:developer' as developer;

import 'package:splashapp/view_model/Controller/cart/cart_controller.dart';

class HiveBoxes {
  static const String settingsBox = 'settingsBox';
}

bool isUserLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.settingsBox);
  await Hive.openBox<String>('tokenBox');
  Get.put(CartController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box(HiveBoxes.settingsBox);
    final hasSeenOnboarding =
        settingsBox.get('hasSeenOnboarding', defaultValue: false);

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
        '/login': (context) => const LoginView(),
        '/myCourses': (context) => const MyCourses(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
