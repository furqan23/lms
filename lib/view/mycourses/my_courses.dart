import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/view_model/Controller/auth/login_controller.dart';
import 'package:splashapp/model/my_courses_model.dart';
import 'package:splashapp/view/mycourses/my_album.dart';
import 'package:splashapp/view_model/Controller/mycourse/mycourse_controller.dart';
import 'package:splashapp/widget/dasbhoard_card_two.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  final MyCourseController myCourseController = Get.put(MyCourseController());
  late String token;


  @override
  void initState() {
    super.initState();
    getTokenAndFetchVideos();
  }

  Future<void> getTokenAndFetchVideos() async {
    token = (await LoginController().getTokenFromHive())!;
    print('Token: $token');
    myCourseController.mycoursesApi(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Courses"),
      ),
      body: Obx(() {
        // Check if the album list is empty or null
        if (myCourseController.coursedata.value == null ||
            myCourseController.coursedata.value!.isEmpty) {
          return const Center(
            child:
            CircularProgressIndicator(), // Show circular progress indicator
          );
        } else if (myCourseController.coursedata.value!.isEmpty) {
          return const Center(
            child: Text('No courses available.'),
          );
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: myCourseController.coursedata.value!.length,
              itemBuilder: (context, index) {
                final category = myCourseController.coursedata.value![index];
                return InkWell(
                  onTap: () {
                    Get.to(
                          () => MyAlbum(
                        category.courseId.toString(),
                      ),
                    );
                  },
                  child: DashbaordCardTwo(
                    group: category.courseCode.toString(),
                    id: category.name.toString(),
                    catName: category.courseTitle,
                    name: "${category.firstName}",
                    description: category.name,
                    slug: category.name,
                    seat: category.totalSeat,
                    registermethod: category.registrationMethod,
                    buttonText: 'View Detail >',
                  ),
                );
              });
        }
      }),
    );
  }
}
