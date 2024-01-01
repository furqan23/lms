// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/DashboardModelWithSlider.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/values/logs.dart';
import 'package:splashapp/values/my_imgs.dart';
import 'package:splashapp/view/home/my_wallet.dart';
import 'package:splashapp/view/home_detail/home_detail.dart';
import 'package:splashapp/view/my_test/my_groups.dart';
import 'package:splashapp/view/mycourses/my_courses.dart';
import 'package:splashapp/view/payment/payment.dart';
import 'package:splashapp/view/quizz/getcoursetest_view.dart';
import 'package:splashapp/view/results/myresultcourse_view.dart';
import 'package:splashapp/view/test_pay/test_pay.dart';
import 'package:splashapp/widget/carousel_widget.dart';
import 'package:splashapp/widget/timer_two.dart';
import 'package:splashapp/widget/timer_widget.dart';

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
  final LoginController _loginController = Get.put(LoginController());

  List<DashboardModelWithSlider> dashboardList = [];
  bool boolData = false;
  List<CartModel> cartList = [];
  Box<String>? namee;
  String userName = "";
  String emaill = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    namee = Hive.box("tokenBox");
    userName = namee!.get('username') ?? " ";
    emaill = namee!.get('email') ?? " ";

    // final String? token = box.get('token');
    getDashboardAPI();
  }

  void getDashboardAPI() async {
    try {
      final res = await http.get(Uri.parse(AuthApi.getDashboardApi));
      print('Response Status Code: ${res.statusCode}');
      print('Response Body long');
      LogPrint(res.body.toString());

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          dashboardList.add(DashboardModelWithSlider.fromJson(mydata));
          // print("${dashboardList[0].data!.slides!.length}");
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

// size of the screen
    var size = MediaQuery.of(context).size;

/*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 8;
    final double itemWidth = size.width / 2.5;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
            centerTitle: true,
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
          body: boolData
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      // TimerWidgett(timee: 120),
                      // CountdownTimerDemo(),
                      // ElevatedButton(onPressed: (){
                      //   Get.to(()=>const TestApp());
                      // }, child: const Text("data")),
                      if (dashboardList.isNotEmpty &&
                          dashboardList[0].data != null &&
                          dashboardList[0].data!.slides != null &&
                          dashboardList[0].data!.slides!.isNotEmpty)
                        CarouselSlider.builder(
                          itemCount: dashboardList[0].data!.slides!.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              CarouselWidget(
                            title:
                                "${dashboardList[0].data!.slides![itemIndex].title.toString()}",
                            // ${dashboardList[0].data!.slides!.length}

                            image: AuthApi.baseUrlSliderImage +
                                "${dashboardList[0].data!.slides![itemIndex].filePath.toString()}",
                            btntitle: '',
                            color: const Color(0xffFFCAA6),
                          ),
                          options: CarouselOptions(
                            aspectRatio: 15 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                        )
                      else
                        Container(),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => const MyWallet());
                              },
                              child: const Text("My Wallet")),
                        ),
                      ),

                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dashboardList.isNotEmpty
                            ? dashboardList[0].data?.category?.length ?? 0
                            : 0,
                        gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                              childAspectRatio: (itemWidth / itemHeight),
                        ),
                        itemBuilder: (context, index) {
                          if (dashboardList.isEmpty) {
                            return const Center(child: Text('No data'));
                          } else {
                            return InkWell(
                              onTap: () {
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
                                image: dashboardList[0]
                                    .data!
                                    .category![index]
                                    .image??null,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
        ),
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
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        image: AssetImage(MyImgs.profileImage2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontFamily: 'BandaBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    emaill,
                    style: const TextStyle(
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
              color: Colors.green.shade300,
              onTap: () {
                Get.to(() => const MyCourses());
              },
            ),
            CustomListTile(
              leadingIcon: Icons.bookmark_outline_rounded,
              color: Colors.green.shade300,
              titleText: 'My Result',
              onTap: () {
                Get.to(() => const MyResultsCourse());
              },
            ),
            CustomListTile(
                leadingIcon: Icons.quiz_outlined,
                titleText: 'My Test',
                color: Colors.green.shade300,
                onTap: () {
                  Get.to(() => const MyGroups());
                }),
            CustomListTile(
              leadingIcon: Icons.payments_outlined,
              titleText: 'Payments',
              color: Colors.green.shade300,
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
