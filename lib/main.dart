import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:selfie_camera/selfie_camera.dart';
import 'package:ultimatix_hrms_flutter/database/database_helper.dart';
import 'package:ultimatix_hrms_flutter/utility/constants.dart';
import 'package:ultimatix_hrms_flutter/utility/network.dart';
import 'package:ultimatix_hrms_flutter/utility/utils.dart';
import 'app/app_class.dart';
import 'app/app_colors.dart';
import 'app/app_routes.dart';
import 'app/app_snack_bar.dart';
import 'app/app_theme_controller.dart';
import 'app/app_url.dart';
import 'database/location_entity.dart';
import 'database/ultimatix_dao.dart';
import 'firebase_options.dart';
import 'utility/preference_utils.dart';
import 'package:http/http.dart' as http;

late UltimatixDao localDao;

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

  initDbWithLocationTrackService();
  await SelfieCamera.initialize(isLog: true);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppThemeController(),
      child: const MyApp(),
    ),
  );
}

void initDbWithLocationTrackService() async {
  localDao = await DatabaseHelper.localDao;

  await getAllLocationTrackingRecords().then(
    (value) {
      syncAllGeoLocationRecord();
    },
  );
  await initializeService();
}

const notificationChannelId = 'my_foreground';
const notificationId = 888;

Future<void> initializeService() async {
  await checkGpsEnabled();

  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId, // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
          onStart: onStartOne,
          autoStart: true,
          notificationChannelId: notificationChannelId,
          /*initialNotificationTitle: 'AWESOME SERVICE',
          initialNotificationContent: 'Initializing',*/
          foregroundServiceNotificationId: notificationId,
          isForegroundMode: true,
          autoStartOnBoot: true));

  await service.startService();
}

late Timer timer;
ValueNotifier<bool> loginStatus = ValueNotifier<bool>(false);

void onStartOne(ServiceInstance service) async {
  log("OnStart Method");
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
      log("**Service set As Foreground**");
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
      log("**Service set As Background**");
    });

    service.on('stopService').listen((event) async {
      timer.cancel();
      service.stopSelf();
      log("**Service is stop**");
    });

    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      log("Service running****");

      PreferenceUtils.init();
      PreferenceUtils.reload();
      loginStatus.value = PreferenceUtils.getIsLogin();

      log("+Main+ login status is:${loginStatus.value}");

      if (!loginStatus.value) {
        return;
      }

      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: "Locate ME", content: "Updated at${DateTime.now()}");
        try {
          insertDataToStorage();
        } catch (e) {
          e.printError(info: "Getting Error while collecting locations");
        }
      }
    });
  }
}

getSwitchState() {}

void insertDataToStorage() async {
  LocationPermission permission = await Geolocator.checkPermission();
  bool gpsEnabled = await Geolocator.isLocationServiceEnabled();

  if (permission != LocationPermission.always || !gpsEnabled) {
    checkGpsEnabled();
  } else {
    if (await Network.isConnected()) {
      await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best, // Use LocationSettings for accuracy
        //distanceFilter:
        //100, // Optional: minimum distance (in meters) to move before updates
      )).then(
        (value) {
          addGeoLocationByAPICall(
              value.latitude, value.longitude, value.accuracy);
        },
      );
    } else {
      await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best, // Use LocationSettings for accuracy
        //distanceFilter:
        //100, // Optional: minimum distance (in meters) to move before updates
      )).then(
        (value) {
          localDao.insertLocations(LocationEntity(
              latitude: value.latitude,
              longitude: value.longitude,
              dateTime: DateTime.now().toString(),
              gpsOff: false));
        },
      );
    }
  }
}

Future<void> checkGpsEnabled() async {
  checkLocationPermission();
  bool gpsEnabled = await Geolocator.isLocationServiceEnabled();
  if (!gpsEnabled) {
    Geolocator.openLocationSettings();
  }
}

Future<void> checkLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission != LocationPermission.always) {
    AppSnackBar.showGetXCustomSnackBar(
        message: 'Allow location all time in permission');
    openAppSettings();
  }
}

void syncAllGeoLocationRecord() async {
  if (localGeoLocationList!.isNotEmpty) {
    for (var element in localGeoLocationList!) {
      addGeoLocationByAPICall(element.latitude, element.longitude, 0.0);
    }
  }
}

List<LocationEntity>? localGeoLocationList = [];

Future<void> getAllLocationTrackingRecords() async {
  localGeoLocationList?.clear();
  localGeoLocationList?.addAll(await localDao.getAllRecordsFromDb());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessBackgroundHandle(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> addGeoLocationByAPICall(
    double lat, double lon, double accuracy) async {
  if (await Network.isConnected()) {
    await getAddress(lat, lon);
    await PreferenceUtils.init();

    String gpsAcc = accuracy.toStringAsFixed(1).toString();
    String battery = await getBatteryPercentage();
    String deviceName = await getDeviceName();

    Map<String, dynamic> param = {
      "empID": 0,
      "cmpID": 0,
      "latitude": lat,
      "longitude": lon,
      "trackingDate": DateFormat('dd/MM/yyyy').format(DateTime.now()),
      "address": textPosition.toString().trim(), // Fixed here
      "city": city.toString().trim(),
      "area": area.toString().trim(),
      "battery": "$battery%",
      "gps": "$gpsAcc Meters",
      "imei": PreferenceUtils.getDeviceID(),
      "modelName": deviceName
    };

    await http
        .post(
      Uri.parse(AppURL.addLocations),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': PreferenceUtils.getAuthToken()
      },
      body: jsonEncode(param),
    )
        .then(
      (value) {
        log("Response From Location Service:${value.body}");
      },
    );
  } else {
    AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
  }
}

final Battery _battery = Battery();

Future<String> getBatteryPercentage() async {
  final level = await _battery.batteryLevel;
  return level.toString();
}

Future<String> getDeviceName() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.model.toString();
}

String city = "";
String area = "";
String textPosition = "";

Future<void> getAddress(double latitude, double longitude) async {
  try {
    List<Placemark> address =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = address[0];
    city = place.locality.toString();
    area = place.subLocality.toString();
    textPosition =
        "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";
  } catch (e) {
    e.printError();
  }
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
