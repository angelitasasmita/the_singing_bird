import 'package:flutter/material.dart';
import 'package:the_singing_bird/song.dart';

class SongQueueScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongQueueScreenState();

}

class SongQueueScreenState extends State<SongQueueScreen> {
  final List<Song> songQueue = <Song>[];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <ListTile>[
        ListTile(
          title: Text('hi'),
        ),
        ListTile(
          title: Text('hi'),
        )
      ],
    );
  }

}