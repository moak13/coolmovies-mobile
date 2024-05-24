import 'review.dart';

class AllMovieReviews {
  List<Review>? reviews;

  AllMovieReviews({
    this.reviews,
  });

  AllMovieReviews.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      reviews = <Review>[];
      json['nodes'].forEach((v) {
        reviews!.add(Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviews != null) {
      data['nodes'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
