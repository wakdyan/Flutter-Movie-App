import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/tv_model.dart';
import 'package:movie_app/other/shimmer.dart';
import 'package:movie_app/style/new_shimmer.dart';
import 'package:movie_app/style/popular_shimmer.dart';

import 'package:movie_app/style/text_style.dart';
import 'package:movie_app/view/detail/detail.dart';
// import 'package:movie_app/style/text_style.dart';

class NewTv extends StatefulWidget {
  @override
  _TvItemState createState() => _TvItemState();
}

class _TvItemState extends State<NewTv> {
  List<Tv> newTv = [];

  getNewMovie() async {
    final String apiKey = "1fe418d6e2a945b14dbd5a8ad761891d";
    final String urlNew =
        "https://api.themoviedb.org/3/tv/on_the_air?api_key=${apiKey}&language=en-US";
    var response = await http.get(urlNew);
    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        newTv = (responseJson['results'] as List)
            .map((p) => Tv.fromJson(p))
            .toList();
        // print(newTv.length);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNewMovie();
  }

  @override
  Widget build(BuildContext context) {
    if (newTv.length == 0) {
      return ShimmerEffect();
    } else {
      return SliverToBoxAdapter(
        key: PageStorageKey("new_tv"),
        child: Container(
          height: 225,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: newTv == null ? 0 : newTv.length,
              itemBuilder: (context, index) {
                final String imageUrl = "https://image.tmdb.org/t/p/w185";
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (build) => DetailPage(
                                  type: "tv",
                                  id: newTv[index].id,
                                  title: newTv[index].title,
                                  posterPath: newTv[index].posterPath,
                                  backdropPath: newTv[index].backdropPath,
                                  overview: newTv[index].overview,
                                  popularity: newTv[index].popularity,
                                  voteAverage: newTv[index].voteAverage),
                            ),
                          ),
                          child: Container(
                            height: 185,
                            width: 125,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl + newTv[index].posterPath,
                              placeholder: (context, String) =>
                                  Image.asset('assets/movie_placeholder.png'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 125,
                        child: Text(
                          newTv[index].title,
                          style: titleStyle,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      );
    }
  }
}
