part of 'movie_cubit.dart';

sealed class MovieState extends Equatable {
  const MovieState();
}

final class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

final class FetchMovieReviewsLoading extends MovieState {
  @override
  List<Object> get props => [];
}

final class FetchMovieReviewsLoaded extends MovieState {
  final List<Review>? reviews;
  const FetchMovieReviewsLoaded({this.reviews});
  @override
  List<Object?> get props => [reviews];
}

final class FetchMovieReviewsError extends MovieState {
  final String? message;
  const FetchMovieReviewsError({this.message});
  @override
  List<Object?> get props => [message];
}
