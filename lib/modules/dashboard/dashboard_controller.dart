import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_screen.dart';

/// @Created by akash on 20-02-2026.
/// Know more about author at https://akash.cloudemy.in

class DashboardController extends GetxController{
  //final repo = DashboardRepo();
  final RxInt currentPage = 0.obs;
  final List<String> promoImages = [
    'assets/images/slide_1.jpg',
    'assets/images/slide_2.jpg',
  ];
  var currentIndex = 0.obs;
  final List<Widget> pages = [HomeScreen(), ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onReady() {
    super.onReady();
  }



  @override
  void onClose() {
    super.onClose();
  }
}