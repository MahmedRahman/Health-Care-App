import 'package:get/get.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class MoreController extends GetxController {
  void logout() async {
    Response response = await ApiRequest().logout();

    if (response.statusCode == 200) {
      await AuthService.to.logout();
    }
  }
}
