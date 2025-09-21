import 'dart:developer';

/// Custom API Exceptions
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() {
    return "ApiException: $message (Status Code: $statusCode)";
  }
}

/// Custom Exception for Unauthorized Requests (401)
class UnauthorizedException extends ApiException {
  UnauthorizedException()
      : super("Unauthorized Access - Please log in again.", statusCode: 401);

  /// Handles Unauthorized Access (401) - Log Out or Refresh Token
  void handleUnauthorized({bool enableLogging = false}) {
    if (enableLogging) {
      log("Unauthorized - Logging out user...", name: "WebServices");
    }
    // TODO: Implement logout logic or token refresh
  }
}
