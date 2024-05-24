import 'package:coolmovies/services/services.dart';
import 'package:coolmovies/utils/graph_ql_client.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<GraphQlService>(
    () => GraphQlService(
      graphQLClient: createGraphQLClient(),
    ),
  );
  locator.registerSingleton<QueueService>(QueueService());
  locator.registerLazySingleton<StorageService>(() => StorageService());
}
