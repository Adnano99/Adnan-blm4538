import 'dart:convert';
import 'package:adnan_kashlan/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key key}) : super(key: key);

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  Weather get weather => null;

  set weather(weather) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Scaffold(
              body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot != null) {
              weather = snapshot.data;
              if (weather == null) {
                return const Text("Error getting weather");
              } else {
                return weatherBox(weather);
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(),
        ),
      ))),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(children: <Widget>[
      Text("${_weather.temp}°C"),
      Text(_weather.description),
      Text("Feels:${_weather.feelsLike}°C"),
      Text("H:${_weather.high}°C L:${_weather.low}°C"),
    ]);
  }

  Future getCurrentWeather() async {
    Weather weather;
    String city = "ankara";
    String apiKey = "782f22d48fa0884f554332651b5ba12c";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {}

    return weather;
  }
}
