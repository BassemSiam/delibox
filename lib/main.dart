import 'package:delibox/components/Notification_helper.dart';
import 'package:delibox/components/cash_helper.dart';
import 'package:delibox/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/components.dart';
import 'components/const.dart';
import 'components/splash_screen.dart';
import 'generated/l10n.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  // SharedPreferences.setMockInitialValues({});
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var uId = await CacheHelper.getData(key: 'uId');

  var language = await CacheHelper.getData(key: 'lang');

  print(language);
  // NotificationsHelper notificationsHelper = NotificationsHelper();
  // await notificationsHelper.initNotifications();
  // String? accesstoken = await notificationsHelper.getAccessToken();



  getUserData(sendUid: uId);

  String lang;

  if (language == 'ENG') {
    lang = 'en';
  } else if (language == 'AR') {
    lang = 'ar';
  } else {
    lang = 'ar';
  }

  final Connectivity connectivity = Connectivity();
  connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      // Show no internet connection message
      runApp(const NoInternetApp());
    } else {
      runApp(MyApp(
        selectLan: lang,
      ));
    }
  });
  // Check internet connection
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    // Show no internet connection message
    runApp(const NoInternetApp());
  } else {
    // Run the app
    runApp(MyApp(
      selectLan: lang,
    ));
  }
}

class NoInternetApp extends StatefulWidget {
  const NoInternetApp({super.key});

  @override
  State<NoInternetApp> createState() => _NoInternetAppState();
}

class _NoInternetAppState extends State<NoInternetApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, child) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NoInternetScreen(),
      );
    });
  }
}

class MyApp extends StatelessWidget {
  final String selectLan;
  const MyApp({
    super.key,
    required this.selectLan,
  });
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'DeliBox',
            locale: Locale(selectLan),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              colorScheme:
                  Theme.of(context).colorScheme.copyWith(primary: blueColor),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 35,
                ),
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
