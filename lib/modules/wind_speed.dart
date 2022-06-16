import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/layout/cubit/weather_cubit.dart';
import 'package:weather/layout/cubit/weather_states.dart';

class WindSpeed extends StatelessWidget {
  const WindSpeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/wind.png',
                          fit: BoxFit.cover)),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text('Wind Speed',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Text(
                WeatherCubit.get(context).weatherModel!.windSpeed!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
