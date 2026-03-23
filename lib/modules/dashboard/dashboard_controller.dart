import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../purchase/purchase_history.dart';

/// @Created by akash on 20-02-2026.
/// Know more about author at https://akash.cloudemy.in

class DashboardController extends GetxController{
  //final repo = DashboardRepo();
  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final searchController = TextEditingController();

  final RxInt currentPage = 0.obs;
  final List<String> promoImages = [
    'assets/images/slide_1.jpg',
    'assets/images/slide_2.jpg',
  ];
  var currentIndex = 0.obs;
  final List<Widget> pages = [HomeScreen(),PurchaseHistory(),ProfileScreen() ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }

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
  void onReady() {
    super.onReady();
  }



  @override
  void onClose() {
    super.onClose();
  }
}