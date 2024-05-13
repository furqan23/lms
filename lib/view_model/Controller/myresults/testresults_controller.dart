import 'dart:developer';

import 'package:get/get.dart';
import 'package:splashapp/data/response/status.dart';
import 'package:splashapp/model/mytest_results_model.dart';

import '../../../repository/home_repository.dart';

class TestResultsController extends GetxController {
  final _api = HomeRepository();
  Rx<List<Data>?> getmyresult = Rx<List<Data>?>([]);
  final reRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => reRequestStatus.value = _value;

  void setcategoryMod(List<Data> _value) => getmyresult.value = _value;

  Future<void> getresultsApi(course_id, String token) async {
    var header = {
      'Authorization': 'Bearer $token',
    };
    var data = {
      "course_id": course_id,
    };
    try {
      setRxRequestStatus(Status.LOADING);
      await _api.getresultsApi(data, header).then((value) {
        // log(value['data'].toString() + " my data");
        if (value['success'].toString() == 'true') {
          //  log('success');
          TestResultModels categoriesModel = TestResultModels.fromJson(value);
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
