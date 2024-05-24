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
}
