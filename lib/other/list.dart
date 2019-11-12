import 'package:flutter/material.dart';

class ListAja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var movies;
    return SliverToBoxAdapter(
      child: Container(
        height: 500,
        // color: Colors.grey,
        child: SizedBox(
          height: 185,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: movies == null ? 0 : movies.length,
              itemBuilder: (context, index) {
                var imageUrl;
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 185,
                        width: 125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              spreadRadius: 5,
                              offset: Offset(0, 15),
                            ),
                          ],
                          image: DecorationImage(
                              image: NetworkImage(
                                imageUrl + movies[index].posterPath,
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        width: 125,
                        child: Text(
                          movies[index].title,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
