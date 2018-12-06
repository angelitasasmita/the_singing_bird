import 'package:meta/meta.dart';
import 'package:the_singing_bird/singer.dart';

class Category {
  final String name;
  final List<Singer> singers;

  const Category({
    @required this.name,
    @required this.singers
  })
      : assert(name != null),
        assert(singers != null);


//  Category.fromJson(Map jsonMap)
//      : assert(jsonMap['name'] != null),
//        assert(jsonMap['singer'] != null),
//        name = jsonMap['name'],
//        singer = jsonMap['singer'];
}