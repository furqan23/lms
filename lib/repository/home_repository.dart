import 'package:splashapp/data/network/network_api_service.dart';
import 'package:splashapp/res/app_url/app_url.dart';

class HomeRepository {
  final _apiService = NetworkApiService();

  /// HomeDetails
  Future<dynamic> homedetails(
    var data,
  ) async {
    dynamic response = _apiService.postApi(data, AppUrl.courseApi);
    return response;
  }

  ///  coursealbumapi
  Future<dynamic> coursealbum(var data, header) async {
    dynamic response =
        _apiService.postApi(data, headers: header, AppUrl.coursealbum);
    return response;
  }

  /// coursevideo api
  Future<dynamic> coursevideo(var data, header) async {
    dynamic response =
        _apiService.postApi(data, headers: header, AppUrl.videoapi);
    return response;
  }

  /// MyResults Api

  Future<dynamic> getMyTestAPI(header) async {
    dynamic response = _apiService.getApi(headers: header, AppUrl.getMyResult1);
    return response;
  }

  Future<dynamic> getresultsApi(var data, header) async {
    dynamic response =
    _apiService.postApi(data, headers: header, AppUrl.getMyResultsTestApi);
    return response;
  }

  /// My Test Data
  Future<dynamic> getMyCoursesAPI(header) async {
    dynamic response =
        _apiService.getApi(AppUrl.getGroupsText, headers: header);
    return response;
  }

  Future<dynamic> getdropapi() async {
    dynamic response =
        _apiService.getApi("http://167.71.58.227/api/v1/governorates");
    return response;
  }
}
