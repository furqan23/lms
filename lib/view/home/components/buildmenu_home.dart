import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/res/components/customlisttile_widget.dart';
import 'package:splashapp/view/dropdown.dart';
import 'package:splashapp/view/my_test/my_groups.dart';
import 'package:splashapp/view/mycourses/my_courses.dart';
import 'package:splashapp/view/payment/payment.dart';
import 'package:splashapp/view/results/myresultcourse_view.dart';
import 'package:splashapp/view_model/Controller/auth/login_controller.dart';

class BuildMenu extends StatelessWidget {
  const BuildMenu({
    super.key,
    required LoginController loginController,
    required this.context,
  }) : _loginController = loginController;

  final LoginController _loginController;
  final BuildContext context;

  @override
  Widget build(BuildContext context) => Container(
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
                Get.to(() => Payment());
              },
            ),
            CustomListTile(
              leadingIcon: Icons.payments_outlined,
              titleText: 'Dropdown',
              color: Colors.green.shade300,
              onTap: () {
                Get.to(() => DropDownScreen());
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
