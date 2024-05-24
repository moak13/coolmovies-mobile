import 'dart:io';

import 'package:coolmovies/exceptions/cool_movies_exception.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlService {
  final GraphQLClient graphQLClient;

  GraphQlService({
    required this.graphQLClient,
  });

  Future<Map<String, dynamic>?> performQuery({
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

  Future<Map<String, dynamic>?> performMutate({
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

  Future<Map<String, dynamic>?> _performOperation(
    Future<QueryResult> Function() operation,
  ) async {
    try {
      final result = await operation();
      if (result.hasException) {
        throw CoolMoviesException(
          message:
              'Seems we have an issue with our server. Kindly restart it and try again.',
        );
      }
      return result.data;
    } on SocketException {
      throw CoolMoviesException(
        message: 'No Internet Connection.',
      );
    } on ServerException {
      throw CoolMoviesException(
        message:
            'Seems we have an issue with our server. Kindly restart it and try again.',
      );
    } catch (e) {
      rethrow;
    }
  }
}
