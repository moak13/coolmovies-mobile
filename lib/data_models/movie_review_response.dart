import 'create_movie_review.dart';

class MovieReviewResponse {
  CreateMovieReview? createMovieReview;

  MovieReviewResponse({
    this.createMovieReview,
  });

  MovieReviewResponse.fromJson(Map<String, dynamic> json) {
    createMovieReview = json['createMovieReview'] != null
        ? CreateMovieReview.fromJson(json['createMovieReview'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (createMovieReview != null) {
      data['createMovieReview'] = createMovieReview!.toJson();
    }
    return data;
  }
}
