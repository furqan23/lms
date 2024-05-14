import 'dart:developer';
import 'package:get/get.dart';
import 'package:splashapp/data/response/status.dart';
import 'package:splashapp/model/governorates_model.dart';
import 'package:splashapp/repository/home_repository.dart';

class DropController extends GetxController {
  final _api = HomeRepository();
  Rx<List<GovernoratesData>?> coursemodel = Rx<List<GovernoratesData>?>([]);
  final reRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => reRequestStatus.value = _value;

  void setcategoryMod(List<GovernoratesData> _value) =>
      coursemodel.value = _value;

  Future<void> homedetailsApi() async {
    try {
      setRxRequestStatus(Status.LOADING);
      await _api.getdropapi().then((value) {
        // log(value['data'].toString() + " my data");
        if (value['success'].toString() == 'true') {
          //  log('success');
          GovernoratesModel courseModel = GovernoratesModel.fromJson(value);
          setcategoryMod(courseModel.data!);
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
