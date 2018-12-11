import 'package:flutter/material.dart';
import 'package:the_singing_bird/inherited.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:the_singing_bird/song.dart';

class SongQueueScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongQueueScreenState();
}

class SongQueueScreenState extends State<SongQueueScreen> {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    if (state.songsCount != 0) {
      if(state.songsCount == 1){
        Song song = state.retriveSongs[0];
        return ListTile(
          leading: GestureDetector(
              onTap: () {
                state.removeSong(song);
              },
              child: Icon(Icons.clear)),
          title: Text(song.title),
          subtitle: Text(song.singerName),
          trailing: Icon(Icons.drag_handle),
        );

      } else {
        //TODO: fix draggable up to only include botton container
        return DragAndDropList<Song>(state.retriveSongs,
          itemBuilder: (context, song) {
            return ListTile(
              leading: GestureDetector(
                  onTap: () {
                    state.removeSong(song);
                  },
                  child: Icon(Icons.clear)),
              title: Text(song.title),
              subtitle: Text(song.singerName),
              trailing: Icon(Icons.drag_handle),
            );
          },

          onDragFinish: (before, after) {
            Song song = state.retriveSongs[before];
            state.removeSong(song);
            state.insertSong(after, song);
          },
          canBeDraggedTo: (one, two) => true,
          dragElevation: 8.0,);
      }
    } else
      return Center(child: Text("No songs added :("));
  }
}
