import 'package:delibox/Screens/HomeAndUserInfo/Home_screen.dart';
import 'package:delibox/Screens/OnBoarding/onBoarding_Screen.dart';
import 'package:delibox/Screens/User%20Login&Register/Chose_language.dart';
import 'package:delibox/Screens/User%20Login&Register/Login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../Screens/Admin/Show_users_screen.dart';
import 'cash_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      if (!_isMounted) return; // Check if the widget is still mounted

      var login = await CacheHelper.getData(key: 'loggedIn');
      var uId = await CacheHelper.getData(key: 'uId');
      var language = await CacheHelper.getData(key: 'lang');
      var onBording = await CacheHelper.getData(key: 'onBoarding');

      print(login);
      print(uId);
      print(language);
      print(onBording);

      if (language == null) {
        if (_isMounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ChooseLang(),
            ),
          );
        }
      } else if (onBording == null) {
        if (_isMounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoardingScreen(),
            ),
          );
        }
      } else {
        if (login != null) {
          if (uId == 'mOTL1blgW3coJCCI2hCWmKD4mjX2') {
            if (_isMounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShowUsersScreen(),
                ),
              );
            }
          } else {
            if (_isMounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            }
          }
        } else {
          if (_isMounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _isMounted = false; // Set _isMounted to false when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: (MediaQuery.sizeOf(context).height / 12) - 10,
            ),
            SizedBox(
              height: 300.h,
              width: 500.w,
              child: Image.asset('assets/images/bring_rem_logo.png'),
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              height: 80.h,
              width: 80.w,
              child: Lottie.asset(
                  'assets/Animation/Animation - 1714053112413.json',
                  fit: BoxFit.contain,
                  repeat: true),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
