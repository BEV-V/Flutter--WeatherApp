import 'dart:convert';
import 'dart:math';
import 'package:climate_app/screens/location_screen.dart';
import 'package:climate_app/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'ae0c72b4807f6274153caae34390d8ad';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  // @override
  // void initState() {
  //   super.initState();
  //   getLocationData();
  // }

  //CURLING GEOLOCATION-DATA

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    print('longitude');
    print('latitude');

    double? latitude = location.latitude;
    double? longitude = location.longitude;

    if (latitude == null || longitude == null) {
      print('Unable to fetch location data.');
      return;
    }

    var apiUrl =
       Uri.parse( 'https://api.openweathermap.org/data/2.5/'
        'weather?lat=lat&lon=lon&appid=ae0c72b4807f6274153caae34390d8ad');

    NetworkHelper networkHelper = NetworkHelper(apiUrl);
    var weatherData = await networkHelper.getData();

    print('networkHelper');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );
  }

  // void getWeather() async {
  //   String uri = 'https://api.openweathermap.org/data/'
  //       '2.5/weather?lat=44.34&lon=10.99&appid=ae0c72b4807f6274153caae34390d8ad';
  //
  //   Uri apiUrl = Uri.parse(uri);
  //
  //   http.Response response = await http.get(apiUrl);
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     print('Weather Data: $data');
  //   } else {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //  SpinKit Package

        // child: SpinKitDoubleBounce(
        //   color: Colors.white,
        //   size: 100.0,
        // ),

        //Get Location Button
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF3C3C3C)),
          ),
          onPressed: () {
            getLocationData();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Get Location', style: TextStyle(fontSize: 30)),
          ),
        ),
      ),
    );
  }
}
