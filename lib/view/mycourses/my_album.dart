import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/view_model/Controller/mycourse/album_controller.dart';
import 'package:splashapp/view_model/Controller/auth/login_controller.dart';
import 'package:splashapp/model/album_model.dart';
import 'package:splashapp/view/mycourses/my_videos.dart';
import 'package:splashapp/widget/album_card.dart';

class MyAlbum extends StatefulWidget {
  final String id;
  MyAlbum(this.id, {Key? key}) : super(key: key);

  @override
  State<MyAlbum> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyAlbum> {
  final AlbumController albumController = Get.put(AlbumController());
  late String token;
  List<Data> albumList = [];
  bool boolData = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Albums"),
      ),
      body: Obx(() {
        // Check if the album list is empty or null
        if (albumController.album.value == null || albumController.album.value!.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(), // Show circular progress indicator
          );
        } else {
          return ListView.builder(
            itemCount: albumController.album.value!.length,
            itemBuilder: (context, index) {
              final category = albumController.album.value![index];
              return InkWell(
                onTap: () {
                  Get.to(() => MyVideos(category.id.toString()));
                },
                child: AlbumCard(
                  id: category.id.toString(),
                  albam_code: category.albamCode.toString(),
                  albam_title: category.albumTitle.toString(),
                ),
              );
            },
          );
        }
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    getTokenAndFetchVideos();
  }

  Future<void> getTokenAndFetchVideos() async {
    token = (await LoginController().getTokenFromHive())!;
    print('Token: $token');
    albumController.courseAlbumApi(widget.id, token);
  }
}
