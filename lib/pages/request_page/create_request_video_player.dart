import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CreatRequestVideoPlayer extends StatefulWidget {
  final File video;
  CreatRequestVideoPlayer({Key key, this.video}) : super(key: key);

  @override
  _CreatRequestVideoPlayerState createState() =>
      _CreatRequestVideoPlayerState();
}

class _CreatRequestVideoPlayerState extends State<CreatRequestVideoPlayer> {
  var videoPlayerController;
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.file(widget.video)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: true,
        );
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _chewieController != null &&
              _chewieController?.videoPlayerController.value != null
          ? Chewie(
              controller: _chewieController,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading'),
              ],
            ),
    );
  }
}
