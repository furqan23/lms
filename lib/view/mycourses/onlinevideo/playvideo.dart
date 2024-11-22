import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/values/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:flutter/cupertino.dart';

class PlayVideo extends StatefulWidget {
  // const PlayVideo({super.key});
  final String type, id;
  final List listvideo;
  PlayVideo({required this.type, required this.id, required this.listvideo});

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late bool _isAutoScreenEnabled; // To store if auto-rotation is enabled or not
  late Orientation _currentOrientation;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  List get _ids => widget.listvideo;

  @override
  void initState() {
    super.initState();
    _currentOrientation = MediaQuery.of(context).orientation;
    _isAutoScreenEnabled =
        true; // For now, we assume auto-rotation is enabled (can be linked to settings)
    print("List of all video is ${widget.listvideo}");

    String videoId;
    videoId = YoutubePlayer.convertUrlToId(widget.id)!;
    print(videoId);
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void _setFullScreen(bool enable) {
    if (enable) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: []); // Hide status and navigation bar (fullscreen)
      setState(() {
        _isAutoScreenEnabled = true;
      });
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values); // Show system bars (normal screen)
      setState(() {
        _isAutoScreenEnabled = false;
      });
    }
  }

  void _checkAndEnableFullScreen() {
    if (_isAutoScreenEnabled) {
      // Auto-rotation enabled, enable fullscreen
      _setFullScreen(true);
    } else {
      // Show Snackbar asking the user to enable auto-rotation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please enable auto-rotation in settings for full-screen mode.')),
      );
    }
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {},
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  _text('Title', _videoMetaData.title),
                  _space,
                  // _text('Channel', _videoMetaData.author),
                  // _space,
                  // _text('Video Id', _videoMetaData.videoId),
                  // _space,
                  // Row(
                  //   children: [
                  //     _text(
                  //       'Playback Quality',
                  //       _controller.value.playbackQuality,
                  //     ),
                  //     const Spacer(),
                  //     _text(
                  //       'Playback Rate',
                  //       '${_controller.value.playbackRate}x  ',
                  //     ),
                  //   ],
                  // ),
                  _space,
                  // TextField(
                  //   enabled: _isPlayerReady,
                  //   controller: _idController,
                  //   decoration: InputDecoration(
                  //     border: InputBorder.none,
                  //     hintText: 'Enter youtube \<video id\> or \<link\>',
                  //     fillColor: Colors.blueAccent.withAlpha(20),
                  //     filled: true,
                  //     hintStyle: const TextStyle(
                  //       fontWeight: FontWeight.w300,
                  //       color: Colors.blueAccent,
                  //     ),
                  //     suffixIcon: IconButton(
                  //       icon: const Icon(Icons.clear),
                  //       onPressed: () => _idController.clear(),
                  //     ),
                  //   ),
                  // ),
                  // _space,
                  // Row(
                  //   children: [
                  //     _loadCueButton('LOAD'),
                  //     const SizedBox(width: 10.0),
                  //     _loadCueButton('CUE'),
                  //   ],
                  // ),
                  _space,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous),
                        onPressed: _isPlayerReady
                            ? () => _controller.load(_ids[
                                (_ids.indexOf(_controller.metadata.videoId) -
                                        1) %
                                    _ids.length])
                            : null,
                      ),
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        onPressed: _isPlayerReady
                            ? () {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                                setState(() {});
                              }
                            : null,
                      ),
                      IconButton(
                        icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                        onPressed: _isPlayerReady
                            ? () {
                                _muted
                                    ? _controller.unMute()
                                    : _controller.mute();
                                setState(() {
                                  _muted = !_muted;
                                });
                              }
                            : null,
                      ),
                      // FullScreenButton(
                      //   controller: _controller,
                      //   color: AppColors.primaryColor,
                      // ),
                      ElevatedButton(
                        onPressed: _checkAndEnableFullScreen,
                        child: Text(
                          _isAutoScreenEnabled
                              ? 'Enable Full-Screen Mode'
                              : 'Enable Auto-Rotation to Use Full-Screen',
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next),
                        onPressed: _isPlayerReady
                            ? () => _controller.load(_ids[
                                (_ids.indexOf(_controller.metadata.videoId) +
                                        1) %
                                    _ids.length])
                            : null,
                      ),
                    ],
                  ),
                  _space,
                  Row(
                    children: <Widget>[
                      const Text(
                        "Volume",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Expanded(
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          value: _volume,
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          label: '${(_volume).round()}',
                          onChanged: _isPlayerReady
                              ? (value) {
                                  setState(() {
                                    _volume = value;
                                  });
                                  _controller.setVolume(_volume.round());
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                  _space,
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: _getStateColor(_playerState),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _playerState.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value ?? '',
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey.shade700;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return AppColors.primaryColor;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return AppColors.primaryColor;
      default:
        return AppColors.primaryColor;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: AppColors.primaryColor,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                    _idController.text,
                  );
                  if (action == 'LOAD') _controller.load(widget.id);
                  if (action == 'CUE') _controller.cue(widget.id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    // _scaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     content: Text(
    //       message,
    //       textAlign: TextAlign.center,
    //       style: const TextStyle(
    //         fontWeight: FontWeight.w300,
    //         fontSize: 16.0,
    //       ),
    //     ),
    //     backgroundColor: Colors.blueAccent,
    //     behavior: SnackBarBehavior.floating,
    //     elevation: 1.0,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(50.0),
    //     ),
    //   ),
    // );
    //
    Get.snackbar("title", message);
  }
}
