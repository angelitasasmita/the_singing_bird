import 'package:meta/meta.dart';
import 'package:the_singing_bird/singer.dart';

class Song {
  final String title;
  final String link;
  final String singerName;

  const Song({@required this.title, @required this.link, @required this.singerName})
      : assert(title != null),
        assert(link != null),
        assert(singerName != null);

  Song.fromJSON(Map jsonMap, String singerName)
      : assert(jsonMap['title'] != null),
        assert(jsonMap['link'] != null),
        title = jsonMap['title'],
        link = jsonMap['link'],
        singerName = singerName;
}
