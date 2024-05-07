import 'package:splashapp/data/network/network_api_service.dart';
import 'package:splashapp/res/app_url/app_url.dart';

class AuthRepository {
  final _apiService = NetworkApiService();

  Future<dynamic> forgetApi(var data) async {
    dynamic response = _apiService.postApi(data, AppUrl.forgetapi);
    return response;
  }

  Future<dynamic> otpApi(var data) async {
    dynamic response = _apiService.postApi(data, AppUrl.otpapi);
    return response;
  }

  Future<dynamic> signupApi(var data) async {
    dynamic response = _apiService.postApi(data, AppUrl.signupapi);
    return response;
  }
}
