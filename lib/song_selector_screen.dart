import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_singing_bird/category.dart';
import 'package:the_singing_bird/inherited.dart';
import 'package:the_singing_bird/singer.dart';

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
    _showScreen =_buildCategoryList();
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
  }

  Widget _buildSongList(String title, int categoryIndex, int singerIndex) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
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
        body: ListView.builder(
            itemCount:
                _categories[categoryIndex].singers[singerIndex].songs.length,
            itemBuilder: (context, int) {
              var song = _categories[categoryIndex]
                  .singers[singerIndex]
                  .songs[int];
              return ListTile(
                leading: Text(song.title),
                trailing: GestureDetector(
                  child: Icon(Icons.add),
                  onTap: () {
                    setState(() {
                      state.addSong(song);
                      //TODO add toast - check if duplicate song added
                    });
                    final snackBar = SnackBar(
                      content: Text("Song added to queue"),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                ),
              );
            }));
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

                  return ListTile(
                    leading: Text(singerName),
                    onTap: () {
                      setState(() {
                        _showScreen =
                            _buildSongList(singerName, categoryIndex, int);
                      });
                    },
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
          shrinkWrap: true,
          itemCount: _categories.length,
          itemBuilder: (context, int) {
            var categoryName = _categories[int].name;

            return ListTile(
              leading: Text(categoryName),
              onTap: () {
                setState(() {
                  _showScreen = _buildSingerList(categoryName, int);
                });
              },
            );
          }),
    );
  }

  Future<bool> _onWillPop() {
    return _buildCategoryList() ?? false;
  }
}
