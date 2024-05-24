part of 'create_review_cubit.dart';

sealed class CreateReviewState extends Equatable {
  const CreateReviewState();
}

final class CreateReviewInitial extends CreateReviewState {
  @override
  List<Object> get props => [];
}

final class CreateReviewLoading extends CreateReviewState {
  @override
  List<Object> get props => [];
}

final class CreateReviewLoaded extends CreateReviewState {
  final Review? review;
  const CreateReviewLoaded({this.review});
  @override
  List<Object?> get props => [review];
}

final class CreateReviewError extends CreateReviewState {
  final String? message;
  const CreateReviewError({this.message});
  @override
  List<Object?> get props => [message];
}
