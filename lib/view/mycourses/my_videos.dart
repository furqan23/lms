import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/res/components/video_card.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/mycourses/onlinevideo/playvideo.dart';
import 'package:splashapp/view_model/Controller/mycourse/video_controller.dart';
import 'package:splashapp/view_model/Controller/auth/login_controller.dart';
import 'package:splashapp/model/video_model.dart';

class MyVideos extends StatefulWidget {
  final String id;

  const MyVideos(this.id, {Key? key}) : super(key: key);

  @override
  State<MyVideos> createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  final VideoController videoController = Get.put(VideoController());
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
    videoController.categoryApi(widget.id, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Lectures"),
      ),
      body: Obx(() {
        // Check if the album list is empty or null
        if (videoController.categories.value == null ||
            videoController.categories.value!.isEmpty) {
          return const Center(
            child:
                CircularProgressIndicator(), // Show circular progress indicator
          );
        } else if (videoController.categories.value!.isEmpty) {
          return const Center(
            child: Text('No Video available.'),
          );
        } else {
          return ListView.builder(
            itemCount: videoController.categories.value!.length,
            itemBuilder: (context, index) {
              final category = videoController.categories.value![index];
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
                  title: category.videoTitle.toString(),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
