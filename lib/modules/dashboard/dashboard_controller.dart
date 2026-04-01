import 'package:flutter/material.dart';
import 'package:flutter_demo/core/common_controller.dart';
import 'package:flutter_demo/modules/dashboard/data/models/product_response.dart';
import 'package:flutter_demo/modules/dashboard/purchase/purchase_history.dart';
import 'package:flutter_demo/route/app_routes.dart';
import 'package:get/get.dart';
import '../../core/network/base_res.dart';
import '../../core/network/ui_state.dart';
import '../../core/theme/theme_colors.dart';
import '../../core/widgets/custom_dialog.dart';
import 'data/models/customer_portal_res.dart';
import 'data/models/product_category_res.dart';
import 'data/repo/dashboard_repo.dart';
import 'profile/profile_details_screen.dart';

import 'home/home_screen.dart';

/// @Created by akash on 20-02-2026.
/// Know more about author at https://akash.cloudemy.in

class DashboardController extends GetxController{
  final repo = DashboardRepo();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final searchController = TextEditingController();
  final productState = UiState<List<ProductResponse>>.none().obs;
  final customerPortalState = UiState<List<CustomerPortalRes>>.none().obs;
  final categoryState = UiState<List<ProductCategoryRes>>.none().obs;
  final changePasswordState = UiState<BaseRes>.none().obs;
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
  final List<Widget> pages = [HomeScreen(),PurchaseHistory(),ProfileDetailsScreen() ];

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
      state.handleWithErrorBox(

          showLoader: true, (data) {}
      );
    });
    }
    void fetchCategory() {
    repo.getCategory((state) {
      categoryState.value = state;
      state.handleWithErrorBox(
          showLoader: true, (data) {}
      );
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
      repo.getProducts(
            (state) {
          productState.value = state;
        },
        search: query,
      );
    }
  }

  void customerPortal() {
    repo.getCustomerPortal((state) {
      customerPortalState.value = state;
      state.handleWithErrorBox(
          showLoader: true, (data) {}
      );
    });
  }

  void changePassword() {
    repo.changePassword(
      {
        "currentPassword": oldPasswordController.text.trim(),
        "newPassword": newPasswordController.text.trim(),
        "confirmPassword": confirmPasswordController.text.trim(),
      },
          (state) {
        changePasswordState.value = state;

        state.handleWithErrorBox(
          showLoader: true,
              (data) {
            Get.back();
            oldPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
            Get.dialog(
              CustomDialog(
                title: 'Password Changed Successfully!',
                icon: Icons.check_circle_outline,
                iconColor: ThemeColors.colorGreen,
                primaryBtnText: 'OK',
                onPrimaryPressed: () {
                  Get.back();
                  Get.offAllNamed(AppRoutes.login);
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  void onClose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}