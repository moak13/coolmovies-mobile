import 'movie.dart';

class AllMovies {
  List<Movie>? movies;

  AllMovies({
    this.movies,
  });

  AllMovies.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      movies = <Movie>[];
      json['nodes'].forEach((v) {
        movies!.add(Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (movies != null) {
      data['nodes'] = movies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
