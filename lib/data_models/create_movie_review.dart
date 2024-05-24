import 'review.dart';

class CreateMovieReview {
  Review? review;

  CreateMovieReview({
    this.review,
  });

  CreateMovieReview.fromJson(Map<String, dynamic> json) {
    review = json['movieReview'] != null
        ? Review.fromJson(json['movieReview'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (review != null) {
      data['movieReview'] = review!.toJson();
    }
    return data;
  }
}
