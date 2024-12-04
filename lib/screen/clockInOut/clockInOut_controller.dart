

import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class ClockInOutController extends GetxController with GetSingleTickerProviderStateMixin{

  RxString defaultValue = 'Working From Home'.obs;

  RxList<String> items = <String>[
    'Working From Home',
    'Working From Office',
  ].obs;

  RxBool isCheckIn = false.obs;
  RxBool isLoading = false.obs;
  static RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  String _location = 'Fetching location...';

  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();

    /*getBgGeoLocation();*/
    getMyLocation();

    super.onInit();
  }


  void getBgGeoLocation() async{
    var receivePort= ReceivePort();

    receivePort.listen((message) {
      if(message!=null) {
        print(message);
      }else{
        print("Data getting null");
      }
    },);

    if(await Geolocator.isLocationServiceEnabled()){
      /*await Isolate.spawn(_getGeoLocation, receivePort.sendPort);*/
      var rootToken = RootIsolateToken.instance!;
      await Isolate.spawn<_IsolateData>(
        _getGeoLocation,
        _IsolateData(
          token: rootToken,
          answerPort: receivePort.sendPort,
        ),
      );
    }
  }

  static void _getGeoLocation(/*SendPort sendPort*/ _IsolateData isolateData) async{
    try{
      BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);
      var geoLocation = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation));
      isolateData.answerPort.send(geoLocation);
    }catch(e){
      e.printError();
    }
  }

  Future<void> getMyLocation() async{
    var location = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation));
    print("This is location:${location.latitude}");
  }

}

class _IsolateData {
  final RootIsolateToken token;
  final SendPort answerPort;

  _IsolateData({
    required this.token,
    required this.answerPort,
  });
}