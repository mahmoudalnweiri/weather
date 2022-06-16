import 'package:flutter/services.dart';
import 'package:location/location.dart';

class MyLocation{
  static bool serviceEnabled = false;
  static PermissionStatus? permissionGranted;
  static LocationData? locationData;

  static Future<void> checkLocationServicesInDevice() async{
    Location location = Location();

    serviceEnabled = await location.serviceEnabled();

    if(serviceEnabled){

      permissionGranted = await location.hasPermission();

      if(permissionGranted == PermissionStatus.granted){

        print('user allowed before');

        locationData = await location.getLocation();

        print(locationData!.latitude.toString() + ' ' + locationData!.longitude.toString());

        /*location.onLocationChanged.listen((LocationData myLocation) {
          print(myLocation.latitude.toString() + ' ' + myLocation.longitude.toString());
        });*/

      }else{
        permissionGranted = await location.requestPermission();

        if(permissionGranted == PermissionStatus.granted){

          print('user allowed');

          locationData = await location.getLocation();

          print(locationData!.latitude.toString() + ' ' + locationData!.longitude.toString());

        }else{

          SystemNavigator.pop();

        }
      }
    }else{

      serviceEnabled = await location.requestService();

      if(serviceEnabled){

        permissionGranted = await location.hasPermission();

        if(permissionGranted == PermissionStatus.granted){

          print('user allowed before');

          locationData = await location.getLocation();

          print(locationData!.latitude.toString() + ' ' + locationData!.longitude.toString());

        }else{

          permissionGranted = await location.requestPermission();

          if(permissionGranted == PermissionStatus.granted){

            print('user allowed');

            locationData = await location.getLocation();

            print(locationData!.latitude.toString() + ' ' + locationData!.longitude.toString());

          }else{

            SystemNavigator.pop();

          }
        }
      }else{

        SystemNavigator.pop();

      }

    }
  }
}