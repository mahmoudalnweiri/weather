abstract class WeatherStates{}

class InitialState extends WeatherStates{}

class GetWeatherLoadingState extends WeatherStates{}

class GetWeatherSuccessState extends WeatherStates{}

class GetWeatherErrorState extends WeatherStates{
  final String error;

  GetWeatherErrorState(this.error);
}