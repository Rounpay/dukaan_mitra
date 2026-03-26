import 'package:flutter_demo/modules/dashboard/home/filter/data/filter_repo.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/network/ui_state.dart';
import '../../data/models/brand_response.dart';
import '../../data/models/product_category_res.dart';

class FilterController extends GetxController {
  final FilterRepo repo;
  FilterController({required this.repo});
  final categoryState = UiState<List<ProductCategoryRes>>.none().obs;
  final brandState = UiState<List<BrandResponse>>.none().obs;
  var selectedCategoryId = RxnInt();
  var selectedBrandId = RxnInt();
  var isLoading = true.obs;
  var minPrice = 0.0.obs;
  var maxPrice = 999999.0.obs;
  var priceRange = const RangeValues(0, 999999).obs;


@override
void onReady() {
    super.onReady();
    fetchCategory();
    fetchBrand();
  }

  void toggleCategory(int id) {
    if (selectedCategoryId.value == id) {
      selectedCategoryId.value = null;
    } else {
      selectedCategoryId.value = id;
    }
  }

  void toggleBrand(int id) {
    if (selectedBrandId.value == id) {
      selectedBrandId.value = null;
    } else {
      selectedBrandId.value = id;
    }
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

  void fetchCategory() {
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
  }
}