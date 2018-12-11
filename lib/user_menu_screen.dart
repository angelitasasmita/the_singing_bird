import 'package:flutter/material.dart';
import 'package:the_singing_bird/inherited.dart';
import 'package:the_singing_bird/song.dart';
import 'package:the_singing_bird/song_queue_screen.dart';
import 'package:the_singing_bird/song_selector_screen.dart';

class UserMenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserMenuScreenState();
}

class UserMenuScreenState extends State<UserMenuScreen> {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);

    return Expanded(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Song Queue'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (state.songsCount != 0) {
                      state.removeFirstSong();
                    }
                  });
                },
                child: Icon(
                  Icons.skip_next,
                  color: Colors.white,
                )),
          )
        ],
      ),
      drawer: Drawer(
        child: SongSelectorScreen(),
      ),
      body: SongQueueScreen(),
    ));
  }
}
