import 'package:coolmovies/core/locator.dart';
import 'package:coolmovies/data_models/data_models.dart';
import 'package:coolmovies/exceptions/cool_movies_exception.dart';
import 'package:coolmovies/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final _moviesService = locator.get<MoviesService>();
  final _handlerService = locator.get<HandlerService>();

  MoviesCubit() : super(MoviesInitial());

  Future<void> fetchMovies() async {
    try {
      emit(FetchMoviesLoading());
      final movies = await _handlerService.makeNetworkCall<List<Movie>?>(
        () async {
          return await _moviesService.fetchMovies();
        },
        storageKey: 'fetchMovies',
        fromJson: (json) =>
            (json as List).map((item) => Movie.fromJson(item)).toList(),
      );
      emit(FetchMoviesLoaded(movies: movies));
    } on CoolMoviesException catch (e) {
      emit(FetchMoviesError(message: e.message));
    } catch (e) {
      emit(const FetchMoviesError(message: 'Something went wrong'));
    }
  }
}
