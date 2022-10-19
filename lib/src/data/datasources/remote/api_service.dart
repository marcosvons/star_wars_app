import 'package:http/http.dart' as http;
import 'package:star_wars_app/src/core/utils/service_constants.dart';

class ApiService {
  final http.Client _client;

  ApiService({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<http.Response> apiCall({required String endpoint}) async {
    Uri uri = Uri.parse('${ServiceConstants.baseURL}$endpoint');
    var response = await _client.get(uri);
    return response;
  }
}
