import 'package:coolmovies/core/locator.dart';
import 'package:coolmovies/data_models/data_models.dart';
import 'package:coolmovies/services/services.dart';
import 'package:coolmovies/utils/fixtures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

void main() {
  group('GraphQlServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });

  Map<String, dynamic> data = {
    'movies': [
      {'id': '1', 'title': 'Movie 1'}
    ]
  };

  final mockGraphQlClient = MockGraphQLClient();
  final mockGraphQlService = GraphQlService(
    graphQLClient: mockGraphQlClient,
  );

  group('performQuery -', () {
    test(
      'returns successful data when called',
      () async {
        when(
          mockGraphQlClient.query(any),
        ).thenAnswer(
          (_) async => QueryResult(
            options: QueryOptions(
              document: gql(Fixtures.fetchAllMovies),
            ),
            data: data,
            source: QueryResultSource.network,
          ),
        );
        final request = await mockGraphQlService.performQuery(
            query: Fixtures.fetchAllMovies);
        expect(request, data);
      },
    );
    test(
      'returns an exception when called',
      () {},
    );
  });

  group('performMutate -', () {
    MovieReviewRequest movieReviewRequest = MovieReviewRequest(
      title: 'title',
      body: 'body',
      rating: 0,
      movieId: 'movieId',
      userReviewerId: 'userReviewerId',
    );
    test('returns successful data when called', () async {
      when(
        mockGraphQlClient.mutate(any),
      ).thenAnswer(
        (_) async => QueryResult(
          options: QueryOptions(
            document: gql(Fixtures.postMovieReview(movieReviewRequest)),
          ),
          data: data,
          source: QueryResultSource.network,
        ),
      );
      final request = await mockGraphQlService.performMutate(
        mutate: Fixtures.postMovieReview(movieReviewRequest),
      );
      expect(request, data);
    });

    test('returns an exception when called', () {});
  });
}
