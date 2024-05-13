// ignore_for_file: deprecated_member_use, non_constant_identifier_names
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:splashapp/model/course_model.dart';
import 'package:splashapp/view_model/Controller/homedetail_controller.dart';
import 'package:splashapp/widget/lsit.dart';
import '../../model/cart_model.dart';
import '../cart/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

RxString cartInt = "".obs;

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
  final HomeDetailsController homeDetailsController =
      Get.put(HomeDetailsController());
  List<CourseModel> courseList = [];
  List<CartModel> cartList = [];
  bool boolData = false;
  int singleCartIndex = 0;
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    homeDetailsController.homedetailsApi(widget.mscatId);
  }

  @override
  Widget build(BuildContext context) {
    cartInt.value = cartList.length.toString();
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Badge(
                label: Obx(
                  () => Text(
                    cartInt.value,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.red,
                isLabelVisible:
                    cartList.isNotEmpty, // Show badge if cartList is not empty
                child: IconButton(
                  onPressed: () async {
                    var updatedCartList =
                        await Get.to(() => CartScreen(cartList: cartList));

                    if (updatedCartList != null) {
                      setState(() {
                        cartList = updatedCartList;
                        print(updatedCartList);
                      });
                    }
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
          ],
        ),
        body: Obx(
          () {
            if (homeDetailsController.coursemodel.value == null ||
                homeDetailsController.coursemodel.value!.isEmpty) {
              return const Center(
                child:
                    CircularProgressIndicator(), // Show circular progress indicator
              );
            } else {
              return ListView.builder(
                itemCount: homeDetailsController.coursemodel.value!.length,
                itemBuilder: (context, index) {
                  final category =
                      homeDetailsController.coursemodel.value![index];
                  return lsit(
                    regMethod: category.registrationMethod.toString(),
                    ePass: category.catName.toString(),
                    status: category.name.toString(),
                    groupcode: category.groupcode.toString(),
                    dateAndTime: category.courses![0].classtime.toString(),
                    teacher: category.courses![0].firstName.toString(),
                    price: category.courses![0].price.toString(),
                    map: category.courses,
                    onAddToCart: () {
                      if (category.registrationMethod.toString() == "whole") {
                        onAddToCart(index);
                      } else if (category.registrationMethod.toString() ==
                          "single") {
                        onAddToSingleCart(index, singleCartIndex);
                        singleCartIndex++;
                      }
                    },
                  );
                },
              );
            }
          },
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

  void onAddToSingleCart(int index, int courseIndex) {
    // Retrieve the course model using the provided index
    Data courseToAdds = homeDetailsController.coursemodel.value![index];

    // Check if the registration method is "single"
    if (courseToAdds.registrationMethod == "single") {
      // Ensure courseToAdds is not null and courseIndex is within bounds
      if (courseToAdds != null &&
          courseIndex >= 1 &&
          courseIndex < courseToAdds.courses!.length) {
        final course = courseToAdds.courses![courseIndex];
        final cartItem = CartModel(
          registrationMethod: courseToAdds.registrationMethod.toString(),
          categoryname: courseToAdds.catName.toString(),
          groupname: courseToAdds.name.toString(),
          groupId: courseToAdds.id.toString(),
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
    }
    saveCartData();
  }

  void onAddToCart(int dataIndex) {
    Data courseToAdd = homeDetailsController.coursemodel.value![dataIndex];

    if (courseToAdd.registrationMethod == "whole") {
      for (final course in courseToAdd.courses!) {
        final cartItem = CartModel(
          registrationMethod: courseToAdd.registrationMethod.toString(),
          categoryname: courseToAdd.catName.toString(),
          groupname: courseToAdd.name.toString(),
          groupId: courseToAdd.id.toString(),
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
    } else if (courseToAdd.registrationMethod == "single") {}
  }
}
