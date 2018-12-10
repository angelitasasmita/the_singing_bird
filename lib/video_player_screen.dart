import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

final _API_KEY = "AIzaSyDmissqr2kSD0ywG6r9GCr0DxCDqIOzq90";

class VideoPlayerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: WebviewScaffold(url: "https://www.youtube.com/watch?v=HblwLcAR4r4"


//      Container(
//      height: 300,
//        child: FlutterYoutube.playYoutubeVideoByUrl(
//            apiKey: _API_KEY, videoUrl: "https://www.youtube.com/watch?v=HblwLcAR4r4", autoPlay: true)

          ),
    );
  }
}
