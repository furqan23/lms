import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:splashapp/Controller/login_controller.dart';
import 'package:splashapp/model/album_model.dart';
import 'package:splashapp/values/auth_api.dart';
import 'package:splashapp/view/mycourses/my_videos.dart';
import 'package:splashapp/widget/album_card.dart';

class MyAlbum extends StatefulWidget {
  final String id;
  MyAlbum(this.id, {Key? key}) : super(key: key);

  @override
  State<MyAlbum> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyAlbum> {
  String? token;
  List<Data> albumList = [];
  bool boolData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Course Albums"),
      ),
      body: boolData
          ? albumList.isEmpty?Center(child: Text("No Courses Available"),):ListView.builder(
              shrinkWrap: true,
              itemCount: albumList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => MyVideos(
                        albumList[index].id!));
                  },
                  child: AlbumCard(
                    id: albumList[index].id,
                    albam_title: albumList[index].albumTitle,
                    albam_code:
                        "${albumList[index].albamCode}",

                  ),
                );
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );

  }

  @override
  void initState() {
    super.initState();
    getTokenAndFetchInvoice();
  }

  Future<void> getTokenAndFetchInvoice() async {
    token = await LoginController().getTokenFromHive();
    print('Token: $token');
    getMyCourseAPI();
  }

  void getMyCourseAPI() async {
    // setState(() {
    //   boolData = true;
    // });
    try {
      // final Map<String, dynamic> requestData = {
      //   "invoice_id": widget.invoice_id,
      // };

      // final String requestBody = jsonEncode(requestData);

      final res = await http.post(
        Uri.parse(AuthApi.getCourseAlbum),
        headers: {
          'Authorization': 'Bearer $token', // Use the retrieved token
        },
        body: {
          'course_id': '${widget.id}', // Use the retrieved token
        },
      );

      print('Response Status Code: ${res.statusCode}');
      print('Response Body: ${res.body}');

      if (res.statusCode == 200) {
        if (res.body.isNotEmpty) {
          final mydata = jsonDecode(res.body);
          print('Parsed Data: $mydata');

          setState(() {
            boolData = true;
            print(boolData.toString());
            final couselist = AlbumModel.fromJson(mydata);
            albumList = couselist.data!;
          });
        } else {
          setState(() {
            boolData = true;
          });
          throw Exception('Empty response');
        }
      } else {
        setState(() {
          boolData = true;
        });
        print('Error: ${res.statusCode}');
      }
    } catch (e) {
      setState(() {
        boolData = true;
      });
      print(e.toString());
    }
  }
}
