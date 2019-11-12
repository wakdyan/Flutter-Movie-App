import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/credits_model.dart';
import 'package:movie_app/style/text_style.dart';
import 'package:movie_app/model/movie_detail_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailPage extends StatefulWidget {
  int id;
  double popularity, voteAverage;
  String posterPath, title, backdropPath, overview, type;

  DetailPage({
    this.id,
    this.posterPath,
    this.title,
    this.backdropPath,
    this.overview,
    this.popularity,
    this.voteAverage,
    this.type,
  });
  // String genresss = id.toString();

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<DetailModel> movieGenre = [];
  List<Credits> credits = [];

  var id, type;

  final String apiKey = "1fe418d6e2a945b14dbd5a8ad761891d";

  getGenre(int id, String type) async {
    final String urlDetail =
        "https://api.themoviedb.org/3/$type/$id?api_key=$apiKey&language=en-US";

    var response = await http.get(urlDetail);
    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        movieGenre = (responseJson['genres'] as List)
            .map((p) => DetailModel.fromJson(p))
            .toList();
      });
    }
    print(movieGenre.length);
  }

  getCredits(int id, String type) async {
    final String urlCredits =
        "https://api.themoviedb.org/3/$type/$id/credits?api_key=$apiKey&language=en-US";

    var response = await http.get(urlCredits);
    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        credits = (responseJson['cast'] as List)
            .map((p) => Credits.fromJson(p))
            .toList();
      });
    }
    print(credits.length);
  }

  @override
  void initState() {
    super.initState();

    id = widget.id;
    type = widget.type;

    getGenre(id, type);
    getCredits(id, type);
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 470,
                color: Colors.white,
                // width: MediaQuery.of(context).size.width / 2,
                child: Stack(
                  children: <Widget>[
                    Container(
                        height: 281,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                pathBackdropUrl + widget.backdropPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.deepOrangeAccent,
                                      Colors.deepOrange,
                                      Color(0xffe93a60)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                shape: BoxShape.circle),
                            child: IconButton(
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () => print("Play")),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context)),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          onPressed: () => print("Share"),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 220,
                      left: 10,
                      child: Container(
                        height: 142,
                        width: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image:
                                NetworkImage(pathPosterUrl + widget.posterPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 220,
                      left: 115,
                      child: Container(
                        height: 60,
                        width: 230,
                        // color: Colors.grey,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.title.toUpperCase(),
                            style: detailTitleStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 290,
                      left: 115,
                      child: Container(
                        width: 230,
                        child: RichText(
                          text: TextSpan(
                              text: widget.popularity.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [
                                TextSpan(
                                    text: " People watching",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal))
                              ]),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 305,
                      left: 115,
                      child: Container(
                        height: 20,
                        width: 230,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: movieGenre.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: <Widget>[
                                Text(movieGenre[index].genre),
                                Text(' ')
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 340,
                      left: 115,
                      child: Row(
                        children: <Widget>[
                          Container(
                            // height: 60,
                            // width: 230,
                            // color: Colors.grey,
                            child: Text(
                              widget.voteAverage.toString(),
                              // movieGenre.genre,
                              style: detailAverageStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          SmoothStarRating(
                            allowHalfRating: true,
                            // onRatingChanged: (index) {

                            //   return index;
                            // },
                            rating: value,
                            size: 18,
                            starCount: 5,
                            borderColor: Colors.grey,
                            color: Colors.deepOrangeAccent,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 370,
                      left: 10,
                      right: 10,
                      child: Container(
                        // height: 20,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          widget.overview,
                          maxLines: 5,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                child: Text(
                  "Full Cast & Crew",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(left: 10),
                height: 138,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: credits.length,
                  itemBuilder: (context, index) {
                    var posterImage = CachedNetworkImage(
                      imageUrl: pathPosterUrl + credits[index].profilePath,
                      placeholder: (context, url) => Image.asset(
                        'assets/profile_placeholder.png',
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                    );

                    var posterAssets = Image.asset(
                      'assets/profile_placeholder.png',
                      fit: BoxFit.cover,
                    );

                    return Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 90,
                              width: 66,
                              child: credits[index].profilePath != "null"
                                  ? posterImage
                                  : posterAssets,
                            ),
                          ),
                          Container(
                            width: 66,
                            child: Text(
                              credits[index].name,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  offset: Offset(0, 5),
                                )
                              ]),
                          child: IconButton(
                            icon: Icon(Icons.thumb_up, color: Colors.black26),
                            iconSize: 30,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () => print("Like"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'LIKE',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black45,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  offset: Offset(0, 5),
                                )
                              ]),
                          child: IconButton(
                            icon: Icon(Icons.star, color: Colors.black26),
                            iconSize: 30,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () => print("Favorite"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'FAVORITE',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black45,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  offset: Offset(0, 5),
                                )
                              ]),
                          child: IconButton(
                            icon: Icon(Icons.sms, color: Colors.black26),
                            iconSize: 30,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () => print("Comment"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'COMMENT',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black45,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
