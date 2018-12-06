import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_singing_bird/category.dart';
import 'package:the_singing_bird/singer.dart';
import 'package:the_singing_bird/song.dart';

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
    String _currentScreen = "category";

    return _showScreen;
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
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
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
            itemCount: _categories[categoryIndex].singers[singerIndex].songs.length,
            itemBuilder: (context, int) {
              return ListTile(
                leading: Text(_categories[categoryIndex].singers[singerIndex].songs[int].title),
              );
            }));
  }

  Widget _buildSingerList(String title, int categoryIndex) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
            itemCount: _categories[categoryIndex].singers.length,
            itemBuilder: (context, int) {
              var singerName = _categories[categoryIndex].singers[int].name;

              return ListTile(
                leading: Text(singerName),
                onTap: () {
                  setState(() {
                    _showScreen = _buildSongList(singerName, categoryIndex, int);
                  });
                },
              );
            }));
  }

  Widget _buildCategoryList() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Category"),
        ),
        body: ListView.builder(
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
            }));
  }
}
