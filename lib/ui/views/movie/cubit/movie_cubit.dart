import 'package:coolmovies/core/locator.dart';
import 'package:coolmovies/data_models/data_models.dart';
import 'package:coolmovies/exceptions/cool_movies_exception.dart';
import 'package:coolmovies/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final _moviesService = locator.get<MoviesService>();
  final _handlerService = locator.get<HandlerService>();

  MovieCubit() : super(MovieInitial());

  Future<void> fetchMovieReviews(String movieId) async {
    try {
      emit(FetchMovieReviewsLoading());
      final reviews = await _handlerService.makeNetworkCall<List<Review>?>(
        () async {
          return await _moviesService.fetchMovieReviews(movieId);
        },
        storageKey: 'fetchMovieReviews_$movieId',
        fromJson: (json) =>
            (json as List).map((item) => Review.fromJson(item)).toList(),
      );
      emit(FetchMovieReviewsLoaded(reviews: reviews));
    } on CoolMoviesException catch (e) {
      emit(FetchMovieReviewsError(message: e.message));
    } catch (e) {
      emit(const FetchMovieReviewsError(message: 'Something went wrong'));
    }
  }
}
