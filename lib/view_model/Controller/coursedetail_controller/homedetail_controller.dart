import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashapp/data/response/status.dart';
import 'package:splashapp/model/cart_model.dart';
import 'package:splashapp/model/course_model.dart';
import 'package:splashapp/repository/home_repository.dart';

class HomeDetailsController extends GetxController {
  final _api = HomeRepository();
  Rx<List<Data>?> coursemodel = Rx<List<Data>?>([]);
  final reRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => reRequestStatus.value = _value;

  void setcategoryMod(List<Data> _value) => coursemodel.value = _value;

  Future<void> homedetailsApi(
    String category_id,
  ) async {
    var data = {
      "category_id": category_id,
    };
    try {
      setRxRequestStatus(Status.LOADING);
      await _api.homedetails(data).then((value) {
        // log(value['data'].toString() + " my data");
        if (value['success'].toString() == 'true') {
          //  log('success');
          CourseModel courseModel = CourseModel.fromJson(value);
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

  List<CartModel> cartList = [];
  Future<void> saveCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = cartList.map((cart) => cart.toJson()).toList();
    await prefs.setString('cartData', json.encode(cartData));
    print("Cart data saved successfully.");
  }

  Future<void> loadCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartDataJson = prefs.getString('cartData');
    if (cartDataJson != null) {
      final cartData = json.decode(cartDataJson) as List<dynamic>;
      cartList = cartData.map((json) => CartModel.fromJson(json)).toList();
    }
  }
}
