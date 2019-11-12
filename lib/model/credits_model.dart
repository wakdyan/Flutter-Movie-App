class Credits {
  String name, profilePath, character;

  Credits({
    this.name,
    this.profilePath,
    this.character,
  });

  Credits.fromJson(Map<String, dynamic> json) {
    var image = json['profile_path'];
    if (image == null) {
      image = "null";
    }

    name = json['name'];
    profilePath = image;
    character = json['character'];
  }
}
