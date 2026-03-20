/// @Created by akash on 16-02-2024.
/// Know more about author at https://akash.cloudemy.in

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../route/app_routes.dart';
import '../utils/common_methods.dart';
import '../widgets/progress_dialog.dart';

part 'ui_state.freezed.dart';

@freezed
sealed class UiState<T> with _$UiState<T> {
  const factory UiState.success(T data) = Success<T>;

  const factory UiState.error(String msg) = Error<T>;

  const factory UiState.loading() = Loading<T>;

  const factory UiState.none() = None<T>;
}

extension UiStateX<T> on UiState<T> {
  void handle(
    void Function(T) onSuccess, {
    bool showLoader = true,
    void Function(String)? onError,
  }) {
    switch (this) {
      case Success<T>():
        if (showLoader) ProgressDialog.hide();
        onSuccess.call((this as Success<T>).data);
        break;

      case Error<T>():
        if (showLoader) ProgressDialog.hide();
        final error = (this as Error<T>).msg;

        if (error.contains('redirectToLogin')) {
          Get.offAllNamed(AppRoutes.onboarding);
          return;
        }

        if (onError == null) {
          showErrorToast(error);
        } else {
          onError.call(error);
        }
        break;

      case Loading<T>():
        if (showLoader) ProgressDialog.show();
        break;
      case None<T>():
        break;
    }
  }

  void handleWithErrorBox(
    void Function(T data) onSuccess, {
    bool showLoader = true,
    String? dialogMsg,
    void Function(String)? onError,
  }) {
    switch (this) {
      case Success<T>():
        if (showLoader) ProgressDialog.hide();
        onSuccess.call((this as Success<T>).data);
        break;

      case Error<T>():
        if (showLoader) ProgressDialog.hide();
        final error = (this as Error<T>).msg;

        onError?.call(error);

        if (error.contains('redirectToLogin')) {
          Navigator.pushNamedAndRemoveUntil(
            Get.context!,
            AppRoutes.onboarding,
            (route) => false,
            arguments: 1,
          );
        } else {
          showErrorDialog(error, msg: dialogMsg);
        }
        break;

      case Loading<T>():
        if (showLoader) ProgressDialog.show();
        break;
      case None<T>():
        break;
    }
  }
}
