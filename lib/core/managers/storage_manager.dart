import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/user_data.dart';

class StorageManager {
  StorageManager._();

  static GetStorage get storage => Get.find();

  static Future<void> init() async {
    await GetStorage.init();
    Get.lazyPut(() => GetStorage());
  }

  static void saveString(String key, String value) {
    storage.write(key, value);
  }

  static String? getString(String key) {
    return storage.read(key);
  }

  static void saveBool(String key, bool value) {
    storage.write(key, value);
  }

  static bool? getBool(String key) {
    return storage.read(key);
  }

  static Future<void> saveUserData(UserData data) async {
    return storage.write('userData', data.toJson());
  }

  static void removeUserData() {
    storage.remove('userData');
  }

  static UserData? loadLoginUserData() {
    if (!storage.hasData('userData') || storage.read('userData') == null) {
      return null;
    }
    return UserData.fromJson(storage.read('userData') ?? {});
  }

  static const onboardingDone = 'onboarding_done';
}
