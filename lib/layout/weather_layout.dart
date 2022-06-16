import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/layout/cubit/weather_cubit.dart';
import 'package:weather/layout/cubit/weather_states.dart';
import 'package:weather/modules/clear.dart';
import 'package:weather/modules/clouds.dart';
import 'package:weather/modules/default_weather.dart';
import 'package:weather/modules/haze.dart';
import 'package:weather/modules/humidity.dart';
import 'package:weather/modules/main_weather.dart';
import 'package:weather/modules/rain.dart';
import 'package:weather/modules/wind_speed.dart';

class WeatherLayout extends StatelessWidget {
  WeatherLayout({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return WeatherCubit.get(context).weatherModel != null ? SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    color: Colors.blue.shade400,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8, left: 10),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 25),
                            SizedBox(
                              width: 200,
                              height: 70,
                              child: TextField(
                                controller: searchController,
                                onSubmitted: (value) {
                                  if(!RegExp(r'^[ ]*$').hasMatch(value)){
                                    WeatherCubit.get(context).cityName = value;
                                    WeatherCubit.get(context).getWeatherState();
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Enter city name',
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  isDense: true,
                                ),
                                textCapitalization: TextCapitalization.sentences,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, right: 10),
                          child: Icon(
                            Icons.more_vert_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.lightBlue,
                          Colors.blue,
                          Colors.blueAccent
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(children: [
                        SizedBox(
                          height: 220,
                          child: WeatherCubit.get(context)
                                      .weatherModel!
                                      .mainWeather ==
                                  'Rain'
                              ? const Rain()
                              : WeatherCubit.get(context)
                                          .weatherModel!
                                          .mainWeather ==
                                      'Clear'
                                  ? const Clear()
                                  : WeatherCubit.get(context)
                                              .weatherModel!
                                              .mainWeather ==
                                          'Haze'
                                      ? const Haze()
                                      : const DefaultWeather(), //display image according to Weather
                        ),
                        Text(
                          WeatherCubit.get(context).weatherModel!.temp! +
                              '\u00B0',
                          // u00B0 is unicode for degree symbol
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          WeatherCubit.get(context).weatherModel!.description!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Location: " + WeatherCubit.get(context).cityName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Column(
                    children: const [
                      MainWeather(),
                      Clouds(),
                      Humidity(),
                      WindSpeed(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) : Center(child: CircularProgressIndicator(color: Colors.grey.shade900,),);
      },
    );
  }
}
