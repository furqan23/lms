// ignore_for_file: deprecated_member_use, non_constant_identifier_names
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:splashapp/model/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/widget/lsit.dart';
import '../../model/cart_model.dart';
import '../../values/auth_api.dart';
import '../cart/cart.dart';

class HomeDetail extends StatefulWidget {
  final String mscatId;

  const HomeDetail({
    Key? key,
    required this.mscatId,
  });

  @override
  State<HomeDetail> createState() => _VideoViewState();
}

class _VideoViewState extends State<HomeDetail> {
  List<CourseModel> courseList = [];
  List<CartModel> cartList = [];
  bool boolData = false;
  int singleCartIndex = 0;
  bool isAdded = false;
  @override
  void initState() {
    super.initState();
    getCourseAPI();
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => CartScreen(cartList: cartList));
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: boolData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: courseList[0].data?.length,
                itemBuilder: (context, index) {
                  final selectedItem = courseList[0].data![index].courses![0];

                  return lsit(
                    regMethod: courseList[0]
                        .data![index]
                        .registrationMethod
                        .toString(),
                    ePass: courseList[0].data![index].catName.toString(),
                    status: courseList[0].data![index].name.toString(),
                    groupcode: courseList[0].data![index].groupcode.toString(),
                    dateAndTime:
                        courseList[0].data![index].courses![0].classtime.toString(),
                    teacher: courseList[0]
                        .data![index]
                        .courses![0]
                        .firstName
                        .toString(),
                    price:
                        courseList[0].data![index].courses![0].price.toString(),
                    map: courseList[0].data![index].courses,
                    onAddToCart: () {
                      if (courseList[0].data![index].registrationMethod ==
                          "whole") {
                        onAddToCart(index);
                      } else if (courseList[0]
                              .data![index]
                              .registrationMethod ==
                          "single") {
                        //  onAddToSingleCart(index, singleCartIndex);
                        singleCartIndex++;
                      }
                      // navigateToCartScreen();
                    },
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
      ),
    );
  }

  void navigateToCartScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartScreen(cartList: cartList),
      ),
    );
  }

  void getCourseAPI() async {
    try {
      final res = await http.post(Uri.parse(AuthApi.courseApi), body: {
        "category_id": widget.mscatId,
      });
      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body.toString()}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          courseList.add(CourseModel.fromJson(mydata));
          setState(() {
            boolData = true;
          });
        } else {
          throw Exception('Empty response');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  void onAddToCart(int dataIndex) {
    final dataEntry = courseList[0].data![dataIndex];

    for (final course in dataEntry.courses!) {
      final cartItem = CartModel(
        groupId: courseList[0].data![dataIndex].id.toString(),
        categoryid: course.categoryId.toString(),
        courseId: course.id.toString(),
        courseTitle: course.courseTitle.toString(),
        price: double.parse(course.price.toString()),
      );

      if (!cartList.contains(cartItem)) {
        setState(() {
          cartList.add(cartItem);
        });
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Items added to cart'),
      ),
    );
  }

  void onAddToSingleCart(int Index, int courseIndex) {
    final dataEntry = courseList[0].data![Index];

    if (courseIndex >= 0 && courseIndex < dataEntry.courses!.length) {
      final course = dataEntry.courses![courseIndex];
      final cartItem = CartModel(
        groupId: courseList[0].data![Index].id.toString(),
        categoryid: course.categoryId.toString(),
        courseId: course.id.toString(),
        courseTitle: course.courseTitle.toString(),
        price: double.parse(course.price.toString()),
      );

      if (!cartList.contains(cartItem)) {
        setState(() {
          cartList.add(cartItem);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item added to cart'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item is already in the cart'),
          ),
        );
      }
    }
  }
}
