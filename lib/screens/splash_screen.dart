import 'package:flutter/material.dart';
import 'package:task_manager_getx/screens/signIn_screen.dart';
import 'package:task_manager_getx/utlis/assets_path.dart';
import '../controller/authController.dart';
import 'package:task_manager_getx/widgets/screen_background.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'main_bottom_navbar_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String name = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.getAccessToken();
    if (AuthController.isLoggedIn()) {
      await AuthController.getUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainBottomNavbarScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: ScreenBackground(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SvgPicture.asset(AssetsPath.logo)
          ],
        ),
      )),
    );
  }
}





