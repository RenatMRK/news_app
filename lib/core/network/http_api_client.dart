import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_client.dart';

class HttpApiClient implements ApiClient {
  final http.Client _client;

  HttpApiClient(this._client);

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? query}) async {
    final uri = Uri.parse(url).replace(queryParameters: query);
    final response = await _client.get(uri);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Ошибка HTTP: ${response.statusCode}');
    }
  }

  @override
  Future<dynamic> post(String url, {Map<String, dynamic>? body}) async {
    final response = await _client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Ошибка HTTP: ${response.statusCode}');
    }
  }
}
