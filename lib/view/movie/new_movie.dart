import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/style/new_shimmer.dart';
import 'package:movie_app/style/text_style.dart';
import 'package:movie_app/view/detail/detail.dart';
import 'package:movie_app/view/detail/item/detail_item.dart';

class NewMovie extends StatefulWidget {
  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<NewMovie> {
  List<Movies> moviePopular = [];

  getNewMovie() async {
    final String apiKey = "1fe418d6e2a945b14dbd5a8ad761891d";
    final String urlNew =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=${apiKey}&language=en-US";
    var response = await http.get(urlNew);
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
    getNewMovie();
  }

  @override
  Widget build(BuildContext context) {
    if (moviePopular.length == 0) {
      return ShimmerEffect();
    } else {
      return SliverToBoxAdapter(
        child: Container(
          height: 225,
          child: ListView.builder(
              key: PageStorageKey("new_movie"),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: moviePopular == null ? 0 : moviePopular.length,
              itemBuilder: (context, index) {
                final String imageUrl = "https://image.tmdb.org/t/p/w185";
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 185,
                            width: 125,
                            child: CachedNetworkImage(
                              imageUrl:
                                  imageUrl + moviePopular[index].posterPath,
                              placeholder: (context, url) =>
                                  Image.asset('assets/movie_placeholder.png'),
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          child: Text(
                            moviePopular[index].title.toUpperCase(),
                            style: titleStyle,
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (build) => DetailPage(
                          type: "movie",
                          id: moviePopular[index].id,
                          title: moviePopular[index].title,
                          posterPath: moviePopular[index].posterPath,
                          backdropPath: moviePopular[index].backdropPath,
                          overview: moviePopular[index].overview,
                          popularity: moviePopular[index].popularity,
                          voteAverage: moviePopular[index].voteAverage),
                    ),
                  ),
                );
              }),
        ),
      );
    }
  }
}
