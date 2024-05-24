class MovieByMovieId {
  String? title;

  MovieByMovieId({
    this.title,
  });

  MovieByMovieId.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    return data;
  }
}
