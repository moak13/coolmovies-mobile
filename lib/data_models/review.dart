import 'movie_by_movie_id.dart';
import 'user_by_user_id.dart';

class Review {
  String? id;
  String? title;
  String? body;
  int? rating;
  MovieByMovieId? movieByMovieId;
  UserByUserId? userByUserReviewerId;

  Review({
    this.id,
    this.title,
    this.body,
    this.rating,
    this.movieByMovieId,
    this.userByUserReviewerId,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    rating = json['rating'];
    movieByMovieId = json['movieByMovieId'] != null
        ? MovieByMovieId.fromJson(json['movieByMovieId'])
        : null;
    userByUserReviewerId = json['userByUserReviewerId'] != null
        ? UserByUserId.fromJson(json['userByUserReviewerId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['rating'] = rating;
    if (movieByMovieId != null) {
      data['movieByMovieId'] = movieByMovieId!.toJson();
    }
    if (userByUserReviewerId != null) {
      data['userByUserReviewerId'] = userByUserReviewerId!.toJson();
    }
    return data;
  }
}
