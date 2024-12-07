import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'app/app_class.dart';
import 'app/app_colors.dart';
import 'app/app_routes.dart';
import 'app/app_theme_controller.dart';
import 'firebase_options.dart';
import 'utility/preference_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessBackgroundHandle);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  PreferenceUtils.setAppUrl('http://192.168.1.200:8080/');
  PreferenceUtils.setAuthToken('Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJMb2dpbl9JRCI6IjIxNzc2IiwiQ21wX0lEIjoiMTg3IiwiRW1wX0lEIjoiMjgyMDEiLCJEZXB0X0lEIjoiNTA1IiwiQWxwaGFfRW1wX0NvZGUiOiIwMDYwIiwiRW1wX0Z1bGxfTmFtZSI6IjAwNjAgLSBNci4gQVAgVEwgUUExMjMiLCJEZXB0X05hbWUiOiJTb2Z0d2FyZSIsIkRlc2lnTmFtZSI6IlNyLiBRQSBUZXN0ZXIiLCJEZXZpY2VUb2tlbiI6InN0cmluZyIsIm5iZiI6MTczMzQ4NjkwNSwiZXhwIjoxNzM2MDc4OTA1LCJpYXQiOjE3MzM0ODY5MDV9.tCSsg4YEaxVK-sEFU2_Nf1Eb8NzTGKUP2DHSel-DWmw');

  //isBiometricAvailable();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppThemeController(),
      child: const MyApp(),
    ),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessBackgroundHandle(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.lightBackground,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //themeMode: ThemeMode.light,
        theme: Provider.of<AppThemeController>(context).currentTheme,
        //theme: ThemeData(
        //  useMaterial3: true,
        //  appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
        //),
        builder: (context, widget) => NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: getMainAppViewBuilder(context, widget),
        ),
        enableLog: true,
        locale: Get.deviceLocale,
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
      ),
    );
  }
}*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<AppThemeController>(context).currentTheme,
      enableLog: true,
      locale: Get.deviceLocale,
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
    );
  }
}

/// Create main app view builder
Widget getMainAppViewBuilder(BuildContext context, Widget? widget) {
  return Stack(
    children: [
      Obx(
        () {
          return IgnorePointer(
            ignoring: AppClass().isShowLoading.isTrue,
            child: Stack(
              children: [
                widget ?? const Offstage(),
                if (AppClass()
                    .isShowLoading
                    .isTrue) // Top level loading ( used while api calls)
                  ColoredBox(
                    color: AppColors.colorBlack.withOpacity(0.6),
                    child: Center(child: Utils.commonCircularProgress()),
                  ),
              ],
            ),
          );
        },
      )
    ],
  );
}
