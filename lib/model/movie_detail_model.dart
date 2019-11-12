class DetailModel {
  int id;
  double voteAverage;
  String genre;

  DetailModel({this.id, this.voteAverage, this.genre});

  DetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteAverage = json['vote_average'];
    genre = json['name'];
  }
}
