import 'dart:developer';

import 'package:get/get.dart';
import 'package:splashapp/data/response/status.dart';
import 'package:splashapp/model/video_model.dart';
import 'package:splashapp/repository/home_repository.dart';

class MyCourseController extends GetxController {
  final _api = HomeRepository();
  Rx<List<Data>?> categories = Rx<List<Data>?>([]);
  final reRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => reRequestStatus.value = _value;

  void setcategoryMod(List<Data> _value) => categories.value = _value;

  Future<void> categoryApi(String album_id, String token) async {
    var header = {
      'Authorization': 'Bearer $token',
    };
    var data = {
      "album_id": album_id,
    };
    try {
      setRxRequestStatus(Status.LOADING);
      await _api.coursedetails(data, header).then((value) {
        // log(value['data'].toString() + " my data");
        if (value['success'].toString() == 'true') {
          //  log('success');
          VideoModel categoriesModel = VideoModel.fromJson(value);
          setcategoryMod(categoriesModel.data!);
          //    log(categories.value!.length.toString() + " my list");
          setRxRequestStatus(Status.COMPLETED);
        } else {
          //  log('error');
          setRxRequestStatus(Status.ERROR);
        }
      }).onError((error, stackTrace) {
        setRxRequestStatus(Status.ERROR);
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
