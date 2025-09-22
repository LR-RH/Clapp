import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vibration/vibration.dart';

Future<WeatherInfo> fetchWeather(String location) async {
  final response = await http.get(
      Uri.parse('http://api.weatherapi.com/v1/current.json?key=21dd5d357ee9425893b110036251803&q=$location&aqi=no')
  );

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load weather');
  }
}

class Location {
  String name;
  String country;
  String localtime;

  Location({
    required this.name,
    required this.country,
    required this.localtime
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        name: json['name'],
        country: json['country'],
        localtime: json['localtime']
    );
  }
}

class Condition {
  String text;

  Condition({
    required this.text
  });

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
        text: json['text']
    );
  }
}

class Current {
  double temp_c;
  double temp_f;
  int is_day;
  int cloud;
  Condition condition;
  double wind_mph;

  Current({
    required this.temp_c,
    required this.temp_f,
    required this.is_day,
    required this.cloud,
    required this.condition,
    required this.wind_mph
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
        temp_c: json['temp_c'],
        temp_f: json['temp_f'],
        is_day: json['is_day'],
        cloud: json['cloud'],
        wind_mph: json['wind_mph'],
        condition: Condition.fromJson(json['condition'])
    );
  }
}

class WeatherInfo {
  Location location;
  Current current;

  WeatherInfo({
    required this.location,
    required this.current
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
        location: Location.fromJson(json['location']),
        current: Current.fromJson(json['current'])
    );
  }
}

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  WeatherState createState() => WeatherState();
}

class WeatherState extends State<Weather> {

  late Future<WeatherInfo> futureWeather;
  TextEditingController location = TextEditingController();
  bool showWeather = false;

  void callWeatherApi() {
    Vibration.vibrate(duration: 25);
    setState(() {
      if (location.text.isNotEmpty) {
        futureWeather = fetchWeather(location.text);
        showWeather = true;
      }
    });
  }

  void goBack() {
    Vibration.vibrate(duration: 25);
    setState(() {
      showWeather = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFA7E2E3), Color(0xFF2D728F),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              if (showWeather)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: FutureBuilder<WeatherInfo>(
                        future: futureWeather,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                SizedBox(height: 50),
                                Text(snapshot.data!.location.name, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
                                SizedBox(height: 5),
                                Text(snapshot.data!.location.country, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                                SizedBox(height: 20),
                                Text("${snapshot.data!.current.temp_c}°C", style: TextStyle(fontSize: 85, fontWeight: FontWeight.bold, color: Colors.white)),
                                Text("Condition: ${snapshot.data!.current.condition.text}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                                Text("Wind: ${snapshot.data!.current.wind_mph} MPH", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                                //Image.network(image url)
                                SizedBox(height: 75),
                                ElevatedButton(
                                    onPressed: goBack,
                                    child: Text("Go Back")
                                )
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Column(
                              children: [
                                Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                                SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child:
                                  ElevatedButton(
                                      onPressed: goBack,
                                      child: Text("Go Back")
                                  ),
                                )
                              ],
                            );
                          }
                          return const CircularProgressIndicator();
                        }
                    ),
                  ),
                ),
              if (!showWeather)
                Column(
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: Text(
                        "To view the weather, please enter a location:",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: location,
                          decoration: InputDecoration(
                            labelText: "Location",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: callWeatherApi,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF2D728F),
                        ),
                        child: Text("Enter Location"),
                      ),
                    )

                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}