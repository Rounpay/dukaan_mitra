import 'package:flutter_demo/modules/dashboard/data/models/brand_response.dart';

import '../../../../../core/managers/network_manager.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/ui_state.dart';
import '../../../data/models/product_category_res.dart';

class FilterRepo {
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
}