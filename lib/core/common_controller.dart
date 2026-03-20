import 'package:get/get.dart';
import '../data/models/user_data.dart';
import '../data/repositories/common_repo.dart';
import 'managers/storage_manager.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();
  final repo = CommonRepo();
  final userData = Rx<UserData?>(null);



  void clearData({required bool showLogin}) {
    userData.value = null;
  }

  Future<void> setUserData(UserData data) async {
    userData.value = data;
    return StorageManager.saveUserData(data);
  }

  /// Returns true if User is already logged in
  bool loadLoginUserData() {
    userData.value = StorageManager.loadLoginUserData();
    return userData.value != null;
  }

}
