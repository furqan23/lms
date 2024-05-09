import 'dart:developer';
import 'package:get/get.dart';
import 'package:splashapp/data/response/status.dart';
import 'package:splashapp/model/get_groups_model.dart';
import 'package:splashapp/repository/home_repository.dart';

class MygroupController extends GetxController {
  final _api = HomeRepository();
  Rx<List<Data>?> groupmodel = Rx<List<Data>?>([]);
  final reRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => reRequestStatus.value = _value;

  void setcategoryMod(List<Data> _value) => groupmodel.value = _value;

  Future<void> getMyCourseAPI(String token) async {
    var header = {
      'Authorization': 'Bearer $token', // Use the retrieved token
      'Content-Type': 'application/json',
    };

    try {
      setRxRequestStatus(Status.LOADING);
      await _api.getMyCoursesAPI(header).then((value) {
        // log(value['data'].toString() + " my data");
        if (value['success'].toString() == 'true') {
          //  log('success');
          GetGroupsModel groups = GetGroupsModel.fromJson(value);
          setcategoryMod(groups.data!);
          //    log(categories.value!.length.toString() + " my list");
          setRxRequestStatus(Status.COMPLETED);
        } else {
          //  log('error');
          setRxRequestStatus(Status.ERROR);
        }
      }).onError((error, stackTrace) {
        setRxRequestStatus(Status.ERROR);
        log('Error fetching home details: $error');
      });
    } catch (e) {
      log('Exception caught: $e');
      setRxRequestStatus(Status.ERROR);
    }
  }
}
