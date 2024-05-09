import 'dart:developer';

import 'package:get/get.dart';
import 'package:splashapp/data/response/status.dart';
import 'package:splashapp/model/album_model.dart';
import 'package:splashapp/repository/home_repository.dart';

class AlbumController extends GetxController {
  final _api = HomeRepository();
  Rx<List<Data>?> album = Rx<List<Data>?>([]);
  final reRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => reRequestStatus.value = _value;

  void setcategoryMod(List<Data> _value) => album.value = _value;

  Future<void> courseAlbumApi(String course_id, String token) async {
    var header = {
      'Authorization': 'Bearer $token',
    };
    var data = {
      "course_id": course_id,
    };
    try {
      setRxRequestStatus(Status.LOADING);
      await _api.coursealbum(data, header).then((value) {
        // log(value['data'].toString() + " my data");
        if (value['success'].toString() == 'true') {
          //  log('success');
          AlbumModel categoriesModel = AlbumModel.fromJson(value);
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