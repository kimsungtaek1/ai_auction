import 'package:ai_auction/app/data/provider/api.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({required this.apiClient}) : assert(apiClient != null);

  getAll() {
    return apiClient.getAll();
  }
}