import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/common_controller.dart';
import '../../../../core/network/ui_state.dart';

import 'data/filter_repo.dart';

class FilterController extends GetxController {
  final FilterRepo repo;
  FilterController({required this.repo});
/*  final categoryState = UiState<List<ProductCategoryRes>>.none().obs;
  final brandState = UiState<List<BrandResponse>>.none().obs;*/
  var selectedCategoryId = RxnInt();
  var selectedBrandId = RxnInt();
  var isLoading = true.obs;
  var minPrice = 0.0.obs;
  var maxPrice = 999999.0.obs;
  var priceRange = const RangeValues(0, 999999).obs;

  @override
  void onInit() {
    selectedCategoryId.value = Get.arguments["categoryId"];
    selectedBrandId.value = Get.arguments["brandId"];
    priceRange.value = RangeValues(
        Get.arguments["minPrice"]?.toDouble() ?? 0,
        Get.arguments["maxPrice"]?.toDouble() ?? 999999);
    super.onInit();
  }

@override
void onReady() {
    super.onReady();
   /* fetchCategory();
    fetchBrand();*/
    CommonController.to.fetchCategory(/*isRefresh: true*/);
    CommonController.to.fetchBrand(/*isRefresh: true*/);
  }

  void toggleCategory(int id) {
    selectedCategoryId.value =
    selectedCategoryId.value == id ? null : id;
  }

  void toggleBrand(int id) {
    selectedBrandId.value =
    selectedBrandId.value == id ? null : id;
  }


  void updatePrice(RangeValues value) {
    priceRange.value = value;
  }

  void resetFilters() {
    selectedCategoryId.value = null;
    selectedBrandId.value = null;
    priceRange.value = const RangeValues(0, 999999);
  }

  void updateMaxPrice(String input) {
    final parsed = double.tryParse(input);
    if (parsed != null && parsed > 0) {
      maxPrice.value = parsed;
      priceRange.value = RangeValues(0, parsed);
    }
  }

/*  void fetchCategory() {
    repo.getCategory((state) {
      categoryState.value = state;
      state.handleWithErrorBox(
          showLoader: true, (data) {}
      );
    });
  }

  void fetchBrand() {
    repo.getBrand((state) {
      brandState.value = state;
      state.handleWithErrorBox(
          showLoader: true, (data) {}
      );
    });
  }*/
}