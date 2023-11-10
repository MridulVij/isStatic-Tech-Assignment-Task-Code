class LocationData {
  final double lat;
  final double lng;

  LocationData({required this.lat, required this.lng});

  // Convert the LocationData instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class Restaurant {
  final int id;
  final String name;
  final String tags;
  final double rating;
  final int discount;
  final String primaryImage;
  final double distance;

  Restaurant({
    required this.id,
    required this.name,
    required this.tags,
    required this.rating,
    required this.discount,
    required this.primaryImage,
    required this.distance,
  });

  // Factory method to create an instance of Restaurant from JSON
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      tags: json['tags'],
      rating: json['rating'].toDouble(),
      discount: json['discount'],
      primaryImage: json['primary_image'],
      distance: json['distance'].toDouble(),
    );
  }
}

class ApiResponse {
  final String status;
  final String code;
  final List<Restaurant> data;

  ApiResponse({
    required this.status,
    required this.code,
    required this.data,
  });

  // Factory method to create an instance of ApiResponse from JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    // Convert the list of restaurants in the data to a List<Restaurant>
    List<Restaurant> restaurantList = (json['data'] as List)
        .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
        .toList();

    return ApiResponse(
      status: json['status'],
      code: json['code'],
      data: restaurantList,
    );
  }
}
