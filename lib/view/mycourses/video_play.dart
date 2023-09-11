

import 'package:flutter/material.dart';
import 'package:splashapp/view/mycourses/video_player.dart';

class VideoPlay extends StatefulWidget {
  const VideoPlay({super.key});

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
        title: Text("Video Lectures"),
    ),
    body:Center(
    child:SizedBox(
      height: mediaQuery.height * 0.3,
        child: YoutubePlayerDemo(urll:""!)),


    ));
  }
}
