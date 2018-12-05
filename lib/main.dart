import 'package:flutter/material.dart';
import 'package:the_singing_bird/user_menu_screen.dart';
import 'package:the_singing_bird/video_player_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Singing Bird',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BaseWidget(title: 'The Singing Bird'),
    );
  }
}

class BaseWidget extends StatefulWidget {
  BaseWidget({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            VideoPlayerScreen(),
            UserMenuScreen(),
          ],
        ),
      ),
    );
  }
}
