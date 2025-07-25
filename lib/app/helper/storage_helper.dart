import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final GetStorage _box = GetStorage();

  /// المفاتيح
  static const String _userKey = 'user_profile';
  static const String _rememberMeKey = 'remember_me';

  /// حفظ بيانات المستخدم كـ JSON String
  static Future<void> saveUserProfile(Map<String, dynamic> userJson) async {
    await _box.write(_userKey, userJson);
  }

  /// استرجاع بيانات المستخدم
  static Map<String, dynamic>? getUserProfile() {
    return _box.read<Map<String, dynamic>>(_userKey);
  }

  /// حذف بيانات المستخدم
  static Future<void> clearUserProfile() async {
    await _box.remove(_userKey);
  }

  /// حفظ حالة "تذكرني"
  static Future<void> setRememberMe(bool value) async {
    await _box.write(_rememberMeKey, value);
  }

  /// استرجاع حالة "تذكرني"
  static bool isRememberMe() {
    return _box.read<bool>(_rememberMeKey) ?? false;
  }

  /// حذف الكل (تسجيل خروج مثلاً)
  static Future<void> clearAll() async {
    await _box.erase();
  }
}
