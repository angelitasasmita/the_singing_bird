import 'package:meta/meta.dart';
import 'package:the_singing_bird/song.dart';

class Singer {
  final String name;
  final List<Song> songs;

  const Singer({
    @required this.name,
    @required this.songs
  })
      : assert(name != null),
        assert(songs != null);


  factory Singer.fromJSON(Map jsonMap){
    var list = jsonMap['songs'] as List;
    final singerName = jsonMap['name'];

    List<Song> songList = list.map((i) => Song.fromJSON(i, singerName)).toList();

    return Singer (
        name: singerName,
        songs: songList
    );
  }

}