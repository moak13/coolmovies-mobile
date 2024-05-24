class MovieReviewRequest {
  String? title;
  String? body;
  int? rating;
  String? movieId;
  String? userReviewerId;

  MovieReviewRequest({
    this.title,
    this.body,
    this.rating,
    this.movieId,
    this.userReviewerId,
  });
}
