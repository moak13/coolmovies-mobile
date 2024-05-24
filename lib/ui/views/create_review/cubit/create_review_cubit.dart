import 'package:coolmovies/core/locator.dart';
import 'package:coolmovies/data_models/data_models.dart';
import 'package:coolmovies/exceptions/cool_movies_exception.dart';
import 'package:coolmovies/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_review_state.dart';

class CreateReviewCubit extends Cubit<CreateReviewState> {
  final _moviesService = locator.get<MoviesService>();
  final _handlerService = locator.get<HandlerService>();
  CreateReviewCubit() : super(CreateReviewInitial());

  List<int> ratings = [1, 2, 3, 4, 5];

  Future<void> postMovieReview(MovieReviewRequest movieReview) async {
    try {
      emit(CreateReviewLoading());
      final review = await _handlerService.makeNetworkCall<Review?>(
        () async {
          return await _moviesService.postMovieReview(movieReview);
        },
        storageKey: 'postMovieReview',
        fromJson: (json) => Review.fromJson(json),
      );

      emit(CreateReviewLoaded(review: review));
    } on CoolMoviesException catch (e) {
      emit(CreateReviewError(message: e.message));
    } catch (e) {
      emit(const CreateReviewError(message: 'Something went wrong'));
    }
  }

  void disposeState() {
    _handlerService.disposeState();
  }
}
