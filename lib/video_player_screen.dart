import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:the_singing_bird/inherited.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    Widget _videoScreen;

    if (state.songsCount == 0) {
      _videoScreen = Center(child: Text('No songs playing :('));
    } else {
      _videoScreen = WebviewScaffold(url: state.retriveLatestSong.link);
    }

    return Container(
      height: 300,
      child: _videoScreen,
    );
  }
}
