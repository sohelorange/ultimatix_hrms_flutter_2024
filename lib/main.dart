import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
import 'package:path_provider/path_provider.dart';
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

  await clearCache();
  await PreferenceUtils.init();
  await PreferenceUtils.setIsLocateMe(false);

  checkLocations();

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

  await SelfieCamera.initialize(isLog: true);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppThemeController(),
      child: const MyApp(),
    ),
  );
}

void checkLocations() async{
  try {

    isLocateMeTime = Timer.periodic(const Duration(seconds: 2), (timer) async {

      PreferenceUtils.init();
      PreferenceUtils.reload();
      locationStatus.value = PreferenceUtils.getIsLocateMe();

      if (!locationStatus.value) {}
      else{
        initDbWithLocationTrackService();
      }
    });
  }catch(e){
    e.printError();
  }
}

void initDbWithLocationTrackService() async {
  isLocateMeTime.cancel();

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

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

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
          foregroundServiceTypes: [AndroidForegroundType.location],
          autoStartOnBoot: true));

  service.startService();
}

late Timer timer;
ValueNotifier<bool> loginStatus = ValueNotifier<bool>(false);

late Timer isLocateMeTime;
ValueNotifier<bool> locationStatus = ValueNotifier<bool>(false);

@pragma('vm:entry-point')
void onStartOne(ServiceInstance service) async {

  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) async {
      timer.cancel();
      service.stopSelf();
    });

    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {

      PreferenceUtils.init();
      PreferenceUtils.reload();
      loginStatus.value = PreferenceUtils.getIsLogin();

      if (!loginStatus.value) {
        return;
      }

      if (await service.isForegroundService()) {

        flutterLocalNotificationsPlugin.show(
            notificationId,
            "Locate ME",
            "Updated at${DateTime.now()}",
            const NotificationDetails(android: AndroidNotificationDetails(
                notificationChannelId, 'MY FOREGROUND SERVICE',ongoing: true,icon: 'ic_notification'
              )
            )
        );

        service.setForegroundNotificationInfo(
            title: "Locate ME", content: "Updated at${DateTime.now()}");
        insertDataToStorage();
      }

      final deviceInfo = DeviceInfoPlugin();
      String? device;
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        device = androidInfo.model;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        device = iosInfo.model;
      }

      service.invoke(
        'update',
        {
          "current_date": DateTime.now().toIso8601String(),
          "device": device,
        },
      );

    });
  }
}

void stopService(){
  FlutterBackgroundService().invoke("stopService");
}

void insertDataToStorage() async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();
    bool gpsEnabled = await Geolocator.isLocationServiceEnabled();

    if (permission != LocationPermission.always || !gpsEnabled) {
      checkGpsEnabled();
    } else {

      if (await Network.isConnected()) {

        await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.best,
            )).then(
              (value) {

            addGeoLocationByAPICall(
                value.latitude, value.longitude, value.accuracy, false, LocationEntity(latitude: 0.0, longitude: 0.0, dateTime: "", gpsOff: false));
          },
        );
      } else {

        localDao = await DatabaseHelper.localDao;

        await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy
                  .best, // Use LocationSettings for accuracy
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
  }catch(e){
    e.printError();
  }
}

Future<void> checkGpsEnabled() async {
  try {
    checkLocationPermission();
    bool gpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!gpsEnabled) {
      Geolocator.openLocationSettings();
    }
  }catch(e){
    e.printError();
  }
}

Future<void> checkLocationPermission() async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission != LocationPermission.always) {
      openAppSettings();
    }
  }catch(e){
    e.printError();
  }
}

void syncAllGeoLocationRecord() async {
  if (localGeoLocationList!.isNotEmpty) {

    for (var element in localGeoLocationList!) {
      addGeoLocationByAPICall(element.latitude, element.longitude, 0.0, true, element);
    }

  }else{
    deleteAllLocations();
  }
}

void deleteAllLocations() async {
  try {
    await localDao.deleteAllLocations();
  }catch(e){
    e.printError();
  }
}

List<LocationEntity>? localGeoLocationList = [];

Future<void> getAllLocationTrackingRecords() async {
  try {
    localGeoLocationList?.clear();
    localGeoLocationList?.addAll(await localDao.getLocationRecordsFromDb());
  }catch(e){
    e.printError();
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessBackgroundHandle(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> addGeoLocationByAPICall(
    double lat, double lon, double accuracy, bool isList, LocationEntity element) async {
  try {
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
          if (value.statusCode==200) {
            if(isList) {
              localGeoLocationList?.remove(element);
              syncAllGeoLocationRecord();
            }
          }
        },
      );
    } else {
      AppSnackBar.showGetXCustomSnackBar(message: Constants.networkMsg);
    }
  }catch(e){
    e.printError();
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

Future<void> clearCache() async {
  try {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
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
      builder: (context, widget) => NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: getMainAppViewBuilder(context, widget),
      ),
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
                    color: AppColors.colorBlack.withValues(alpha: 0.6),
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

/*Future<void> permissionRequired() async{
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.camera,
    Permission.notification,
    Permission.storage,
  ].request();

  if(statuses[Permission.locationAlways]?.isGranted==true){
    initDbWithLocationTrackService();
  } else {
    permissionRequired();
  }
}*/
