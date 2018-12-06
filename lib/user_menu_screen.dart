import 'package:flutter/material.dart';
import 'package:the_singing_bird/song_queue_screen.dart';
import 'package:the_singing_bird/song_selector_screen.dart';

class UserMenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserMenuScreenState();
}

class UserMenuScreenState extends State<UserMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
      appBar: AppBar(
        title: Text('Song Queue'),
      ),
      drawer: Drawer(
        child: SongSelectorScreen(),
      ),
      body: SongQueueScreen(),
    ));
  }
}
