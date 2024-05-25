import 'package:coolmovies/exceptions/cool_movies_exception.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlService {
  final GraphQLClient graphQLClient;

  GraphQlService({
    required this.graphQLClient,
  });

  Future<Map<String, dynamic>> performQuery({
    required String query,
  }) async {
    return _performOperation(
      () => graphQLClient.query(
        QueryOptions(
          document: gql(query),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> performMutate({
    required String mutate,
  }) async {
    return _performOperation(
      () => graphQLClient.mutate(
        MutationOptions(
          document: gql(mutate),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _performOperation(
    Future<QueryResult> Function() operation,
  ) async {
    try {
      final result = await operation();
      if (result.hasException) {
        if (result.exception?.linkException is RequestFormatException) {
          final message =
              (result.exception?.linkException as RequestFormatException)
                  .originalException
                  .toString();
          throw CoolMoviesException(
            message: message,
          );
        }

        if (result.exception?.linkException is ResponseFormatException) {
          final message =
              (result.exception?.linkException as ResponseFormatException)
                  .originalException
                  .toString();
          throw CoolMoviesException(
            message: message,
          );
        }

        if (result.exception?.linkException is ContextReadException) {
          final message =
              (result.exception?.linkException as ContextReadException)
                  .originalException
                  .toString();
          throw CoolMoviesException(
            message: message,
          );
        }

        if (result.exception?.linkException is ContextWriteException) {
          final message =
              (result.exception?.linkException as ContextWriteException)
                  .originalException
                  .toString();
          throw CoolMoviesException(
            message: message,
          );
        }

        if (result.exception?.linkException is ServerException) {
          final message = (result.exception?.linkException as ServerException)
              .originalException
              .toString();
          throw CoolMoviesException(
            message: message,
          );
        }

        throw CoolMoviesException(
          message: 'Unknown error has occured!',
        );
      }
      final data = result.data;
      if (data == null) return {};

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
