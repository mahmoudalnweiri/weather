import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/layout/cubit/weather_cubit.dart';
import 'package:weather/layout/weather_layout.dart';
import 'package:weather/shared/observer/my_observer.dart';
import 'package:weather/shared/remote/dio_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..getWeatherState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: WeatherLayout(),
      ),
    );
  }
}
