import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

/// @Created by akash on 19-09-2025.
/// Know more about author at https://akash.cloudemy.in


Future<bool> isNetworkAvailable() async {
  if (Platform.isAndroid) {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.isNotEmpty &&
        connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);
  } else {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}