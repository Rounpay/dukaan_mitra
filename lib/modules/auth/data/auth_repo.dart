import 'package:flutter_demo/modules/auth/data/document_type_response.dart';
import 'package:get/get.dart';

import '../../../core/managers/network_manager.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/base_res.dart';
import '../../../core/network/ui_state.dart';
import '../../../data/models/user_data.dart';

/// @Created by akash on 02-03-2026.
/// Know more about author at https://akash.cloudemy.in

class AuthRepo {

  void login(
      Object body,
      void Function(UiState<UserData> state) callback,
      ) async {
    callback.call(const UiState.loading());
    if (!await isNetworkAvailable()) {
      callback.call(const UiState.error('No internet connection'));
      return;
    }
    var res = await ApiClient.to.logIn(body);
    if (res.success == true && res.data != null) {
      callback.call(UiState.success(res.data!));
    } else {
      callback.call(UiState.error(res.message ?? 'Error occurred'));
    }
  }
  void customerSignup(
      FormData body,
      void Function(UiState<BaseRes> state) callback,
      ) async {
    callback.call(const UiState.loading());
    if (!await isNetworkAvailable()) {
      callback.call(const UiState.error('No internet connection'));
      return;
    }
    var res = await ApiClient.to.customerSignup(body);
    if (res.success == true) {
      callback.call(UiState.success(res));
    } else {
      callback.call(UiState.error(res.message ?? 'Error occurred'));
    }
  }

  void getDocumentTypeRepo(
      void Function(UiState<List<DocumentTypeResponse>> state) callback,
      ) async {
    callback.call(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback.call(const UiState.error('No internet connection'));
      return;
    }
    final res = await ApiClient.to.getDocumentTypeRepo();

    if (res.success == true) {
      callback.call(UiState.success(res.data ?? []));
    } else {
      callback.call(UiState.error(res.message ?? 'Error occurred'));
    }
  }

}