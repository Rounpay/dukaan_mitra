import 'package:flutter_demo/modules/purchase/data/purchase_data_res.dart';

import '../../../core/managers/network_manager.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/ui_state.dart';


class PurchaseRepo {
  Future<void> getLoanDetails(int loanId,
      void Function(UiState<PurchaseDataRes>) callback,) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }

    final res = await ApiClient.to.getLoanDetails(loanId);

    if (res.success == true && res.data != null) {
      callback(UiState.success(res.data!));
    } else {
      callback(UiState.error(res.message ?? 'Error occurred'));
    }
  }
}