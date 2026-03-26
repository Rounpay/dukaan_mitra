import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/common_controller.dart';
import '../../../core/network/base_res.dart';
import '../../../core/network/ui_state.dart';
import '../../../core/utils/common_methods.dart';
import '../data/auth_repo.dart';
import '../data/document_type_response.dart';

class SignupController extends GetxController {
  final AuthRepo repo;

  SignupController({required this.repo});

  final signupState = UiState<BaseRes>.none().obs;
  final documentTypeState = UiState<List<DocumentTypeResponse>>.none().obs;

  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final referralAgentIdController = TextEditingController();

  final documentFiles = <int, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDocumentTypes();
  }

  Future<void> fetchDocumentTypes() async {
    return repo.getDocumentTypeRepo((state) {
      documentTypeState.value = state;
    });
  }

  List<DocumentTypeResponse> get mandatoryDocs {
    return documentTypeState.value.maybeWhen(
      success: (data) => data.where((d) => d.isMandatory == true).toList(),
      orElse: () => [],
    );
  }

  Future<void> pickDocumentForType(int documentTypeId) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null && result.paths.first != null) {
      documentFiles[documentTypeId] = result.paths.first!;
      documentFiles.refresh();
    }
  }


  void removeDocumentForType(int documentTypeId) {
    documentFiles.remove(documentTypeId);
    documentFiles.refresh();
  }

  void signup() {
    if (formKey.currentState?.validate() == false) return;
    final missingDocs = mandatoryDocs
        .where((doc) => !documentFiles.containsKey(doc.documentTypeId))
        .map((doc) => doc.documentName ?? '')
        .toList();
    if (missingDocs.isNotEmpty) {
      Get.snackbar(
        "Documents Missing",
        "Please upload: ${missingDocs.join(', ')}",
        backgroundColor: Colors.red.shade100,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    final formData = FormData({
      'FullName': fullNameController.text.trim(),
      'MobileNumber': mobileNumberController.text.trim(),
      'Email': emailController.text.trim().isEmpty
          ? ""
          : emailController.text.trim(),
      'Password': passwordController.text.trim(),
      'Address': addressController.text.trim(),
      'City': cityController.text.trim(),
      'State': stateController.text.trim(),
      'Pincode': pinCodeController.text.trim(),
      'ReferralAgentId':
          int.tryParse(referralAgentIdController.text.trim()) ?? 0,
    });

    int i = 0;

    for (final entry in documentFiles.entries) {
      final filePath = entry.value;

      formData.files.add(
        MapEntry(
          'Documents[$i].file',
          MultipartFile(
            File(filePath).readAsBytesSync(),
            filename: filePath.split('/').last,
          ),
        ),
      );

      formData.fields.add(
        MapEntry('Documents[$i].documentTypeId', '${entry.key}'),
      );

      i++;
    }

    print("----- FORM DATA FIELDS -----");
    formData.fields.forEach((field) {
      print("${field.key} : ${field.value}");
    });

    print("----- FORM DATA FILES -----");
    formData.files.forEach((file) {
      print("${file.key} : ${file.value.filename}");
    });

    repo.customerSignup(formData, (state) {
      signupState.value = state;
      state.handleWithErrorBox(
          showLoader: false, (data) async {
        showSuccessToast("Signup Successful");
        await CommonController.to.fetchProfile(isRefresh: true);
        Get.back();
      });
    });
  }
}
