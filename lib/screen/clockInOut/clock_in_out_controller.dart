import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utility/utils.dart';


class ClockInOutController extends GetxController with GetSingleTickerProviderStateMixin{

  RxString defaultValue = 'Working From Home'.obs;

  RxList<String> items = <String>[
    'Working From Home',
    'Working From Office',
  ].obs;

  RxBool isCheckIn = false.obs;
  RxBool isLoading = false.obs;
  static RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  RxString userLocAddress = "".obs;

  Rx<File?> selectedImage = Rx<File?>(null);


  @override
  void onInit() {
    WidgetsFlutterBinding.ensureInitialized();
    /*getBgGeoLocation();*/
    super.onInit();
  }

  void checkInOutEvent() async{
    selectedImage.value?.absolute.delete();
    var image = await Utils.pickImage(source: ImageSource.camera,cameraDevice: CameraDevice.front);
    if(image!=null){
      selectedImage.value = File(image.path);
      isCheckIn.value = !isCheckIn.value;
    }
  }

  void getBgGeoLocation() async{
    var receivePort= ReceivePort();

    receivePort.listen((message) {
      if(message!=null) {
        userLocAddress.value = message;
        log(message);
      }else{
        userLocAddress.value = "Address not found";
        log("Data getting null");
      }
    },);

    if(await Geolocator.isLocationServiceEnabled()){
      var rootToken = RootIsolateToken.instance!;
      await Isolate.spawn<_IsolateData>(_getAddressByLoc, _IsolateData(token: rootToken, answerPort: receivePort.sendPort,),);
    }
  }

  static void _getAddressByLoc(_IsolateData isolateData) async{
    try{
      BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);
      var geoLocation = await Geolocator.getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation));
      List<Placemark> address = await placemarkFromCoordinates(geoLocation.latitude, geoLocation.longitude);
      if(address.isNotEmpty){
        Placemark place = address[0];
        isolateData.answerPort.send("${place.name}, ${place.street}, ${place.subLocality}, ${place
            .thoroughfare}, ${place.locality}, ${place
            .administrativeArea}, ${place.country}, ${place.postalCode}");
      }
    }catch(e){
      e.printError();
    }
  }

}

class _IsolateData {
  final RootIsolateToken token;
  final SendPort answerPort;

  _IsolateData({required this.token, required this.answerPort,});
}