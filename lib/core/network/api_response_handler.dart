/// @Created by akash on 24-12-2025.
/// Know more about author at https://akash.cloudemy.in

import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

import 'base_res.dart';

class ApiResponseHandler {
  static BaseRes parseBaseRes(Response response) {
    if (response.isOk && response.body != null) {
      try {
        return BaseRes.fromJson(response.body);
      } catch (e) {
        return BaseRes(success: false, message: e.toString());
      }
    } else {
      return BaseRes(
        success: false,
        message: getErrorMessage(response),
      );
    }
  }

  static BaseDataRes<T> parse<T>(
    Response response,
    T Function(dynamic json) fromJson,
  ) {
    if (response.isOk && response.body != null) {
      try {
        return BaseDataRes<T>.fromJson(response.body, fromJson);
      } catch (e) {
        return BaseDataRes(success: false, message:e.toString());
      }
    } else {
      return BaseDataRes<T>(
        success: false,
        message: getErrorMessage(response),
      );
    }
  }

  static BaseDataRes<List<T>> parseList<T>(
    Response response,
    T Function(dynamic json) fromJson,
  ) {
    if (response.isOk && response.body != null) {
      try {
        final dataList = (response.body as List)
            .map((e) => fromJson(e))
            .toList();
        return BaseDataRes<List<T>>(data: dataList, success: true);
      } catch (e) {
        return BaseDataRes(success: false, message:e.toString());
      }
    } else {
      return BaseDataRes(
        success: false,
        message: getErrorMessage(response),
      );
    }
  }

  static String getErrorMessage(dynamic error) {
    if (error is GetHttpException) return error.message;
    if (error is SocketException || error is TimeoutException)
      return "No internet connection or request timed out";

    if (error is Response) {
      final status = error.status;
      if (status.connectionError) return "Connection Error";
      if (status.isUnauthorized) return error.statusText ?? "Unauthorized";
      if (status.isNotFound) return "404 : Resource not found";
      if (status.isServerError)
        return "${status.code} : Server error. Please try again later";

      try {
        return error.body?["responseText"] ??
            "${error.statusCode ?? ''}: ${error.statusText ?? ''}";
      } catch (_) {
        return "Something went wrong";
      }
    }

    return error.toString();
  }
}
