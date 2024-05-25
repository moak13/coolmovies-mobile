import 'package:coolmovies/core/locator.dart';
import 'package:coolmovies/services/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/annotations.dart';

import 'test_helpers.mocks.dart';

@GenerateMocks(
  [GraphQLClient],
  customMocks: [
    MockSpec<ConnectivityService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<GraphQlService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<HandlerService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<MoviesService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<QueueService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<StorageService>(onMissingStub: OnMissingStub.returnDefault),
  ],
)
void registerServices() {
  getAndRegisterConnectivityService();
  getAndRegisterGraphQlService();
  getAndRegisterHandlerService();
  getAndRegisterMoviesService();
  getAndRegisterQueueService();
  getAndRegisterStorageService();
}

MockConnectivityService getAndRegisterConnectivityService() {
  _removeRegistrationIfExists<ConnectivityService>();
  final service = MockConnectivityService();
  locator.registerSingleton<ConnectivityService>(service);
  return service;
}

MockGraphQlService getAndRegisterGraphQlService() {
  _removeRegistrationIfExists<GraphQlService>();
  final service = MockGraphQlService();
  locator.registerSingleton<GraphQlService>(service);
  return service;
}

MockHandlerService getAndRegisterHandlerService() {
  _removeRegistrationIfExists<HandlerService>();
  final service = MockHandlerService();
  locator.registerSingleton<HandlerService>(service);
  return service;
}

MockMoviesService getAndRegisterMoviesService() {
  _removeRegistrationIfExists<MoviesService>();
  final service = MockMoviesService();
  locator.registerSingleton<MoviesService>(service);
  return service;
}

MockQueueService getAndRegisterQueueService() {
  _removeRegistrationIfExists<QueueService>();
  final service = MockQueueService();
  locator.registerSingleton<QueueService>(service);
  return service;
}

MockStorageService getAndRegisterStorageService() {
  _removeRegistrationIfExists<StorageService>();
  final service = MockStorageService();
  locator.registerSingleton<StorageService>(service);
  return service;
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
