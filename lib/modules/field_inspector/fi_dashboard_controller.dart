import 'package:flutter/material.dart';
import 'package:flutter_demo/modules/dashboard/profile/profile_details_screen.dart';
import 'package:flutter_demo/modules/field_inspector/%20fi_status/fi_status_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/network/ui_state.dart';
import '../../core/utils/common_methods.dart';
import 'data/model/fi_assignment_model.dart';
import 'data/model/fi_dashboard_data.dart';
import 'data/repo/fi_inspector_repo.dart';

class FiDashboardController extends GetxController{
  final repo = FiInspectorRepo();
  var currentIndex = 0.obs;
  var selectedTab = 0.obs;
  final remarksController = TextEditingController();
  final selectedImagePath = RxnString();
  final List<Widget> pages = [FiStatusScreen(),ProfileDetailsScreen()];
  final assignmentState = UiState<List<FiAssignmentModel>>.none().obs;
  final fiDashboardState = UiState<FiDashboardData>.none().obs;


  @override
  void onReady() {
    super.onReady();
    fetchAssignments();
    fetchFiDashboard();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
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
      state.handleWithErrorBox(showLoader: true, (data) {});
    });
  }

  void fetchFiDashboard() {
    repo.getFiDashboard((state) {
      fiDashboardState.value = state;
      state.handleWithErrorBox(showLoader: true, (data) {});
    });
  }


}