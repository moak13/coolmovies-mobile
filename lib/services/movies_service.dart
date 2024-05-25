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

    AllMoviesResponseDataModel allMoviesResponseDataModel =
        AllMoviesResponseDataModel.fromJson(json);

    return allMoviesResponseDataModel.allMovies?.movies;
  }

  Future<List<Review>?> fetchMovieReviews(String movieId) async {
    final json = await _graphQlService.performQuery(
      query: Fixtures.fetchMovieReviews(movieId),
    );

    AllMovieReviewsResponse allMovieReviewsResponse =
        AllMovieReviewsResponse.fromJson(json);
    return allMovieReviewsResponse.allMovieReviews?.reviews;
  }

  Future<Review?> postMovieReview(MovieReviewRequest movieReview) async {
    final json = await _graphQlService.performMutate(
      mutate: Fixtures.postMovieReview(movieReview),
    );

    MovieReviewResponse movieReviewResponse =
        MovieReviewResponse.fromJson(json);
    return movieReviewResponse.createMovieReview?.review;
  }
}
