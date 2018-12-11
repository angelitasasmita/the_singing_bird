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
//      _videoScreen = WebviewScaffold(url: state.retriveSongs[0].link);
      _videoScreen = Container(
        child: Center(child: Text("Playing: " + state.retriveSongs[0].title)),
      );
    }

    return Container(
      height: 300,
      child: _videoScreen,
    );
  }
}
