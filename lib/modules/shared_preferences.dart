import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  double? _val1;
  double? _val2;

  double? get lat => _val1;
  double? get long => _val2;
  Future<void> setDoubleValue(double lat, double long) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('myDoubleKey1', lat);
    prefs.setDouble('myDoubleKey2', long);
  }

  Future<void> getDoubleValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _val1 = prefs.getDouble('myDoubleKey1');
    _val2 = prefs.getDouble('myDoubleKey2');
  }
}
