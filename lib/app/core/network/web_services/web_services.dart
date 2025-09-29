import 'package:get/get.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/core/network/web_services/http_helper.dart';

import 'api_exceptions.dart';

class WebServices extends GetConnect {
  /// Flag to enable or disable logging
  bool enableLogging = false;

  @override
  void onInit() {
    httpClient.baseUrl = "159.198.36.67:8080";
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.maxAuthRetries = 3;
    httpClient.followRedirects = false; // Add this line
    httpClient.defaultContentType = "application/json";

    super.onInit();
  }

  Future<Response> execute({
    required String endpoint,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = false,
  }) async {
    try {
      // Default headers
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json",
        "Accept-Language": "ar",
        "User-Agent": "YourApp/1.0", // Add this
        "Accept": "application/json",
        "Connection": "keep-alive", // Add this
        ...?headers,
      };

      httpClient.addRequestModifier<dynamic>((request) {
        final token = AuthService.to.token;
        if (token != null) {
          request.headers['Authorization'] = "Bearer $token";
        }
        return request;
      });
      // Logging Request (Only if logging is enabled)
      if (enableLogging) {
        HttpHelper.logRequest(
          method,
          httpClient.baseUrl ?? "",
          endpoint,
          requestHeaders,
          body,
        );
      }

      httpClient.timeout = const Duration(seconds: 30);

      Response response = await HttpHelper.sendRequest(
        httpClient,
        method,
        endpoint,
        requestHeaders,
        body,
      );

      // // Check if the response contains HTML content (which might indicate unauthorized access)
      // if ((response.body.toString().contains('<html') ||
      //     response.body.toString().contains('<!DOCTYPE html'))) {
      //   // This is likely an HTML login page, indicating unauthorized access
      //   throw UnauthorizedException();
      // }

      // Logging Response (Only if logging is enabled)
      if (enableLogging) HttpHelper.logResponse(response);

      return _handleResponse(response);
    } catch (e) {
      if (enableLogging) {
        print("Error: $e");
      }

      if (e is UnauthorizedException) {
        (e).handleUnauthorized(enableLogging: enableLogging);

        if (Get.currentRoute != '/sign-in') {
          AuthService.to.logout();
        }

        throw e;
      } else {
        throw ApiException("Request failed: $e");
      }
    }
  }

  Response _handleResponse(Response response) {
    if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 422) {
      return response;
    } else if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return response;
    } else {
      throw ApiException(
        "API Error: ${response.body}",
        statusCode: response.statusCode,
      );
    }
  }
}
