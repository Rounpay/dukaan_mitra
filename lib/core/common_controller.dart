import 'package:flutter_demo/core/network/ui_state.dart';
import 'package:flutter_demo/core/utils/common_methods.dart';
import 'package:get/get.dart';
import '../data/models/user_data.dart';
import '../data/repositories/common_repo.dart';
import '../route/app_routes.dart';
import 'managers/storage_manager.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();

  final repo = CommonRepo();

  final Rx<UserData?> userData = Rx<UserData?>(null);
  final loggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoginUserData();
  }


  bool loadLoginUserData() {
    userData.value = StorageManager.loadLoginUserData();
    loggedIn.value = userData.value != null;
    return loggedIn.value;
  }

  Future<void> setUserData(UserData data) async {
    userData.value = data;
    loggedIn.value = true;
    await StorageManager.saveUserData(data);
  }

  void logout() {
    if (!loggedIn.value) return;
    repo.logout({}, (state) {
      state.handleWithErrorBox(
        showLoader: true,
            (data) {
          showToast("Logout Successful");
          clearData(showLogin: true);
        },
      );
    });
  }

  void clearData({bool showLogin = false}) {
    userData.value = null;
    loggedIn.value = false;
    StorageManager.removeUserData();
    if (showLogin) {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}