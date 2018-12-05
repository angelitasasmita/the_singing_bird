import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoPlayerScreenState();


}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text('hi'),
          Text('hi'),
          Text('hi'),
          Text('hi'),
          Text('hi'),
          Text('hi'),
        ],
      ),
    );
  }

}