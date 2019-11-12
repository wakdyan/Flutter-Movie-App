import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/style/new_shimmer.dart';
import 'package:movie_app/style/popular_shimmer.dart';
import 'package:movie_app/style/text_style.dart';
import 'package:movie_app/view/detail/detail.dart';
// import 'package:movie_app/style/text_style.dart';

class PopularMovie extends StatefulWidget {
  @override
  _PopularMovieState createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie> {
  List<Movies> moviePopular = [];

  getPopularMovie() async {
    final String apiKey = "1fe418d6e2a945b14dbd5a8ad761891d";
    final String url =
        "https://api.themoviedb.org/3/movie/popular?api_key=${apiKey}&language=en-US";
    var response = await http.get(url);
    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        moviePopular = (responseJson['results'] as List)
            .map((p) => Movies.fromJson(p))
            .toList();
        // print(moviePopular.length);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPopularMovie();
  }

  @override
  Widget build(BuildContext context) {
    if (moviePopular.length == 0) {
      return ShimmerPopularEffect();
    } else {
      return SliverList(
        key: PageStorageKey("popular_movie"),
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
                          builder: (context) => DetailPage(
                            type: "movie",
                            id: moviePopular[index].id,
                            title: moviePopular[index].title,
                            posterPath: moviePopular[index].posterPath,
                            backdropPath: moviePopular[index].backdropPath,
                            overview: moviePopular[index].overview,
                            popularity: moviePopular[index].popularity,
                            voteAverage: moviePopular[index].voteAverage,
                          ),
                        ),
                      ),
                      child: Container(
                        height: 185,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl + moviePopular[index].posterPath,
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
                        moviePopular[index].title.toUpperCase(),
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
          childCount: moviePopular.length,
        ),
      );
    }
  }
}
