import 'package:flutter/material.dart';

import 'package:movie_app/view/movie/movie.dart';
import 'package:movie_app/view/setting/setting.dart';
import 'package:movie_app/view/tv/tv.dart';

void main() => runApp(MaterialApp(
      title: 'Movie Catalog',
      home: MyApp(),
      theme: ThemeData(
        accentColor: Colors.black12,
        appBarTheme: AppBarTheme(color: Colors.black87),
      ),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> pages = [Movie(), Tv(), Setting()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: Colors.deepOrangeAccent),
        selectedItemColor: Colors.deepOrangeAccent,
        currentIndex: _currentIndex,
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie), title: Text('MOVIES')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_movies), title: Text('TV SHOWS')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('SETTINGS'))
        ],
      ),
    );
  }

  void _onTapped(index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
  }
}
