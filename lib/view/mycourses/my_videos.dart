import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/video_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/mycourses/onlinevideo/playvideo.dart';
import 'package:splashapp/widget/video_card.dart';

class MyVideos extends StatefulWidget {
  final String id;

  const MyVideos(this.id, {Key? key}) : super(key: key);

  @override
  State<MyVideos> createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
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
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(AuthApi.videoLecturesApi),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {'album_id': widget.id},
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Parsed Data: $responseData');

        setState(() {
          final videoModel = VideoModel.fromJson(responseData);
          myVideoList = videoModel.data ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch videos. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Lectures"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : myVideoList.isEmpty
          ? const Center(child: Text('No videos available'))
          : ListView.builder(
        itemCount: myVideoList.length,
        itemBuilder: (context, index) {
          final video = myVideoList[index];
          return InkWell(
            onTap: () {
              Get.to(() => PlayVideo(
                type: "ok",
                id: video.videoName!,
                listvideo: myVideoList, // Pass the entire list
              ));
            },
            child: VideoCard(
              id: video.id,
              catName: video.videoTitle.toString(),
              videotitle: video.videoTitle.toString(),
              name: video.videoName,
              description: video.uploaderId,
              slug: video.uploaderId,
              seat: video.videoName,
              registermethod: video.videoName,
            ),
          );
        },
      ),
    );
  }
}
