

import '../../core/managers/network_manager.dart';
import '../../core/network/api_client.dart';
import '../../core/network/base_res.dart';
import '../../core/network/ui_state.dart';
import '../../modules/dashboard/data/models/brand_response.dart';
import '../../modules/dashboard/data/models/product_category_res.dart';
import '../../modules/profile/data/model/user_profile_model.dart';

/// @Created by akash on 26-09-2025.
/// Know more about author at https://akash.cloudemy.in

class CommonRepo {

  void logout(
      Object body,
      void Function(UiState<BaseRes> state) callback,
      ) async {
    callback.call(const UiState.loading());
    if (!await isNetworkAvailable()) {
      callback.call(const UiState.error('No internet connection'));
      return;
    }
    var res = await ApiClient.to.logout();

    if (res.success == true) {
      callback.call(UiState.success(res));
    } else {
      callback.call(UiState.error(res.message ?? 'Error occurred'));
    }
  }

/*
  Future<void> getProfile(
      void Function(UiState<UserDetailsData> state) callback,
      ) async {
    callback.call(const UiState.loading());
    if (!await isNetworkAvailable()) {
      callback.call(const UiState.error('No internet connection'));
      return;
    }
    var res = await ApiClient.to.userProfileDetailForAndriod();
    if (res.statusCode == 1 ) {
      callback.call(UiState.success(res.data!));
    } else {
      callback.call(UiState.error(res.responseText ?? 'No data found!'));
    }

  }

*/
  Future<void> getUserProfile(
      void Function(UiState<UserProfileModel>) callback,
      ) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }

    final res = await ApiClient.to.getUserProfile();

    if (res.success == true && res.data != null) {
      callback(UiState.success(res.data!));
    } else {
      callback(UiState.error(res.message ?? 'Error occurred'));
    }
  }
  Future<void> getCategory(
      void Function(UiState<List<ProductCategoryRes>>) callback,
      ) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }
    final res = await ApiClient.to.getCategories();
    if (res.success == true && res.data != null) {
      callback(UiState.success(res.data!));
    } else {
      callback(UiState.error(res.message ?? 'Error occurred'));
    }
  }
  Future<void> getBrand(
      void Function(UiState<List<BrandResponse>>) callback,
      ) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }
    final res = await ApiClient.to.getBrand();
    if (res.success == true && res.data != null) {
      callback(UiState.success(res.data!));
    } else {
      callback(UiState.error(res.message ?? 'Error occurred'));
    }
  }
  Future<void> changePassword(
      Object body,
      void Function(UiState<BaseRes>) callback,
      ) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }
    final res = await ApiClient.to.changePassword(body);
    if (res.success == true) {
      callback(UiState.success(res));
    } else {
      callback(UiState.error(res.message ?? 'Error occurred'));
    }
  }
}
