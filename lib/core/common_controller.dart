import 'package:flutter_demo/core/network/ui_state.dart';
import 'package:flutter_demo/core/utils/common_methods.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:get/get.dart';
import '../data/models/user_data.dart';
import '../data/repositories/common_repo.dart';
import '../modules/dashboard/data/models/brand_response.dart';
import '../modules/dashboard/data/models/product_category_res.dart';
import '../modules/profile/data/model/user_profile_model.dart';
import '../route/app_routes.dart';
import 'managers/storage_manager.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();

  final repo = CommonRepo();
  final Rx<UserData?> userData = Rx<UserData?>(null);
  final profileState = UiState<UserProfileModel>.none().obs;
  final categoryState = UiState<List<ProductCategoryRes>>.none().obs;
  final brandState = UiState<List<BrandResponse>>.none().obs;
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

  Future<void> fetchProfile({bool isRefresh = false}) async {
    if (isRefresh || profileState.value.isError || profileState.value.isNone) {
      await repo.getUserProfile((state) {
        profileState.value = state;
        state.handleWithErrorBox(
          showLoader: false,
              (data) {
          },
        );
      });
    }
  }

  Future<void> fetchCategory({bool isRefresh = false}) async {
    if (isRefresh || categoryState.value.isNone || categoryState.value.isError) {
      await repo.getCategory((state) {
        categoryState.value = state;
        state.handleWithErrorBox(
          showLoader: false,
              (data) {},
        );
      });
    }
  }

  Future<void> fetchBrand({bool isRefresh = false}) async {
    if (isRefresh || brandState.value.isNone || brandState.value.isError) {
      await repo.getBrand((state) {
        brandState.value = state;
        state.handleWithErrorBox(
          showLoader: false,
              (data) {},
        );
      });
    }
  }

}