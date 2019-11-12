import 'package:flutter/material.dart';
import 'package:movie_app/style/text_style.dart';
import 'package:movie_app/view/tv/new_tv.dart';
import 'package:movie_app/view/tv/popular_tv.dart';

class Tv extends StatefulWidget {
  @override
  _TvState createState() => _TvState();
}

class _TvState extends State<Tv> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      key: PageStorageKey("tv"),
      slivers: <Widget>[
        CustomAppBar(),
        NewTv(),
        Subtitle(),
        PopularTv(),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Tv Show', style: appBarStyle),
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
