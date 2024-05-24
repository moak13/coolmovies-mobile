import 'all_movies.dart';

class AllMoviesResponseDataModel {
  AllMovies? allMovies;

  AllMoviesResponseDataModel({
    this.allMovies,
  });

  AllMoviesResponseDataModel.fromJson(Map<String, dynamic> json) {
    allMovies = json['allMovies'] != null
        ? AllMovies.fromJson(json['allMovies'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allMovies != null) {
      data['allMovies'] = allMovies!.toJson();
    }
    return data;
  }
}
