import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    void getLocation() async {
      Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF3C3C3C)),
          ),
          onPressed: () {
            getLocation();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Get Location',style: TextStyle(fontSize: 30),),
          ),
        ),
      ),

    );
  }
}
