import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:the_singing_bird/category.dart';
import 'package:the_singing_bird/inherited.dart';
import 'package:the_singing_bird/singer.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

final _categories = <Category>[];

class SongSelectorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongSelectorScreenState();
}

class SongSelectorScreenState extends State<SongSelectorScreen> {
  Widget _showScreen;

  @override
  void initState() {
    super.initState();
    _showScreen = _buildCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return _showScreen;
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
      setState(() {
        _showScreen = _buildCategoryList();
      });
    }
  }

  /// Retrieves a list of [Categories] and their [Unit]s
  Future<void> _retrieveLocalCategories() async {
    final json =
        DefaultAssetBundle.of(context).loadString('assets/data/songs.json');
    final data = JsonDecoder().convert(await json);
    if (data is! Map) {
      throw ('Data retrieved from API is not a Map');
    }
    data.keys.forEach((key) {
      final List<Singer> singers =
          data[key].map<Singer>((i) => Singer.fromJSON(i)).toList();
      var category = Category(name: key, singers: singers);

      _categories.add(category);
    });

    _sortDataAlphabetically();
  }

  void _sortDataAlphabetically() {
    _categories.sort((a, b) => a.name.compareTo(b.name));
    for (Category category in _categories) {
      category.singers.sort((a, b) => a.name.compareTo(b.name));
      for (Singer singer in category.singers) {
        singer.songs.sort((a, b) => a.title.compareTo(b.title));
      }
    }
  }

  Widget _buildSongList(String title, int categoryIndex, int singerIndex) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    final ScrollController controller = ScrollController();
    final songsList = _categories[categoryIndex].singers[singerIndex].songs;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: GestureDetector(
              onTap: () {
                setState(() {
                  _showScreen = _buildSingerList(title, categoryIndex);
                });
              },
              child: Icon(Icons.arrow_back)),
        ),
        body: DraggableScrollbar.semicircle(
          alwaysVisibleScrollThumb: true,
          controller: controller,
          labelTextBuilder: (double offset) => Text(
                "${songsList[min(offset ~/ 55.0, songsList.length - 1)].title.substring(0,1)}",
                style: TextStyle(color: Colors.black),
              ),
          scrollbarTimeToFade: Duration(seconds: 1),
          child: ListView.builder(
              controller: controller,
              itemCount: songsList.length,
              itemBuilder: (context, int) {
                var song = songsList[int];
                return InkWell(
                  splashColor: Colors.lightBlueAccent,
                  onTap: () {
                    setState(() {
                      state.addSong(song);
                      //TODO check if duplicate song added
                    });
                    final snackBar = SnackBar(
                      duration: const Duration(seconds: 1),
                      //TODO fix so that snackbar does not duplicate
                      content: Text("Song added to queue"),
                    );

                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: Divider.createBorderSide(context,
                                color: Colors.black))),
                    child: ListTile(
                      leading: Text(song.title),
                      trailing: GestureDetector(
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  Widget _buildSingerList(String title, int categoryIndex) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              leading: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showScreen = _buildCategoryList();
                    });
                  },
                  child: Icon(Icons.arrow_back)),
            ),
            body: ListView.builder(
                itemCount: _categories[categoryIndex].singers.length,
                itemBuilder: (context, int) {
                  var singerName = _categories[categoryIndex].singers[int].name;

                  return InkWell(
                    splashColor: Colors.lightGreen,
                    onTap: () {
                      setState(() {
                        _showScreen =
                            _buildSongList(singerName, categoryIndex, int);
                      });
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: Divider.createBorderSide(context,
                                  color: Colors.black))),
                      child: ListTile(
                        leading: Text(singerName),
                      ),
                    ),
                  );
                })));
  }

  Widget _buildCategoryList() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _categories.length,
          itemBuilder: (context, int) {
            var categoryName = _categories[int].name;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _showScreen = _buildSingerList(categoryName, int);
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: SizedBox(
                    height: 120.0,
                    width: 150.0,
                    child: Center(
                        child: Text(
                      categoryName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<bool> _onWillPop() {
    return _buildCategoryList() ?? false;
  }
}
