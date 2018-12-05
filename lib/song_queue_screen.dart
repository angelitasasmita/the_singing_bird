import 'package:flutter/material.dart';

class SongQueueScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongQueueScreenState();

}

class SongQueueScreenState extends State<SongQueueScreen> {
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