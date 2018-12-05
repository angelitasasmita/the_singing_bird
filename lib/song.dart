import 'package:meta/meta.dart';

class Song {
  final String title;
  final String link;

  const Song({@required this.title, @required this.link})
      : assert(title != null),
        assert(link != null);

  Song.fromJSON(Map jsonMap)
      : assert(jsonMap['title'] != null),
        assert(jsonMap['link'] != null),
        title = jsonMap['title'],
        link = jsonMap['link'];
}
