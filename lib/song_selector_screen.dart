import 'package:flutter/material.dart';

class SongSelectorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongSelectorScreenState();
}

class SongSelectorScreenState extends State<SongSelectorScreen> {
  Widget _showScreen;

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
