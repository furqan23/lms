// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:splashapp/res/assets/images_assets.dart';
import 'package:splashapp/res/constants/constants.dart';
import 'package:splashapp/view/home/components/buildheader_home.dart';
import 'package:splashapp/view/home/components/buildmenu_home.dart';
import 'package:splashapp/view/payment/payment.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/model/DashboardModelWithSlider.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/res/logs/logs.dart';
import 'package:splashapp/view/home/my_wallet.dart';
import 'package:splashapp/view/home_detail/home_detail.dart';
import 'package:splashapp/view/my_test/my_groups.dart';
import 'package:splashapp/view/mycourses/my_courses.dart';
import 'package:splashapp/view/results/myresultcourse_view.dart';
import 'package:splashapp/view_model/Controller/login_controller.dart';
import 'package:splashapp/widget/carousel_widget.dart';
import '../../model/cart_model.dart';
import 'package:splashapp/res/color/appcolor.dart';
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
                BuildHeader(userName: userName, emaill: emaill, context: context),
                BuildMenu(loginController: _loginController, context: context),
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
                        const Center(
                          child:Text("No Data")
                        ),
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
                                    .image,
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

}

