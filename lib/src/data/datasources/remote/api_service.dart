import 'package:http/http.dart' as http;

import '../../../core/utils/service_constants.dart';

class ApiService {
  final http.Client _client;

  ApiService({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<http.Response> apiCall({required String url}) async {
    Uri uri = Uri.parse(url);
    var response = await _client.get(uri);
    return response;
  }

  Future<http.Response> postCharacter({required String body}) async {
    Uri uri = Uri.parse(ServiceConstants.postUrl);
    var response = await _client.post(
      uri,
      body: body,
    );
    return response;
  }
}
