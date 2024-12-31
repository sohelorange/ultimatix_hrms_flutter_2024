import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ultimatix_hrms_flutter/api/dio_client.dart';
import 'package:ultimatix_hrms_flutter/app/app_colors.dart';
import 'package:ultimatix_hrms_flutter/app/app_snack_bar.dart';
import 'package:ultimatix_hrms_flutter/app/app_url.dart';
import 'package:ultimatix_hrms_flutter/screen/geofence/geo_location_record_model.dart';
import 'package:ultimatix_hrms_flutter/utility/preference_utils.dart';

class GeofenceController extends GetxController {
  RxBool isLoading = true.obs;
  final marker = <Marker>{}.obs;// Observable set of markers
  var circles = <Circle>{}.obs;
  RxInt radius = 0.obs;
  RxDouble distance = 0.0.obs;
  RxBool isWithinRadius = false.obs;
  RxString userImageUrl = "".obs;

  // Define current location
  final currentPosition = LatLng(0.0, 0.0).obs; // Observable current position
  late GoogleMapController mapController;

  Rx<GeoLocationrecordList> geolocationrecordmodel = GeoLocationrecordList().obs;


  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();

    Map<String, dynamic> loginData = PreferenceUtils.getLoginDetails();
    userImageUrl.value = loginData['image_Name'] ?? '';

    // distance.value = calculateDistance(
    //     currentPosition.value,LatLng(23.105404, 72.5563849));



  }

  // Method to set GoogleMapController
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getCurrentLocation() async {
    isLoading.value =true;
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return; // Permission denied
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = LatLng(position.latitude, position.longitude);
      print("Lat: ${position.latitude}, Lng: ${position.longitude}");
      // Add a marker at the current location
      addMarker(currentPosition.value);

      mapController.animateCamera(CameraUpdate.newLatLngZoom(currentPosition.value, 17));

      // double distance= calculateDistance(currentPosition.value,LatLng(23.105404, 72.5563849));


    } catch (e) {
      print("Error getting location: $e");
    }finally{
      isLoading.value =false;

    }
  }

  void addMarker(LatLng position) {
    marker.clear(); // Remove previous markers
    marker.add(
      Marker(
        markerId: MarkerId("current_location"),
        position: position,
        infoWindow: InfoWindow(title: "You are here"),
      ),
    );
    // _addMarkersAndCircles();
    ongeolocartionrecordsAPI();
    update();
  }

  // void _addMarkersAndCircles() {
  //   // List of locations
  //   final locations = [
  //     LatLng(23.115404, 72.5663849), // San Francisco
  //     LatLng(23.105504, 72.5563849), // Los Angeles
  //     LatLng(23.115504, 72.5663849), // Las Vegas
  //   ];
  //
  //   // Add markers and circles for each location
  //   for (var i = 0; i < locations.length; i++) {
  //     final location = locations[i];
  //
  //     marker.add(
  //       Marker(
  //         markerId: MarkerId('marker_$i'),
  //         position: location,
  //         infoWindow: InfoWindow(
  //           title: 'Location $i',
  //           snippet: 'Lat: ${location.latitude}, Lng: ${location.longitude}',
  //         ),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
  //       ),
  //     );
  //
  //     circles.add(
  //       Circle(
  //         circleId: CircleId('circle_$i'),
  //         center: location,
  //         radius: radius.value, // Radius in meters
  //         fillColor: AppColors.color7B1FA2.withOpacity(0.3),
  //         strokeColor: AppColors.colorAppPurple,
  //         strokeWidth: 2,
  //       ),
  //     );
  //     checkIfInsideCircle(currentPosition.value.latitude,currentPosition.value.longitude);
  //   }
  // }

  void checkIfInsideCircle(double currentLat, double currentLng) {
    double distance = Geolocator.distanceBetween(
      currentPosition.value.latitude,currentPosition.value.longitude,
      double.parse(geolocationrecordmodel.value.data![0].latitude!), double.parse(geolocationrecordmodel.value.data![0].longitude!),
    );

    // Update the observable based on the condition
    isWithinRadius.value = distance <= radius.value;

    print('Calculkate distance ${distance}, ${radius.value},${isWithinRadius.value}');

  }

  Future<void> ongeolocartionrecordsAPI() async {
    try {
      // isLoading.value = true;

      // Map<String, dynamic> requestParam = {
      //   "month": month,
      //   "year": year,
      //   "empId": 0,
      //   "cmpId": 0
      // };

      var response = await DioClient().getQueryParam(AppURL.geolocationrecords);
      debugPrint("res --$response");

      geolocationrecordmodel.value = GeoLocationrecordList.fromJson(response);

      if(geolocationrecordmodel.value.code == 200 && geolocationrecordmodel.value.status == true) {

        geolocationrecordmodel.value.data!.forEach((element){
          marker.add(
            Marker(
              markerId: MarkerId('marker_'),
              position: LatLng(double.parse(element.latitude!), double.parse(element.longitude!)),
              infoWindow: InfoWindow(
                title: 'Location',
                // snippet: 'Lat: ${location.latitude}, Lng: ${location.longitude}',
              ),
            ),
          );

          radius.value = element.meter!;
          debugPrint("geo meter --${radius.value}");

          circles.add(
            Circle(
              circleId: CircleId('circle_'),
              center: LatLng(double.parse(element.latitude!), double.parse(element.longitude!)),
              radius: element.meter!.toDouble(), // Radius in meters
              fillColor: AppColors.color7B1FA2.withOpacity(0.3),
              strokeColor: AppColors.colorAppPurple,
              strokeWidth: 2,
            ),
          );
        });
        debugPrint("geo record --${response}");

      } else{
        AppSnackBar.showGetXCustomSnackBar(message: "${geolocationrecordmodel.value.message}" );
      }
    } catch (e) {
      debugPrint("Login catch --$e");
    } finally {
      // isLoading.value = false;
    }
  }

}