import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        height: 200.0,
        width: 200.0,
        'assets/json/loader.json',
        fit: BoxFit.fill,
      ),
    );
  }
}

