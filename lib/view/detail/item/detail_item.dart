import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/style/text_style.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailItem extends StatefulWidget {
  int id;
  double popularity, voteAverage;
  String title, overview, backdropPath, posterPath;

  DetailItem({
    this.id,
    this.popularity,
    this.voteAverage,
    this.title,
    this.overview,
    this.backdropPath,
    this.posterPath,
  });

  @override
  _DetailItemState createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  List<DetailModel> detail = [];
  // var id;
  final String apiKey = "1fe418d6e2a945b14dbd5a8ad761891d";

  // getDetail(id) async {
  //   print(id);
  //   // final String urlDetail =
  //   //     "https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=en-US";

  //   // var response = await http.get(urlDetail);
  //   // var responseJson = jsonDecode(response.body);

  //   // if (response.statusCode == 200) {
  //   //   setState(() {
  //   //     detail = responseJson['genres'] as List
  //   //       ..map((f) => DetailModel.fromJson(f))
  //   //       ..toList();
  //   //   });
  //   // }
  // }

  @override
  void initState() {
    super.initState();
    // id = widget.id;
    // getDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    var pathBackdropUrl = "https://image.tmdb.org/t/p/w500";
    var pathPosterUrl = "https://image.tmdb.org/t/p/w154";

    double rating = widget.voteAverage;
    double value;
    if (rating == 10) {
      value = 5;
    } else if (rating < 10.0 && rating >= 9.0) {
      value = 4.4;
    } else if (rating < 9.0 && rating >= 8.0) {
      value = 4.0;
    } else if (rating < 8.0 && rating >= 7.0) {
      value = 3.4;
    } else if (rating < 7.0 && rating >= 6.0) {
      value = 3.0;
    } else if (rating < 6.0 && rating >= 5.0) {
      value = 2.4;
    } else if (rating < 5.0 && rating >= 4.0) {
      value = 2.0;
    } else if (rating < 4.0 && rating >= 3.0) {
      value = 1.4;
    } else if (rating < 3.0 && rating >= 2.0) {
      value = 1.0;
    } else if (rating < 2.0 && rating >= 1.0) {
      value = 0.4;
    } else {
      value = 0.0;
    }

    return Scaffold(
      body: SliverToBoxAdapter(
        child: Container(
          height: 50,
          width: 50,
          child: Text(widget.id.toString()),
        ),
      ),
    );
  }
}
