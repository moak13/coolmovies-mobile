import 'all_movie_reviews.dart';

class AllMovieReviewsResponse {
  AllMovieReviews? allMovieReviews;

  AllMovieReviewsResponse({
    this.allMovieReviews,
  });

  AllMovieReviewsResponse.fromJson(Map<String, dynamic> json) {
    allMovieReviews = json['allMovieReviews'] != null
        ? AllMovieReviews.fromJson(json['allMovieReviews'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allMovieReviews != null) {
      data['allMovieReviews'] = allMovieReviews!.toJson();
    }
    return data;
  }
}
