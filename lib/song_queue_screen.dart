import 'package:flutter/material.dart';
import 'package:the_singing_bird/inherited.dart';

class SongQueueScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongQueueScreenState();
}

class SongQueueScreenState extends State<SongQueueScreen> {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    if (state.songsCount != 0) {
      return ListView.builder(
          itemCount: state.songsCount,
          itemBuilder: (context, int) {
            return ListTile(
              leading: GestureDetector(
                  onTap: () {
                    state.removeSong(int);
                  },
                  child: Icon(Icons.clear)),
              title: Text(state.retriveSongs[int].title),
              subtitle: Text(state.retriveSongs[int].singerName),
              trailing: Icon(Icons.dehaze),
            );
          });
    } else
      return Center(child: Text("No songs added :("));
  }
}
