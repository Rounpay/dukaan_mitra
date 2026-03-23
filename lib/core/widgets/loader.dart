import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        height: 80.0,
        width: 80.0,
        'assets/svg/loading.json',
        fit: BoxFit.fill,
      ),
    );
  }
}

