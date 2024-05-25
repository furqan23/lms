import 'dart:developer';

import 'package:get/get.dart';
import 'package:splashapp/data/response/status.dart';
import 'package:splashapp/model/my_courses_model.dart';
import 'package:splashapp/repository/home_repository.dart';

class MyCourseController extends GetxController {
  final _api = HomeRepository();
  Rx<List<Data>?> coursedata = Rx<List<Data>?>([]);
  final reRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => reRequestStatus.value = _value;

  void setcategoryMod(List<Data> _value) => coursedata.value = _value;

  Future<void> mycoursesApi(String token) async {
    var header = {
      'Authorization': 'Bearer $token',
    };

    try {
      setRxRequestStatus(Status.LOADING);
      await _api.getMyCourseAPI(header).then((value) {
        // log(value['data'].toString() + " my data");
        if (value['success'].toString() == 'true') {
          //  log('success');
          MyCoursesModel coursesModel = MyCoursesModel.fromJson(value);
          setcategoryMod(coursesModel.data!);
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
