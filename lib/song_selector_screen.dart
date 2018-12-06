import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_singing_bird/category.dart';
import 'package:the_singing_bird/singer.dart';
import 'package:the_singing_bird/song.dart';

class SongSelectorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongSelectorScreenState();
}

class SongSelectorScreenState extends State<SongSelectorScreen> {
  Widget _showScreen;
  final _categories = <Category>[];

  @override
  void initState(){
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
    print(_categories.length);
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }

  /// Retrieves a list of [Categories] and their [Unit]s
  Future<void> _retrieveLocalCategories() async {
    final json = DefaultAssetBundle
        .of(context)
        .loadString('assets/data/songs.json');
    final data = JsonDecoder().convert(await json);
    if (data is! Map) {
      throw ('Data retrieved from API is not a Map');
    }
    data.keys.forEach((key) {

      final List<Singer> singers = data[key].map<Singer>((i) => Singer.fromJSON(i)).toList();
      var category = Category(
        name: key,
        singers: singers
      );

      _categories.add(category);
    });
  }


  Widget _buildSingerList(String title) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(children: <Widget>[
          ListTile(
            leading: Text(
              'Female Singers',
//              style: Theme.of(context).textTheme.subhead,
            ),
          ),
        ]));
  }

  Widget _buildCategoryList(){
     return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Text(
              'Female Singers',
//              style: Theme.of(context).textTheme.subhead,
            ),
            onTap: () {
              setState(() {
                _showScreen = _buildSingerList("h");
              });
            },
          ),
          ListTile(
            leading: Text('Male Singers'),
          )
        ],
      ),
    );
  }
}
