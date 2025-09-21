import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

/// Enum for HTTP Methods
enum HttpMethod { GET, POST, PUT, DELETE }

/// Helper class for HTTP operations
class HttpHelper {
  /// Logs API request details
  static void logRequest(
    HttpMethod method,
    String baseUrl,
    String endpoint,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  ) {
    log("REQUEST [${method.name}] → $baseUrl$endpoint", name: "WebServices");
    log("Headers: $headers", name: "WebServices");
    if (body != null) {
      log("Body: ${jsonEncode(body)}", name: "WebServices");
    }
  }

  /// Logs API response details
  static void logResponse(Response response) {
    log("RESPONSE [${response.statusCode}] → ${response.request?.url}",
        name: "WebServices");
    log("Response Body: ${response.body}", name: "WebServices");
  }

  /// Sends API requests using GetConnect
  static Future<Response> sendRequest(
    GetHttpClient httpClient,
    HttpMethod method,
    String endpoint,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  ) async {
    switch (method) {
      case HttpMethod.POST:
        return await httpClient.post(endpoint, body: body, headers: headers);
      case HttpMethod.PUT:
        return await httpClient.put(endpoint, body: body, headers: headers);
      case HttpMethod.DELETE:
        return await httpClient.delete(endpoint, headers: headers);
      case HttpMethod.GET:
      default:
        return await httpClient.get(endpoint, headers: headers);
    }
  }
}
