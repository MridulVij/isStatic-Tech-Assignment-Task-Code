import 'api/get_resturants_api.dart';
import 'location_fetcher.dart';
import 'models/get_resturants_model.dart';

class APIDataFetcher {
  ApiResponse? apiResponse;
  Future<List<dynamic>> fetchData() async {
    List<dynamic> data = await LocationFetcher().autoDetectLocation();

    apiResponse = await API().fetchData(data[0], data[1]);
    return [apiResponse, data[2]];
  }
}
