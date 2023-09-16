import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/DashboardModelWithSlider.dart';

import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/values/my_imgs.dart';
import 'package:splashapp/view/cart/cart.dart';
import 'package:splashapp/view/home_detail/home_detail.dart';
import 'package:splashapp/view/mycourses/my_courses.dart';
import 'package:splashapp/view/payment/payment.dart';
import 'package:splashapp/view/quizz/getcoursetest_view.dart';
import 'package:splashapp/view/quizz/get_testquestion_view.dart';
import 'package:splashapp/view/results/myresultcourse_view.dart';
import 'package:splashapp/widget/carousel_widget.dart';

import '../../model/DashboardModel.dart';
import '../../model/cart_model.dart';
import '../../values/colors.dart';
import '../../widget/customlisttile_widget.dart';
import '../../widget/dasbhoard_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LoginController _loginController = Get.put(LoginController());
  List<DashboardModelWithSlider> dashboardList = [];
  bool boolData = false;

  @override
  void initState() {
    // TODO: implement initState
    getDashboardAPI();
    super.initState();
  }

  void getDashboardAPI() async {
    try {
      final res = await http.get(Uri.parse(AuthApi.getDashboardApi));
      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body.toString()}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          dashboardList.add(DashboardModelWithSlider.fromJson(mydata));
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
      throw Exception('Failed to load data $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(

        ),
        drawer: Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildHeader(context),
                  buildMenu(context),
                ],
              ),
            )),
        body:boolData
            ? SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              CarouselSlider.builder(
                itemCount: dashboardList[0].data?.slides!.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                CarouselWidget(
                          title: "The journey of 1st \n year ",
                          image: AuthApi.baseUrlSliderImage+"${dashboardList[0].data?.slides![itemIndex].filePath.toString()}",
                          btntitle: 'Get Started',
                          color: Color(0xffFFCAA6),
                        ), options: CarouselOptions(
                    aspectRatio: 15 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),

              ),

              // CarouselSlider(
              //   options: CarouselOptions(
              //     aspectRatio: 15 / 9,
              //     viewportFraction: 0.8,
              //     initialPage: 0,
              //     enableInfiniteScroll: true,
              //     reverse: false,
              //     autoPlay: true,
              //     autoPlayInterval: const Duration(seconds: 3),
              //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
              //     autoPlayCurve: Curves.fastOutSlowIn,
              //     enlargeCenterPage: true,
              //     enlargeFactor: 0.3,
              //     scrollDirection: Axis.horizontal,
              //   ),
              //
              //   items: [],
              //   // items: [
              //   //   // Item 1
              //   //   Builder(
              //   //     builder: (BuildContext context) {
              //   //       return const CarouselWidget(
              //   //         title: "The journey of 1st \n year ",
              //   //         image: MyImgs.study,
              //   //         btntitle: 'Get Started',
              //   //         color: Color(0xffFFCAA6),
              //   //       );
              //   //     },
              //   //   ),
              //   //
              //   //   // Item 2 - Different text and image
              //   //   Builder(
              //   //     builder: (BuildContext context) {
              //   //       return const CarouselWidget(
              //   //         title:
              //   //         'MDCAT 2023 top \n karo  aur future \n doctor bano!',
              //   //         image: "assets/images/logo.png",
              //   //         btntitle: 'Unlock MDCAT',
              //   //         color: Color(0xffF1C9EC),
              //   //       );
              //   //     },
              //   //   ),
              //   //
              //   //   Builder(
              //   //     builder: (BuildContext context) {
              //   //       return const CarouselWidget(
              //   //         title:
              //   //         'ETEA 2023 top \n karo aur future \n engineer bano!',
              //   //         image: AuthApi.baseUrlSliderImage,
              //   //         btntitle: 'Unlock ETEA',
              //   //         color: Color(0xffb2f6f6),
              //   //       );
              //   //     },
              //   //   ),
              //   //
              //   //   // You can add more items with different text and images here
              //   // ],
              // ),
              const SizedBox(height: 10),
               GridView.builder(
                  shrinkWrap: true,
                  itemCount: dashboardList[0].data?.category!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Get.snackbar(
                        //   "iii",
                        //   dashboardList[0].data![index].mscatId!,
                        // );
                        Get.to(() => HomeDetail(
                          mscatId: dashboardList[0]
                              .data!
                              .category![index]
                              .mscatId!,
                        ));
                      },
                      child: DashbaordCard(
                        id: dashboardList[0].data!.category![index].id!,
                        catName: dashboardList[0]
                            .data!
                            .category![index]
                            .catName!,
                      ),
                    );
                  }),

            ],
          ),
        ): Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            )),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          width: 400,
          height: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                    image: AssetImage(MyImgs.profileImage),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Imane fh',
                style: TextStyle(
                  fontFamily: 'BandaBold',
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: AppColors.blackColor,
                ),
              ),
              const Text(
                'Imane@gmail.com',
                style: TextStyle(
                  fontFamily: 'BandaBold',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.orangeColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget buildMenu(BuildContext context) => Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 2,
            color: Color(0xffBDC6D3),
          )
        ]),
    child: Column(
      children: [
        const SizedBox(height: 20),
        CustomListTile(
          leadingIcon: Icons.person_outline,
          titleText: 'My Courses',
          color: Colors.pink.shade100,
          onTap: () {
            Get.to(() => const MyCourses());
          },
        ),
        CustomListTile(
          leadingIcon: Icons.bookmark_outline_rounded,
          color: Colors.blueAccent.shade100,
          titleText: 'My Result',
          onTap: () {
            Get.to(()=>const MyResultsCourse());
          },
        ),
        CustomListTile(
            leadingIcon: Icons.quiz_outlined,
            titleText: 'My Test',
            color: Colors.cyan.shade100,
            onTap: () {
              Get.to(() => const GetCourseTest());
            }),
        CustomListTile(
          leadingIcon: Icons.payments_outlined,
          titleText: 'Payments',
          color: Colors.blue.shade400,
          onTap: () {
            Get.to(() => const Payment());
          },
        ),
        CustomListTile(
            leadingIcon: Icons.exit_to_app,
            titleText: 'Logout',
            color: Colors.red.shade400,
            onTap: () {
              Get.dialog(AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Are you Sure you want to Logout!'),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _loginController.logout();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blueAccent),
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueAccent,
                        ),
                        child: const Text(
                          'No',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
            }),
      ],
    ),
  );
}
