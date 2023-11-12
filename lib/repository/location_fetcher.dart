import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationFetcher {
  String address = "";
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
}
