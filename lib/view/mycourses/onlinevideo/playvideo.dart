import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashapp/values/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PlayVideo extends StatefulWidget {
  // const PlayVideo({super.key});
  final String type, id;
  final List listvideo;
  PlayVideo({required this.type, required this.id, required this.listvideo});

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool _hasError = false;
  String _errorMessage = '';
  bool _isControllerInitialized = false;

  List get _ids => widget.listvideo;

  @override
  void initState() {
    super.initState();
    _initializeAsync();
  }

  void _initializeAsync() async {
    print("List of all video is ${widget.listvideo}");
    print("Video URL/ID passed: ${widget.id}");
    print("Video list length: ${widget.listvideo.length}");

    // Test video ID extraction
    _testVideoIdExtraction();

    String? videoId;
    try {
      videoId = YoutubePlayer.convertUrlToId(widget.id);
      print("YouTube player converted ID: $videoId");
      if (videoId == null) {
        // If conversion fails, try to extract video ID from the URL manually
        videoId = _extractVideoId(widget.id);
        print("Manually extracted ID: $videoId");
      }
    } catch (e) {
      print("Error converting URL to ID: $e");
      videoId = _extractVideoId(widget.id);
      print("Fallback extracted ID: $videoId");
    }
    
    print("Final Video Id: $videoId ${videoId is String}");
    
    if (videoId == null || videoId.isEmpty) {
      print("Invalid video ID: ${widget.id}");
      setState(() {
        _hasError = true;
        _errorMessage = 'Invalid video URL or ID: ${widget.id}';
      });
      return;
    }
    
    print("Creating YouTube player controller with video ID: $videoId");
    print("YouTube player flags: mute=false, autoPlay=true, disableDragSeek=false, loop=false, isLive=false, forceHD=false, enableCaption=true");
    
    // Check video availability before creating controller
    bool isAvailable = await _isVideoAvailable(videoId);
    if (!isAvailable) {
      print("Video $videoId is not available, trying next video...");
      setState(() {
        _hasError = true;
        _errorMessage = 'This video is not available. Trying next video...';
      });
      // Try the next video in the list
      if (_ids.length > 1) {
        Future.delayed(const Duration(seconds: 2), () {
          _tryNextAvailableVideo();
        });
      }
      return;
    }
    
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
    setState(() {
      _isControllerInitialized = true;
    });
  }

  String? _extractVideoId(String url) {
    // Handle different YouTube URL formats
    if (url.contains('youtube.com/watch?v=')) {
      final uri = Uri.parse(url);
      return uri.queryParameters['v'];
    } else if (url.contains('youtu.be/')) {
      final uri = Uri.parse(url);
      return uri.pathSegments.last;
    } else if (url.length == 11) {
      // Assume it's already a video ID
      return url;
    }
    return null;
  }

  // Test method to verify video ID extraction
  void _testVideoIdExtraction() {
    List<String> testUrls = [
      'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'https://youtu.be/dQw4w9WgXcQ',
      'dQw4w9WgXcQ',
      'https://www.youtube.com/embed/dQw4w9WgXcQ',
    ];
    
    for (String url in testUrls) {
      String? extractedId = _extractVideoId(url);
      print("URL: $url -> Extracted ID: $extractedId");
    }
  }

  String _getErrorMessage(int errorCode) {
    switch (errorCode) {
      case 2:
        return 'Invalid video ID or URL';
      case 5:
        return 'HTML5 player error';
      case 100:
        return 'Video not found or removed';
      case 101:
        return 'Video embedding disabled by owner';
      case 150:
        return 'Video embedding disabled by owner';
      case 152:
        return 'Video not available in your region or restricted';
      case 200:
        return 'Playlist not found or private';
      case 201:
        return 'Playlist embedding disabled by owner';
      case 250:
        return 'Playlist not available in your region';
      default:
        return 'Unknown error occurred (Code: $errorCode)';
    }
  }

  Future<bool> _isVideoAvailable(String videoId) async {
    try {
      // Check if video is available by making a request to YouTube
      final response = await http.get(
        Uri.parse('https://www.youtube.com/watch?v=$videoId'),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        },
      );
      
      // If the response contains certain keywords, the video might be restricted
      String body = response.body.toLowerCase();
      bool isRestricted = body.contains('video unavailable') || 
                         body.contains('private video') || 
                         body.contains('video not available') ||
                         body.contains('this video is not available');
      
      print("Video availability check for $videoId: ${isRestricted ? 'Restricted' : 'Available'}");
      return !isRestricted;
    } catch (e) {
      print("Error checking video availability: $e");
      return true; // Assume available if check fails
    }
  }

  void _tryNextAvailableVideo() async {
    if (_ids.isEmpty) return;
    
    int currentIndex = _ids.indexOf(_extractVideoId(widget.id) ?? '');
    if (currentIndex == -1) currentIndex = 0;
    
    // Try the next 5 videos in the list
    for (int i = 1; i <= 5 && currentIndex + i < _ids.length; i++) {
      try {
        String nextVideoId = _ids[currentIndex + i];
        print("Trying video: $nextVideoId");
        _controller.load(nextVideoId);
        _showSnackBar('Trying next available video...');
        return;
      } catch (e) {
        print("Error loading video at index ${currentIndex + i}: $e");
        continue;
      }
    }
    
    // If no videos work, show error
    setState(() {
      _hasError = true;
      _errorMessage = 'No videos in the list are currently available';
    });
  }

  Future<bool> _checkNetworkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
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
    if (!_isControllerInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
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
          if (_ids.isNotEmpty) {
            try {
              int currentIndex = _ids.indexOf(data.videoId);
              if (currentIndex == -1) {
                // If current video not found in list, try to find by extracted ID
                String? currentVideoId = _extractVideoId(widget.id);
                currentIndex = _ids.indexOf(currentVideoId ?? '');
              }
              
              if (currentIndex != -1 && currentIndex < _ids.length - 1) {
                _controller.load(_ids[currentIndex + 1]);
                _showSnackBar('Next Video Started!');
              }
            } catch (e) {
              print("Error loading next video: $e");
            }
          }
        },
        // onError: (error) async {
        //   print("YouTube Player Error: $error");
        //   String errorMessage = _getErrorMessage(error.code);
          
        //   // Check network connectivity
        //   bool isConnected = await _checkNetworkConnectivity();
        //   if (!isConnected) {
        //     errorMessage = 'No internet connection. Please check your network and try again.';
        //   }
          
        //   setState(() {
        //     _hasError = true;
        //     _errorMessage = errorMessage;
        //   });
        //   _showSnackBar('Error loading video: $errorMessage');
        // },
      ),
      builder: (context, player) => Scaffold(
        key: _scaffoldKey,
        body: _hasError 
            ? _buildErrorWidget()
            : ListView(
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
                              onPressed: _isPlayerReady && _ids.isNotEmpty
                                  ? () {
                                      try {
                                        int currentIndex = _ids.indexOf(_controller.metadata.videoId);
                                        if (currentIndex == -1) {
                                          String? currentVideoId = _extractVideoId(widget.id);
                                          currentIndex = _ids.indexOf(currentVideoId ?? '');
                                        }
                                        
                                        if (currentIndex > 0) {
                                          _controller.load(_ids[currentIndex - 1]);
                                        }
                                      } catch (e) {
                                        print("Error loading previous video: $e");
                                      }
                                    }
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
                            FullScreenButton(
                              controller: _controller,
                              color: AppColors.primaryColor,
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_next),
                              onPressed: _isPlayerReady && _ids.isNotEmpty
                                  ? () {
                                      try {
                                        int currentIndex = _ids.indexOf(_controller.metadata.videoId);
                                        if (currentIndex == -1) {
                                          String? currentVideoId = _extractVideoId(widget.id);
                                          currentIndex = _ids.indexOf(currentVideoId ?? '');
                                        }
                                        
                                        if (currentIndex != -1 && currentIndex < _ids.length - 1) {
                                          _controller.load(_ids[currentIndex + 1]);
                                        }
                                      } catch (e) {
                                        print("Error loading next video: $e");
                                      }
                                    }
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

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50,
          ),
          const SizedBox(height: 10),
          Text(
            _errorMessage,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Possible solutions:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Check your internet connection'),
                Text('• Try a different video from the list'),
                Text('• The video might be restricted in your region'),
                Text('• Try using a VPN if available'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _hasError = false;
                    _errorMessage = '';
                  });
                  // Attempt to reload the video if possible
                  if (_ids.isNotEmpty) {
                    try {
                      int currentIndex = _ids.indexOf(_extractVideoId(widget.id) ?? '');
                      if (currentIndex != -1) {
                        _controller.load(_ids[currentIndex]);
                      }
                    } catch (e) {
                      print("Error reloading video: $e");
                    }
                  }
                },
                child: const Text('Retry'),
              ),
              if (_ids.length > 1)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _hasError = false;
                      _errorMessage = '';
                    });
                    // Try loading the next video in the list
                    try {
                      int currentIndex = _ids.indexOf(_extractVideoId(widget.id) ?? '');
                      if (currentIndex != -1 && currentIndex < _ids.length - 1) {
                        _controller.load(_ids[currentIndex + 1]);
                      } else if (_ids.isNotEmpty) {
                        // If current video not found, try the first video
                        _controller.load(_ids[0]);
                      }
                    } catch (e) {
                      print("Error loading next video: $e");
                    }
                  },
                  child: const Text('Try Next Video'),
                ),
            ],
          ),
          const SizedBox(height: 20),
          if (_ids.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _hasError = false;
                      _errorMessage = '';
                    });
                    _tryNextAvailableVideo();
                  },
                  child: const Text('Try Next Available'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _hasError = false;
                      _errorMessage = '';
                    });
                    // Try loading a random video from the list
                    try {
                      if (_ids.isNotEmpty) {
                        int randomIndex = DateTime.now().millisecondsSinceEpoch % _ids.length;
                        _controller.load(_ids[randomIndex]);
                      }
                    } catch (e) {
                      print("Error loading random video: $e");
                    }
                  },
                  child: const Text('Try Random Video'),
                ),
              ],
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Navigate back to the previous screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
