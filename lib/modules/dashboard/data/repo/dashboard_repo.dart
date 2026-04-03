import 'package:flutter_demo/modules/dashboard/data/models/product_category_res.dart';

import '../../../../core/managers/network_manager.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/base_res.dart';
import '../../../../core/network/ui_state.dart';
import '../models/customer_portal_res.dart';
import '../models/product_response.dart';

class DashboardRepo {
  Future<void> getProducts(
      void Function(UiState<List<ProductResponse>>) callback, {
        int? categoryId,
        String? brandId,
        double? minPrice,
        double? maxPrice,
        String? search
      }) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }
    final res = await ApiClient.to.getProducts(
      categoryId: categoryId,
      brandId: brandId,
      minPrice: minPrice,
      maxPrice: maxPrice,
        search: search,
    );

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

  Future<void> getCustomerPortal(
      void Function(UiState<List<CustomerPortalRes>>) callback,
      ) async {
    callback(const UiState.loading());

    if (!await isNetworkAvailable()) {
      callback(const UiState.error('No internet connection'));
      return;
    }
    final res = await ApiClient.to.getCustomerPortal();
    if (res.success == true && res.data != null) {
      callback(UiState.success(res.data!));
    } else {
      callback(UiState.error(res.message ?? 'Error occurred'));
    }
  }

}
