import 'package:get/get.dart';

extension ApiResponseHandler on Future<Response> {
  Future<void> handleApiResponse({
    required Function(Response data) onSuccess,
    required Function(String errorMessage) onFailure,
    Function()? onFinal,
    Function(Response data)? onWrongInput,
  }) async {
    try {
      Response response = await this; // Wait for API call

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess(response);
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        onWrongInput?.call(response);
      } else {
        onFailure("API Error: ${response.statusCode} - ${response.bodyString}");
      }
    } catch (e) {
      onFailure("Request failed: $e");
    } finally {
      onFinal?.call();
    }
  }
}
