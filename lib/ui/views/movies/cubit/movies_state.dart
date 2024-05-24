part of 'movies_cubit.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();
}

final class MoviesInitial extends MoviesState {
  @override
  List<Object> get props => [];
}

final class FetchMoviesLoading extends MoviesState {
  @override
  List<Object> get props => [];
}

final class FetchMoviesLoaded extends MoviesState {
  final List<Movie>? movies;
  const FetchMoviesLoaded({this.movies});
  @override
  List<Object?> get props => [movies];
}

final class FetchMoviesError extends MoviesState {
  final String? message;
  const FetchMoviesError({this.message});
  @override
  List<Object?> get props => [message];
}
