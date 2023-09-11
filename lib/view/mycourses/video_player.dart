import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';



class YoutubePlayerDemo extends StatefulWidget {
  String? urll;
  YoutubePlayerDemo({Key? key,required String this.urll}) : super(key:        key);


  @override
  _YoutubePlayerDemoState createState() => _YoutubePlayerDemoState();
}

class _YoutubePlayerDemoState extends State<YoutubePlayerDemo> {
  late YoutubePlayerController _controller;

  //  List<String> _videoIds = [
  //   'tcodrIK2P_I',
  //   'H5v3kku4y6Q',
  // ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: true,

        showFullscreenButton: true,
        loop: false,
      ),
    );


    _controller.loadVideo(widget.urll!);

  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(title: Text("Video Player"),),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(top:28.0),
              child: ListView(
                children: [
                  player,
                  VideoPositionIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}


class VideoPositionIndicator extends StatelessWidget {
  ///
  //const VideoPositionIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.ytController;

    return StreamBuilder<YoutubeVideoState>(
      stream: controller.videoStateStream,
      initialData: const YoutubeVideoState(),
      builder: (context, snapshot) {
        final position = snapshot.data?.position.inMilliseconds ?? 0;
        final duration = controller.metadata.duration.inMilliseconds;

        return LinearProgressIndicator(
          value: duration == 0 ? 0 : position / duration,
          minHeight: 1,
        );
      },
    );
  }
}
