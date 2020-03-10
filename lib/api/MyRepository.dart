import 'RestAPI.dart';

class MyRepository {
  final apiProvider = RestAPI();

  Future<dynamic> getGlobalStatistics() => apiProvider.getGlobalStatistics();
}
