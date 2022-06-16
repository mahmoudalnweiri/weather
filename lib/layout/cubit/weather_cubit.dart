import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/layout/cubit/weather_states.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/shared/remote/dio_helper.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(InitialState());

  static WeatherCubit get(context) => BlocProvider.of(context);

  WeatherModel? weatherModel;
  String cityName = 'Gaza';

  void getWeatherState({String latitude = '0', String longitude = '0'}) {
    emit(GetWeatherLoadingState());

    if(latitude == '0' && longitude == '0'){
      DioHelper.getData(
        url: 'data/2.5/weather',
        query: {
          'q': cityName,
          'units': 'metric',
          'appid': 'cc4362a0e9908a965d8c36c948617295',
        },
      ).then((value){
        weatherModel = WeatherModel.fromJson(value.data);
        emit(GetWeatherSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(GetWeatherErrorState(error.toString()));
      });
    } else {
      DioHelper.getData(
        url: 'data/2.5/weather',
        query: {
          'lat': latitude,
          'lon': longitude,
          'appid': 'cc4362a0e9908a965d8c36c948617295',
        },
      ).then((value){
        weatherModel = WeatherModel.fromJson(value.data);
        cityName = value.data['name'];
        emit(GetWeatherSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(GetWeatherErrorState(error.toString()));
      });
    }
  }

  // Get Your Location

  /*bool serviceEnabled = false;
  PermissionStatus? permissionGranted;
  LocationData? locationData;

  Future<void> getNyLocation() async{
    Location location = Location();

    serviceEnabled = await location.serviceEnabled();

    if(serviceEnabled){

      permissionGranted = await location.hasPermission();

      if(permissionGranted == PermissionStatus.granted){

        print('user allowed before');

        locationData = await location.getLocation();

        print(locationData!.latitude.toString() + ' ' + locationData!.longitude.toString());

        getWeatherState(latitude: locationData!.longitude.toString(), longitude: locationData!.latitude.toString());

        *//*location.onLocationChanged.listen((LocationData myLocation) {
          print(myLocation.latitude.toString() + ' ' + myLocation.longitude.toString());
        });*//*

      }else{
        permissionGranted = await location.requestPermission();

        if(permissionGranted == PermissionStatus.granted){

          print('user allowed');

          locationData = await location.getLocation();

          print(locationData!.latitude.toString() + ' ' + locationData!.longitude.toString());

          getWeatherState(latitude: locationData!.latitude.toString(), longitude: locationData!.longitude.toString());

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

          getWeatherState(latitude: locationData!.latitude.toString(), longitude: locationData!.longitude.toString());

        }else{

          permissionGranted = await location.requestPermission();

          if(permissionGranted == PermissionStatus.granted){

            print('user allowed');

            locationData = await location.getLocation();

            print(locationData!.latitude.toString() + ' ' + locationData!.longitude.toString());

            getWeatherState(latitude: locationData!.latitude.toString(), longitude: locationData!.longitude.toString());

          }else{

            SystemNavigator.pop();

          }
        }
      }else{

        SystemNavigator.pop();

      }

    }
  }*/
}
