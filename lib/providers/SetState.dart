import 'package:flutter/foundation.dart';

class SetState extends ChangeNotifier {
  bool isLoaded = false;
  void setStates(bool apiResponse) {
    if (apiResponse) {
      isLoaded = true;
    } else {
      isLoaded = false;
    }
    notifyListeners();
  }
}
