// main.dart

// main.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'repository/models/get_resturants_model.dart';
import 'views/home_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    autoDetectLocation();
    super.initState();
  }

  double? long, lat;
  String address = "";
  ApiResponse? apiResponse;

  Future<void> autoDetectLocation() async {
    // ... (unchanged)

    LocationPermission permission = await Geolocator.checkPermission();
    try {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (kDebugMode) {
          print('permissions not given');
        }
        LocationPermission asked = await Geolocator.requestPermission();
      } else {
        Position currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        if (kDebugMode) {
          print('Longitude: ${currentPosition.longitude.toString()}');
          print('Latitude: ${currentPosition.latitude.toString()}');
        }
        setState(() {
          long = currentPosition.longitude;
          lat = currentPosition.latitude;
        });
        // SharedPrefs().setDoubleValue(lat, long);
      }
    } catch (e) {
      print("Error while detecting location manually: $e");
    }

    List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!);
    address = placemarks[4].street! + ", " + placemarks[0].locality!;

    final apiUrl = 'https://theoptimiz.com/restro/public/api/get_resturants';

    final locationData = LocationData(
      lat: lat!,
      lng: long!,
    );

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(locationData.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        apiResponse = ApiResponse.fromJson(jsonResponse);
        print('Response: $jsonResponse');

        for (var restaurant in apiResponse!.data) {
          print('Restaurant ID: ${restaurant.id}');
          print('Name: ${restaurant.name}');
          print('Tags: ${restaurant.tags}');
          print('Rating: ${restaurant.rating}');
          print('Discount: ${restaurant.discount}%');
          print('Primary Image: ${restaurant.primaryImage}');
          print('Distance: ${restaurant.distance} meters\n');
        }

        fetchDetails(); // Call fetchDetails after receiving the API response
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  bool isLoaded = false;

  void fetchDetails() {
    if (apiResponse == null) {
      isLoaded = false;
    } else {
      isLoaded = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isLoaded
            ? HomeUI(
                address: address,
                apiResponse: apiResponse!,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
