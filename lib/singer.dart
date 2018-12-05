import 'package:meta/meta.dart';
import 'package:the_singing_bird/song.dart';

class Singer {
  final String name;
  final Song song;

  const Singer({
    @required this.name,
    @required this.song
  })
      : assert(name != null),
        assert(song != null);


  Singer.fromJson(Map jsonMap)
      : assert(jsonMap['name'] != null),
        assert(jsonMap['son'] != null),
        name = jsonMap['name'],
        song = jsonMap['song'];
}