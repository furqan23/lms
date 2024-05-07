import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/data/response/status.dart';
import 'package:splashapp/res/color/appcolor.dart';
import 'package:splashapp/res/components/mybutton_widget.dart';
import 'package:splashapp/res/components/video_card.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/mycourses/onlinevideo/playvideo.dart';
import 'package:splashapp/view_model/Controller/detail_controller.dart';
import 'package:splashapp/view_model/Controller/login_controller.dart';
import 'package:splashapp/model/video_model.dart';

class MyVideos extends StatefulWidget {
  final String id;

  const MyVideos(this.id, {Key? key}) : super(key: key);

  @override
  State<MyVideos> createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  final MyCourseController detailController = Get.put(MyCourseController());
  late String token;
  List<Data> myVideoList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getTokenAndFetchVideos();
  }

  Future<void> getTokenAndFetchVideos() async {
    token = (await LoginController().getTokenFromHive())!;
    print('Token: $token');
    detailController.categoryApi(widget.id, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Lectures"),
      ),
      body: Obx(() {
        if (detailController.reRequestStatus.value == Status.LOADING) {
          return const Center(child: CircularProgressIndicator());
        } else if (detailController.categories.value == null ||
            detailController.categories.value!.isEmpty) {
          return const Center(child: Text("No Data Available"));
        } else {
          return ListView.builder(
            itemCount: detailController.categories.value!.length,
            itemBuilder: (context, index) {
              final category = detailController.categories.value![index];
              return InkWell(
                  onTap: () {
                    Get.to(() => PlayVideo(
                      type: "ok",
                      id: category.videoName.toString(),
                      listvideo: myVideoList, // Pass the entire list
                    ));
                  },
                  child: VideoCard(
                      id: category.id.toString(),
                      title: category.videoTitle.toString()));
            },
          );
        }
      }),
    );
  }
}
