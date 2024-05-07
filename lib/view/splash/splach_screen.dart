import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:splashapp/res/color/appcolor.dart';
import 'package:splashapp/view/walk.dart';
import '../../main.dart';
import '../auth/login/login_view.dart';
import '../home/home_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  void _onGetStartedPressed() async {
    final settingsBox = await Hive.openBox(HiveBoxes.settingsBox);
    await settingsBox.put('hasSeenOnboarding', true);

    if (isUserLoggedIn) {
      Get.to(() => HomeScreen());
      print('User is in the Home screen');
    } else {
      Get.to(() =>  const LoginView());
      print('User is in the Login screen');
    }
  }
  void checkLoginStatus() async {
    final box = await Hive.openBox<String>('tokenBox');
    final String? token = box.get('token');

    if (token != null) {
      Get.off(() => const HomeScreen(), transition: Transition.noTransition);
    }
  }
  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      backgroundColor: AppColors.primaryColor,
      nextScreen: isUserLoggedIn ? const HomeScreen(): OnboardingScreen(),
      splashIconSize: 360,
      duration: 3,
      animationDuration: const Duration(milliseconds: 1000),
      splashTransition: SplashTransition.fadeTransition,
      splash: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height *0.06),
          Image.asset(
            'assets/images/logo.png',
            width: 200,
            height: 180,
          ),
          const SizedBox(height: 15),
          const Text(
            'Quality Coaching Academy',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor),
          ),
          const SizedBox(height: 40),

        ],
      ),
    );
  }
}
