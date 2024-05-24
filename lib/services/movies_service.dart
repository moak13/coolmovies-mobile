import 'package:coolmovies/core/locator.dart';
import 'package:coolmovies/data_models/data_models.dart';
import 'package:coolmovies/services/graph_ql_service.dart';
import 'package:coolmovies/utils/fixtures.dart';

class MoviesService {
  final _graphQlService = locator.get<GraphQlService>();

  Future<List<Movie>?> fetchMovies() async {
    final json = await _graphQlService.performQuery(
      query: Fixtures.fetchAllMovies,
    );

    if (json == null) return [];
    AllMoviesResponseDataModel allMoviesResponseDataModel =
        AllMoviesResponseDataModel.fromJson(json);

    return allMoviesResponseDataModel.allMovies?.movies;
  }
}