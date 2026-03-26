import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/common_controller.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/modules/profile/data/repo/profile_repo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/network/ui_state.dart';
import '../data/model/user_profile_model.dart';

class UpdateProfileController extends GetxController{
  final ProfileRepo repo;
  UpdateProfileController({required this.repo});
  final profileState = UiState<UserProfileModel>.none().obs;
  final documents = <Documents>[].obs;
  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image == null) return;

    profileImage.value = File(image.path);
  }
  final ImagePicker _picker = ImagePicker();
  Rx<File?> profileImage = Rx<File?>(null);


  @override
  void onReady() async {
    super.onReady();
    profileState.value = CommonController.to.profileState.value;
    setData(profileState.value.getDataOrNull);
  }
  void setData(UserProfileModel? data){
    fullNameController.text = data?.fullName ?? '';
    mobileNumberController.text = data?.mobileNumber ?? '';
    emailController.text = data?.email ?? '';
    documents.value = data?.documents ?? [];

  }

  @override
  void onClose() {
    fullNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
