

import '../../core/managers/network_manager.dart';
import '../../core/network/api_client.dart';
import '../../core/network/base_res.dart';
import '../../core/network/ui_state.dart';

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

}
