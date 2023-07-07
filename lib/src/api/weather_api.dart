import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_towin/src/modelclass/class_weather.dart';

class WeatherApi {
  Future<Weather>? getCurrentWeather(double? lat, double? lng) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&exclude=current,hourly,minutely,alerts&units=metric&appid=28b277c358cc5ce823f5ffc244d35f3d");

    var resposne = await http.get(endpoint);
    var body = jsonDecode(resposne.body);

    return Weather.fromJson(body);
  }
}
