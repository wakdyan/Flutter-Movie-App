import 'package:flutter/material.dart';
import 'package:movie_app/style/new_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class Shimmering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8, right: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Color(0xfff6f7f9),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.grey,
                    height: 185,
                    width: 125,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, top: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Colors.grey,
                            height: 20,
                            // width: 140,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Container(
                              color: Colors.grey,
                              height: 14,
                              width: MediaQuery.of(context).size.width * .20,
                              // width: 140,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Container(
                              color: Colors.grey,
                              height: 14,
                              // width: MediaQuery.of(context).size.width * .55,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Container(
                              color: Colors.grey,
                              height: 14,
                              // width: MediaQuery.of(context).size.width * .45,
                              // width: 140,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Container(
                              color: Colors.grey,
                              height: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }, childCount: 5),
    );
    return ShimmerEffect();
  }
}
