import 'package:coolmovies/data_models/movie_review_request.dart';

class Fixtures {
  static String fetchAllMovies = r"""
          query AllMovies {
            allMovies {
              nodes {
                id
                imgUrl
                movieDirectorId
                userCreatorId
                title
                releaseDate
                nodeId
                userByUserCreatorId {
                  id
                  name
                  nodeId
                }
              }
            }
          }
        """;

  static String fetchMovieReviews(String movieId) {
    var res = """
        query {
          allMovieReviews(
            filter: {movieId: {equalTo: "$movieId"}}
          ) {
            nodes {
              title
              body
              rating
              movieByMovieId {
                title
              }
            }
          }
        }
        """;

    return res;
  }

  static String postMovieReview(MovieReviewRequest movieReview) {
    var res = """
            mutation {
              createMovieReview(input: {
                movieReview: {
                  title: "${movieReview.title}",
                  body: "${movieReview.body}",
                  rating: ${movieReview.rating},
                  movieId: "${movieReview.movieId}",
                  userReviewerId: "${movieReview.userReviewerId}"
              }})
            {
            movieReview {
              id
              title
              body
              rating
              movieByMovieId {
                title
              }
              userByUserReviewerId {
                name
              }
            }
          }
        }
        """;

    return res;
  }
}
