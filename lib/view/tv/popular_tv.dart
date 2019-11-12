import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/tv_model.dart';
import 'package:movie_app/style/new_shimmer.dart';
import 'package:movie_app/style/popular_shimmer.dart';
import 'package:movie_app/style/text_style.dart';
import 'package:movie_app/view/detail/detail.dart';
// import 'package:movie_app/style/text_style.dart';

class PopularTv extends StatefulWidget {
  @override
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularTv> {
  List<Tv> popularTv = [];

  getPopularTv() async {
    final String apiKey = "1fe418d6e2a945b14dbd5a8ad761891d";
    final String url =
        "https://api.themoviedb.org/3/tv/popular?api_key=${apiKey}&language=en-US";
    var response = await http.get(url);
    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        popularTv = (responseJson['results'] as List)
            .map((p) => Tv.fromJson(p))
            .toList();
        // print(popularTv.length);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPopularTv();
  }

  @override
  Widget build(BuildContext context) {
    if (popularTv.length == 0) {
      return ShimmerPopularEffect();
    } else {
      return SliverList(
        key: PageStorageKey("popular_tv"),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final String imageUrl = "https://image.tmdb.org/t/p/w500";
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (build) => DetailPage(
                              type: "tv",
                              id: popularTv[index].id,
                              title: popularTv[index].title,
                              posterPath: popularTv[index].posterPath,
                              backdropPath: popularTv[index].backdropPath,
                              overview: popularTv[index].overview,
                              popularity: popularTv[index].popularity,
                              voteAverage: popularTv[index].voteAverage),
                        ),
                      ),
                      child: Container(
                        height: 185,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl + popularTv[index].posterPath,
                          fit: BoxFit.cover,
                          placeholder: (context, String) => Image.asset(
                            'assets/movie_placeholder.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 12),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        popularTv[index].title,
                        style: titleStyle,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          childCount: popularTv.length,
        ),
      );
    }
  }
}
