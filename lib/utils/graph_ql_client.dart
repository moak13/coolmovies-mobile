import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient createGraphQLClient() {
  final url = Platform.isAndroid
      ? 'http://10.0.2.2:5001/graphql'
      : 'http://localhost:5001/graphql';
  final HttpLink httpLink = HttpLink(url);

  return GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
}

ValueNotifier<GraphQLClient> client = ValueNotifier(createGraphQLClient());
