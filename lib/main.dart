import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'providers/SetState.dart';
import 'repository/models/get_resturants_model.dart';
import 'views/home_ui.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SetState())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    fetchBoth();
  }

  String address = "";
  ApiResponse? apiResponse;

  Future<List<dynamic>> autoDetectLocation() async {
    // ... your location detection logic
    double? lat, long;
    LocationPermission permission = await Geolocator.checkPermission();
    try {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print('permissions not given');
        LocationPermission asked = await Geolocator.requestPermission();
      } else {
        Position currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        print('Longitude: ${currentPosition.longitude}');
        print('Latitude: ${currentPosition.latitude.toString()}');
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);
        address = placemarks[4].street! + ", " + placemarks[0].locality!;
        lat = currentPosition.latitude;
        long = currentPosition.longitude;
      }
    } catch (e) {
      print(e);
    }

    return [lat, long, address];
  }

// api fetching
  Future<void> fetchData(lat, long) async {
    // ... your API call logic
    final apiUrl = 'https://theoptimiz.com/restro/public/api/get_resturants';

    final locationData = LocationData(
      lat: lat,
      lng: long,
    );

    http.Response response; // Declare the response variable here

    try {
      response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(locationData.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        apiResponse = ApiResponse.fromJson(jsonResponse);
        print('Response: $jsonResponse');

        for (var restaurant in apiResponse!.data) {
          if (kDebugMode) {
            print('Restaurant ID: ${restaurant.id}');
            print('Name: ${restaurant.name}');
            print('Tags: ${restaurant.tags}');
            print('Rating: ${restaurant.rating}');
            print('Discount: ${restaurant.discount}%');
            print('Primary Image: ${restaurant.primaryImage}');
            print('Distance: ${restaurant.distance} meters\n');
          }
        }

        // Call fetchDetails after receiving the API response
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> fetchBoth() async {
    List<dynamic> data = await autoDetectLocation();
    print('${data[0]},${data[1]}, ${data[2]}');
    if (data[0] != null) {
      await fetchData(data[0], data[1]);
      context.read<SetState>().setStates(true);
    }
  }

  void referesh() async {
    // Set isLoaded to false to show shimmer while refreshing
    context.read<SetState>().setStates(false);

    // Fetch data
    await fetchBoth();

    // Set isLoaded to true after data is fetched
    context.read<SetState>().setStates(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SetState>(
      builder: (context, state, child) {
        return MaterialApp(
          home: Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                // Set isLoaded to false to show shimmer while refreshing
                context.read<SetState>().setStates(false);

                // Fetch data
                await fetchBoth();

                // Set isLoaded to true after data is fetched
                context.read<SetState>().setStates(true);
              },
              child: state.isLoaded
                  ? HomeUI(
                      address: address,
                      apiResponse: apiResponse!,
                    )
                  : ShimmerEffect(),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10, // Number of shimmering items
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30.0,
            ),
            title: Container(
              height: 16.0,
              width: double.infinity,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 12.0,
              width: double.infinity,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
