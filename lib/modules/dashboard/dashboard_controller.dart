import 'package:flutter/material.dart';
import 'package:flutter_demo/core/common_controller.dart';
import 'package:flutter_demo/modules/dashboard/data/models/product_response.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/network/ui_state.dart';
import '../../core/utils/common_methods.dart';
import '../../core/utils/extensions.dart';
import '../field_inspector/data/model/fi_assignment_model.dart';
import '../field_inspector/data/model/fi_dashboard_data.dart';
import 'data/models/customer_portal_res.dart';
import 'data/models/product_category_res.dart';
import 'data/repo/dashboard_repo.dart';

/// @Created by akash on 20-02-2026.
/// Know more about author at https://akash.cloudemy.in

class DashboardController extends GetxController {
  final repo = DashboardRepo();
  final searchController = TextEditingController();
  final remarksController = TextEditingController();
  final productState = UiState<List<ProductResponse>>.none().obs;
  final customerPortalState = UiState<List<CustomerPortalRes>>.none().obs;
  final categoryState = UiState<List<ProductCategoryRes>>.none().obs;
  final assignmentState = UiState<List<FiAssignmentModel>>.none().obs;
  final fiDashboardState = UiState<FiDashboardData>.none().obs;
  final isSearching = false.obs;
  final selectedImagePath = RxnString();
  var selectedCategoryId = RxnInt();
  var selectedBrandId = <int>[].obs;
  var priceRange = const RangeValues(0, 999999).obs;
  var currentIndex = 0.obs;
  var selectedTab = 0.obs;

  final RxInt currentPage = 0.obs;
  final List<String> promoImages = [
    'assets/images/slide_1.jpg',
    'assets/images/slide_2.jpg',
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }
  int? get roleId => CommonController.to.userData.value?.roleId;
  @override
  void onReady() {
    super.onReady();
    CommonController.to.fetchProfile();
    fetchProducts();
    fetchCategory();
    customerPortal();
    if (roleId.isFieldInspector) {
      fetchAssignments();
      fetchFiDashboard();
    } else {
      fetchProducts();
      fetchCategory();
      customerPortal();
    }
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



  void submitReport(int assignmentId) async {
    print(">>> Submitting with assignmentId: $assignmentId"); // ADD THIS
    final remarks = remarksController.text.trim();
    final image = selectedImagePath.value;
    if (remarks.isEmpty) {
      Get.snackbar("Error", "Please enter remarks");
      return;
    }
    if (image == null) {
      Get.snackbar("Error", "Please capture a photo");
      return;
    }
    Get.back();
    repo.submitReport(
      assignmentId: assignmentId,
      remarks: remarksController.text.trim(),
      imagePath: selectedImagePath.value!,
      callback: (state) {
        state.handleWithErrorBox(showLoader: true, (res) async {
          showSuccessDialog(res.message ?? "Report submitted successfully");
          fetchAssignments();
          fetchFiDashboard();
        });
      },
    );
  }

  void pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      selectedImagePath.value = picked.path;
    }
  }
  void fetchAssignments() {
    repo.getMyAssignments((state) {
      assignmentState.value = state;
    });
  }

  void fetchFiDashboard() {
    repo.getFiDashboard((state) {
      fiDashboardState.value = state;
    });
  }
}
