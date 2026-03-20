/// @Created by akash on 16-02-2024.
/// Know more about author at https://akash.cloudemy.in

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';

mixin Printer {
   printRequest(Request request) async {
    if (kDebugMode) {
      try{
        print("╔═╣ Request ║ ${request.method.toUpperCase()} ");
        print("║");
        print("║  ${request.url}");
        print("║");
        print(
            "║═╣ Headers ║══════════════════════════════════════════════════════════════════════════════");
        prettyPrint(jsonEncode(request.headers));
        print(
            "║═╣ Body ║═════════════════════════════════════════════════════════════════════════════════");
        String body = await request.bodyBytes.transform(utf8.decoder).join();
        prettyPrint(body);
        print(
            '╚══════════════════════════════════════════════════════════════════════════════════════════╝');
      }catch(e){
        debugPrint("Unable to print request");
      }

    }
  }

   void printResponse(Response<Object?> response, Request<Object?> request) {
    if (kDebugMode) {
      print("╔═╣ Response ║ ${request.method.toUpperCase()} ║ Status: ${response.status.code}");
      print("║");
      print("║  ${request.url}");
      print("║");
      print("║═╣ Body ║═════════════════════════════════════════════════════════════════════════════════");
      prettyPrint(jsonEncode(response.body));
      print('╚══════════════════════════════════════════════════════════════════════════════════════════╝');
    }
  }

   prettyPrint(String jsonString) {
    final json = jsonDecode(jsonString);
    const encoder = JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(json);

    // If the string is more than 1000 in length, split it
    if (prettyString.length > 1000) {
      int startIndex = 0;
      while (startIndex < prettyString.length) {
        int endIndex = startIndex + 1000 <= prettyString.length-1
            ? startIndex + 1000
            : prettyString.length-1;
        // Find the nearest newline character
        while (endIndex > startIndex && prettyString[endIndex] != '\n') {
          endIndex--;
        }
        // Ensure endIndex is within the range of prettyString
        endIndex = endIndex < prettyString.length ? endIndex : prettyString.length - 1;
        if (kDebugMode) {
          print(prettyString.substring(startIndex, endIndex));
        }
        startIndex = endIndex + 1;
      }
    } else {
      if (kDebugMode) {
        print(prettyString);
      }
    }
  }


}