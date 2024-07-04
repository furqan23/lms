// ignore_for_file: deprecated_member_use, non_constant_identifier_names
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:splashapp/model/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/values/colors.dart';
import 'package:splashapp/values/logs.dart';
import 'package:splashapp/widget/lsit.dart';
import '../../model/cart_model.dart';
import '../../values/auth_api.dart';
import '../cart/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';


RxString cartInt="".obs;
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
    getCartData();
  }

  @override
  Widget build(BuildContext context) {
    cartInt.value=cartList.length.toString();
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Badge(
            //     label:  Obx(
            //           () =>Text(
            //       cartInt.value,
            //       style: const TextStyle(color: Colors.white),
            //     ),),
            //     backgroundColor: Colors.red,
            //     isLabelVisible:
            //         cartList.isNotEmpty, // Show badge if cartList is not empty
            //     child: IconButton(
            //       onPressed: () async {
            //         var updatedCartList =
            //             await Get.to(() => CartScreen(cartList: cartList));
            //
            //         if (updatedCartList != null) {
            //           setState(() {
            //             cartList = updatedCartList;
            //           });
            //         }
            //       },
            //       icon: const Icon(Icons.shopping_cart),
            //     ),
            //   ),
            // ),
          ],
        ),
        body: boolData
            ? courseList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: courseList[0].data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final selectedItem =
                          courseList[0].data![index].courses![0];

                      return lsit(
                        regMethod: courseList[0]
                            .data![index]
                            .registrationMethod
                            .toString(),
                        ePass: courseList[0].data![index].catName.toString(),
                        status: courseList[0].data![index].name.toString(),
                        groupcode:
                            courseList[0].data![index].groupcode.toString(),
                        dateAndTime:
                            courseList[0].data![index].courses![0].classtime!,
                        teacher: courseList[0]
                            .data![index]
                            .courses![0]
                            .firstName
                            .toString(),
                        price: courseList[0]
                            .data![index]
                            .courses![0]
                            .price
                            .toString(),
                        map: courseList[0].data![index].courses,
                        onAddToCart: () {
                          if (courseList[0].data![index].registrationMethod ==
                              "whole") {
                            onAddToCart(index);
                          } else if (courseList[0]
                                  .data![index]
                                  .registrationMethod ==
                              "single") {
                            onAddToSingleCart(index, singleCartIndex);
                            singleCartIndex++;
                          }
                        },
                      );
                    },
                  )
                : const Center(
                    child: Text('No courses available'),
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

  Future<void> saveCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = cartList.map((cart) => cart.toJson()).toList();
    await prefs.setString('cartData', json.encode(cartData));
    print(cartData);
  }

  Future<void> getCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartDataString = prefs.getString('cartData');

    setState(() {
      if (cartDataString != null) {
        List<dynamic> decodedList = json.decode(cartDataString);
        cartList = decodedList.map((item) => CartModel.fromJson(item)).toList();
      }
    });
  }

  void getCourseAPI() async {
    try {
      final res = await http.post(Uri.parse(AuthApi.courseApi), body: {
        "category_id": widget.mscatId,
      });
      print('Response Status Code: ${res.statusCode}');
//  print('Response Body: ${res.body.toString()}');
      print('Response Body long');
      LogPrint(res.body.toString());
      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          courseList.add(CourseModel.fromJson(mydata));
          setState(() {
            boolData = true;
          });
        } else {
          setState(() {
            boolData = false; // Set boolData to false as there is no data
          });
          throw Exception('Empty response');
        }
      } else {
        setState(() {
          boolData = false; // Set boolData to false as loading failed
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        boolData = false; // Set boolData to false in case of any error
      });
      throw Exception('Failed to load data');
    }
  }

  void onAddToSingleCart(int Index, int courseIndex) {
    final dataEntry = courseList[0].data![Index];

    if (dataEntry.registrationMethod == "single") {
      if (courseIndex >= 0 && courseIndex < dataEntry.courses!.length) {
        final course = dataEntry.courses![courseIndex];
        final cartItem = CartModel(
          registrationMethod: dataEntry.registrationMethod.toString(),
          categoryname: dataEntry.catName.toString(),
          groupname: dataEntry.name.toString(),
          groupId: dataEntry.id.toString(),
          categoryid: course.categoryId.toString(),
          courseId: course.id.toString(),
          courseTitle: course.courseTitle.toString(),
          price: double.parse(course.price.toString()),
        );

// Check if the cartItem already exists in cartList
        if (!cartList.any((item) => item.courseId == cartItem.courseId)) {
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
      saveCartData();
    }
  }

  void onAddToCart(int dataIndex) {
    final dataEntry = courseList[0].data![dataIndex];

    if (dataEntry.registrationMethod == "whole") {
      for (final course in dataEntry.courses!) {
        final cartItem = CartModel(
          registrationMethod: dataEntry.registrationMethod.toString(),
          categoryname: dataEntry.catName.toString(),
          groupname: dataEntry.name.toString(),
          groupId: dataEntry.id.toString(),
          categoryid: course.categoryId.toString(),
          courseId: course.id.toString(),
          courseTitle: course.courseTitle.toString(),
          price: double.parse(course.price.toString()),
        );

// Check if the cartItem already exists in cartList
        if (!cartList.any((item) => item.courseId == cartItem.courseId)) {
          setState(() {
            cartList.add(cartItem);
          });
        }
      }

      saveCartData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Items added to cart'),
        ),
      );
    } else if (dataEntry.registrationMethod == "single") {
// Implement logic for handling single item addition
// This section should be based on your requirement for adding a single item
// For example, display a dialog to choose a specific item and then add it to the cart
    }
  }
}
