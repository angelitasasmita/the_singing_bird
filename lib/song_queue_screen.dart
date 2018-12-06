import 'package:flutter/material.dart';
import 'package:the_singing_bird/song.dart';

class SongQueueScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongQueueScreenState();
}

class SongQueueScreenState extends State<SongQueueScreen> {
  final List<Song> _songQueue = <Song>[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_songQueue.isNotEmpty) {
      return ListView.builder(itemBuilder: (context, int) {
        return ListTile(
          leading: Text(_songQueue[int].title),
          title: Text(_songQueue[int].singerName),
        );
      });
    } else
      return Center(child: Text("No songs added :("));
  }
}
