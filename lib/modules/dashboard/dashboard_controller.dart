import 'package:flutter/material.dart';
import 'package:flutter_demo/core/common_controller.dart';
import 'package:flutter_demo/modules/dashboard/data/models/product_response.dart';
import 'package:get/get.dart';

import '../../core/network/ui_state.dart';
import 'data/models/customer_portal_res.dart';
import 'data/models/product_category_res.dart';
import 'data/repo/dashboard_repo.dart';

/// @Created by akash on 20-02-2026.
/// Know more about author at https://akash.cloudemy.in

class DashboardController extends GetxController {
  final repo = DashboardRepo();

  final searchController = TextEditingController();
  final productState = UiState<List<ProductResponse>>.none().obs;
  final customerPortalState = UiState<List<CustomerPortalRes>>.none().obs;
  final categoryState = UiState<List<ProductCategoryRes>>.none().obs;

  final isSearching = false.obs;
  var selectedCategoryId = RxnInt();
  var selectedBrandId = <int>[].obs;
  var priceRange = const RangeValues(0, 999999).obs;

  final RxInt currentPage = 0.obs;

  final List<String> promoImages = [
    'assets/images/slide_1.jpg',
    'assets/images/slide_2.jpg',
  ];
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onReady() {
    super.onReady();
    CommonController.to.fetchProfile();
    fetchProducts();
    fetchCategory();
    customerPortal();
  }

  void fetchProducts() {
    repo.getProducts((state) {
      productState.value = state;
    });
  }

  void fetchCategory() {
    repo.getCategory((state) {
      categoryState.value = state;
    });
  }

  void fetchFilteredProducts() {
    repo.getProducts(
      (state) {
        productState.value = state;
      },
      categoryId: selectedCategoryId.value,
      brandId: selectedBrandId.toString(),
      minPrice: priceRange.value.start,
      maxPrice: priceRange.value.end,
    );
  }

  void searchProducts(String query) {
    isSearching.value = query.isNotEmpty;
    if (query.isEmpty) {
      fetchProducts();
    } else {
      repo.getProducts((state) {
        productState.value = state;
      }, search: query);
    }
  }

  void customerPortal() {
    repo.getCustomerPortal((state) {
      customerPortalState.value = state;
    });
  }
}
