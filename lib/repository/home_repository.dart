import 'package:splashapp/data/network/network_api_service.dart';
import 'package:splashapp/res/app_url/app_url.dart';

class HomeRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> coursedetails(var data, header) async {
    dynamic response =
        _apiService.postApi(data, headers: header, AppUrl.videoapi);
    return response;
  }
}
