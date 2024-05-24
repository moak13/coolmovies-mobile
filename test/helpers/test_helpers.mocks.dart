import 'package:coolmovies/services/services.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivityService extends Mock implements ConnectivityService {}

class MockGraphQlService extends Mock implements GraphQlService {}

class MockHandlerService extends Mock implements HandlerService {}

class MockMoviesService extends Mock implements MoviesService {}

class MockQueueService extends Mock implements QueueService {}

class MockStorageService extends Mock implements StorageService {}
