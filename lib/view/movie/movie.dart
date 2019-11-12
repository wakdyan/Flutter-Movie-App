import 'package:flutter/material.dart';
import 'package:movie_app/style/text_style.dart';
import 'package:movie_app/view/movie/new_movie.dart';
import 'package:movie_app/view/movie/popular_movie.dart';

class Movie extends StatefulWidget {
  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: PageStorageKey("movie"),
      slivers: <Widget>[
        CustomAppBar(),
        NewMovie(),
        Subtitle(),
        PopularMovie(),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  String title;
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Movie', style: appBarStyle),
            IconButton(
              icon: Icon(Icons.search, size: 28),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Text(
          'Popular',
          style: subtitleStyle,
        ),
      ),
    );
  }
}
