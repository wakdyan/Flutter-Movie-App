class Tv {
  var voteAverage;
  int id;
  double  popularity;
  String title, overview, releaseDate, posterPath, backdropPath;

  Tv(
    this.title,
    this.overview,
    this.releaseDate,
    this.posterPath,
    this.id,
    this.voteAverage,
    this.popularity,
    this.backdropPath,
  );

  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
      json['name'],
      json['overview'],
      json['release_date'],
      json['poster_path'],
      json['id'],
      json['vote_average'],
      json['popularity'],
      json['backdrop_path'],
    );
  }
}
