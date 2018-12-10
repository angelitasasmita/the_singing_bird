import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:the_singing_bird/inherited.dart';

final _API_KEY = "AIzaSyDmissqr2kSD0ywG6r9GCr0DxCDqIOzq90";

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

    return Column(
      children: <Widget>[
        Container(
          height: 300,
          child: _videoScreen,
        ),
        FloatingActionButton(
          child: Icon(Icons.skip_next),
          onPressed: (){
            setState(() {
              state.removeSong(state.retriveLatestSong);
              _videoScreen = WebviewScaffold(url: state.retriveLatestSong.link);

            });
          },
        )
      ],
    );
  }
}
