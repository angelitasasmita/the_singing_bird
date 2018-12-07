import 'package:flutter/material.dart';
import 'package:the_singing_bird/song.dart';

class _MyInherited extends InheritedWidget {
  _MyInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final MyInheritedWidgetState data;

  @override
  bool updateShouldNotify(_MyInherited oldWidget) {
    return true;
  }
}

class MyInheritedWidget extends StatefulWidget {
  MyInheritedWidget({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  MyInheritedWidgetState createState() => MyInheritedWidgetState();

  static MyInheritedWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_MyInherited) as _MyInherited)
        .data;
  }
}

class MyInheritedWidgetState extends State<MyInheritedWidget> {

  List<Song> _songs = <Song>[];

  int get songsCount => _songs.length;

  List<Song> get retriveSongs => _songs;

  void removeSong(Song song){
    setState(() {
      _songs.remove(song);
    });
  }

  void addSong(Song song){
    setState(() {
      _songs.add(song);
    });
  }

  void insertSong(int index, Song song){
    setState(() {
      _songs.insert(index, song);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInherited(
      data: this,
      child: widget.child,
    );
  }
}
