abstract class ApiClient {
  Future<dynamic> get(String url, {Map<String, dynamic>? query});
  Future<dynamic> post(String url, {Map<String, dynamic>? body});
}