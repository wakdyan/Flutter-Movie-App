import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/other/dummy.dart';
import 'package:movie_app/style/text_style.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomAppBar(),
        ScoreBox(),
        ListMovie(),
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
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Profile', style: appBarStyle),
                IconButton(
                  icon: Icon(Icons.settings, size: 28),
                  onPressed: () {
                    print("Intent setting menu");
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://www.flynz.co.nz/wp-content/uploads/profile-placeholder.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Allen Lee',
                style: appBarStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScoreBox extends StatefulWidget {
  @override
  _ScoreBoxState createState() => _ScoreBoxState();
}

class _ScoreBoxState extends State<ScoreBox> {
  var selectedMenu = "Like";
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          height: 130,
          // color:Colors.amber,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1.2),
            itemCount: labelList.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: getSelectedMenu(labelList[index], scoreList[index]));
            },
          )),
    );
  }

  getSelectedMenu(String labelList, scoreList) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMenu = labelList;
          print(selectedMenu);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: selectedMenu == labelList
              ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  )
                ]
              : null,
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(scoreList,
                style: selectedMenu == labelList
                    ? selectedScoreStyle
                    : unselectedScoreStyle),
            Text(labelList, style: labelStyle),
          ],
        ),
      ),
    );
  }
}

class ListMovie extends StatefulWidget {
  @override
  _ListMovieState createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
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
      
      return SliverToBoxAdapter(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepOrangeAccent,
              ),
            ),
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            height: MediaQuery.of(context).size.height ,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: moviePopular.length ,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                childAspectRatio: .8,
              ),
              // itemCount: moviePopular.length,
              itemBuilder: (context, index) {
                final String imageUrl = "https://image.tmdb.org/t/p/w154";
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          )
                        ],
                        // image: DecorationImage(
                        //     image: NetworkImage(
                        //         imageUrl + moviePopular[index].posterPath),
                        //     fit: BoxFit.cover),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl + moviePopular[index].posterPath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          'assets/movie_placeholder.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
