import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/get_resturants_model.dart';

class API {
  ApiResponse? apiResponse;

// api fetching
  fetchData(lat, long) async {
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
    return apiResponse;
  }
}
