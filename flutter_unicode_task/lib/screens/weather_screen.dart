import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // final Future<Map> _weatherData = getWeatherData();
  double lat = 19.017625;
  double lon = 73.019331;
  Future<Map> getWeatherData() async {
    var res = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=5b69af7572403f317446ea7ee5a44813"));
    if (res.statusCode > 201) {
      return {"status": res.statusCode, "message": "Error"};
    }
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: Center(
          child: Column(
            children: [
              Text("Current Latitude: $lat"),
              Text("Current Longitude: $lon"),
              const SizedBox(
                height: 24,
              ),
              FutureBuilder(
                future: getWeatherData(),
                builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('Press the button to fetch weather data');
                  } else {
                    // Display weather data here
                    final weatherData = snapshot.data;
                    return Column(
                      children: [
                        Text("Place: ${weatherData!['name']}"),
                        Text('Temperature: ${weatherData['main']['temp']}'),
                        Text('Humidity: ${weatherData['main']['humidity']}'),
                        Text('Weather: ${weatherData['weather'][0]['main']}'),
                        Text(
                            'Description: ${weatherData['weather'][0]['description']}'),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
