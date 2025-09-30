import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/core/service/lookup_service.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final _box = GetStorage();

  final _token = RxnString();

  final Rxn<Map<dynamic, dynamic>> currentUser = Rxn<Map<dynamic, dynamic>>();

  String? get token => _token.value;

  @override
  void onInit() {
    super.onInit();
    _token.value = _box.read('token');
    if (isLoggedIn) {
      // Fetch user profile if token exists
      getUserProfile();
    }
  }

  Future<void> getUserProfile() async {
    try {
      Response response = await ApiRequest().getUserProfile();
      if (response.statusCode == 200) {
        currentUser.value = response.body;
      } else {
        // Handle error, possibly clear auth
        await clearAuth();
      }
    } catch (e) {
      // Handle exception, possibly clear auth
      await clearAuth();
    }
  }

  Future<void> logout() async {
    await clearAuth();
    Get.offAllNamed(Routes.SIGN_IN);
  }

  Future<void> saveAuth(String token) async {
    _token.value = token;
    await _box.write('token', token);
    await _box.write('isFirstLogin', true);
    await getUserProfile();
  }

  Future<void> clearAuth() async {
    _token.value = null;
    await _box.remove('token');
  }

  bool get isLoggedIn => token != null;

  bool get isFirstLogin => _box.read('isFirstLogin') ?? false;
}
