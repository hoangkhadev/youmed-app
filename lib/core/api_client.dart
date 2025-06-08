import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String _baseUrl = 'https://cc78-101-53-36-58.ngrok-free.app/api';

  String? _accessToken;

  ApiClient({String? accessToken}) {
    _accessToken = accessToken;
  }

  Map<String, String> _defaultHeaders() {
    final headers = {'Content-Type': 'application/json'};

    if (_accessToken != null && _accessToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }

    return headers;
  }

  Future<http.Response> get(String endpoint) {
    final url = Uri.parse('$_baseUrl/$endpoint');
    return http.get(url, headers: _defaultHeaders());
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic>? body) {
    final url = Uri.parse('$_baseUrl/$endpoint');
    return http.post(
      url,
      headers: _defaultHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic>? body) {
    final url = Uri.parse('$_baseUrl/$endpoint');
    return http.put(
      url,
      headers: _defaultHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> delete(String endpoint, {Map<String, dynamic>? body}) {
    final url = Uri.parse('$_baseUrl/$endpoint');
    return http.delete(
      url,
      headers: _defaultHeaders(),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  void updateTokens({required String accessToken}) {
    _accessToken = accessToken;
  }
}
