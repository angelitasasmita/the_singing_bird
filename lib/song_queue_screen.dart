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
      final List<Text> listTextSample = <Text>[
        Text(
          'hi',
          key: Key('12Hi'),
          style: Theme.of(context).textTheme.title,
        ),
        Text(
          'buy',
          key: Key('132jo'),
          style: Theme.of(context).textTheme.title,
        )
      ];
//      return ReorderableListView(
//          children: listTextSample,
//          onReorder: (oldIndex, newIndex) {
//            if (oldIndex < newIndex) {
//              // removing the item at oldIndex will shorten the list by 1.
//              newIndex -= 1;
//            }
//            final Text element = listTextSample.removeAt(oldIndex);
//            listTextSample.insert(newIndex, element);
//          });

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
          trailing: Icon(Icons.dehaze),
        );

      } else {
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
              trailing: Icon(Icons.dehaze),
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


//      return ListView.builder(
//          itemCount: state.songsCount,
//          itemBuilder: (context, int) {
//            return ListTile(
//              leading: GestureDetector(
//                  onTap: () {
//                    state.removeSong(int);
//                  },
//                  child: Icon(Icons.clear)),
//              title: Text(state.retriveSongs[int].title),
//              subtitle: Text(state.retriveSongs[int].singerName),
//              trailing: Icon(Icons.dehaze),
//            );
//          });
    } else
      return Center(child: Text("No songs added :("));
  }
}
