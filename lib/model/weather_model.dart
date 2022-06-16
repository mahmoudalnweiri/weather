class WeatherModel {
  String? temp;
  String? description;
  String? mainWeather;
  String? humidity;
  String? windSpeed;
  String? clouds;

  WeatherModel({
    this.temp,
    this.description,
    this.mainWeather,
    this.humidity,
    this.windSpeed,
    this.clouds,
  });

  WeatherModel.fromJson(Map<String, dynamic> json){
    temp = json['main']['temp'].toString();
    description = json['weather'][0]['description'];
    mainWeather = json['weather'][0]['main'];
    humidity = json['main']['humidity'].toString();
    windSpeed = json['wind']['speed'].toString();
    clouds = json['clouds']['all'].toString();
  }
}
