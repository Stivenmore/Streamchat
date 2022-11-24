import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewVideo extends StatefulWidget {
  final String url;
  const ViewVideo({required this.url, Key? key}) : super(key: key);

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: FlickVideoPlayer(flickManager: flickManager),
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
}
