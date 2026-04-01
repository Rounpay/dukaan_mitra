import 'package:flutter/gestures.dart';
import 'package:flutter_demo/core/network/ui_state.dart';
import 'package:flutter_demo/core/widgets/loader.dart';
import 'package:flutter_demo/core/widgets/text_field_with_label.dart';
import 'package:flutter_demo/modules/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/spacing.dart';
import '../../../core/widgets/rounded_button.dart';
import '../data/document_type_response.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /* SvgPicture.asset(
           // 'assets/svg/circle_scatter_haikei.svg',
            color: context.colorScheme.primaryContainer.withOpacityX(.1),
            fit: BoxFit.cover,
          ),*/
          SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacing.h48,
                  SafeArea(
                    bottom: false,
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: context.textStyle.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacing.h8,
                  Text(
                    "Create your Account!",
                    textAlign: TextAlign.center,
                    style: context.textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacing.h4,
                  Text(
                    'Fill in the details below to get started',
                    textAlign: TextAlign.center,
                    style: context.textStyle.bodySmall,
                  ),
                  Spacing.h32,

                  _SectionLabel(label: 'Full Name'),
                  TextFieldWithLabel(
                    controller: controller.fullNameController,
                    textInputType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                    hint: "Enter Your Full Name",
                    validator: (value) => (value?.trim().length ?? 0) < 3
                        ? "Enter valid full name"
                        : null,
                    prefix: Icon(
                      Icons.person_outline,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  Spacing.h8,

                  _SectionLabel(label: 'Mobile Number'),
                  TextFieldWithLabel(
                    controller: controller.mobileNumberController,
                    textInputType: TextInputType.phone,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    hint: "Enter Your Mobile Number",
                    textInputFormatter: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) => (value?.length ?? 0) != 10
                        ? "Enter valid 10-digit mobile number"
                        : null,
                    prefix: Icon(
                      Icons.phone_outlined,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  Spacing.h8,

                  _SectionLabel(label: 'Email'),
                  TextFieldWithLabel(
                    controller: controller.emailController,
                    textInputType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    hint: "Enter Your Email",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return null;
                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );
                      return emailRegex.hasMatch(value)
                          ? null
                          : "Enter valid email";
                    },
                    prefix: Icon(
                      Icons.mail_outline,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  Spacing.h8,

                  _SectionLabel(label: 'Password'),
                  PassWordTextFormFieldWithLabel(
                    controller: controller.passwordController,
                    hint: "Enter Your Password",
                    autofillHints: const [AutofillHints.newPassword],
                    textInputFormatter: [LengthLimitingTextInputFormatter(16)],
                    validator: (value) => (value?.length ?? 0) < 6
                        ? "Password must be at least 6 characters"
                        : null,
                  ),
                  Spacing.h8,
                  _SectionLabel(label: 'Address'),
                  TextFieldWithLabel(
                    controller: controller.addressController,
                    textInputType: TextInputType.streetAddress,
                    autofillHints: const [AutofillHints.streetAddressLine1],
                    hint: "Enter Your Address",
                    minLines: 2,
                    validator: (value) => value?.trim().isEmpty == true
                        ? "Address is required"
                        : null,
                    prefix: Icon(
                      Icons.home_outlined,
                      color: context.colorScheme.primaryContainer,
                    ),
                    borderRadius: 20,
                  ),
                  Spacing.h8,
                  _SectionLabel(label: 'City'),
                  TextFieldWithLabel(
                    controller: controller.cityController,
                    textInputType: TextInputType.text,
                    autofillHints: const [AutofillHints.addressCity],
                    hint: "Enter Your City",
                    validator: (value) => value?.trim().isEmpty == true
                        ? "City is required"
                        : null,
                    prefix: Icon(
                      Icons.location_city_outlined,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  Spacing.h8,
                  _SectionLabel(label: 'State'),
                  TextFieldWithLabel(
                    controller: controller.stateController,
                    textInputType: TextInputType.text,
                    autofillHints: const [AutofillHints.addressState],
                    hint: "Enter Your State",
                    validator: (value) => value?.trim().isEmpty == true
                        ? "State is required"
                        : null,
                    prefix: Icon(
                      Icons.map_outlined,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  Spacing.h8,
                  _SectionLabel(label: 'Pincode'),
                  TextFieldWithLabel(
                    controller: controller.pinCodeController,
                    textInputType: TextInputType.number,
                    autofillHints: const [AutofillHints.postalCode],
                    hint: "Enter Your Pincode",
                    textInputFormatter: [
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) => (value?.length ?? 0) != 6
                        ? "Enter valid 6-digit pincode"
                        : null,
                    prefix: Icon(
                      Icons.pin_drop_outlined,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  Spacing.h8,

                  _SectionLabel(label: 'Referral Agent ID (Optional)'),
                  TextFieldWithLabel(
                    controller: controller.referralAgentIdController,
                    textInputType: TextInputType.number,
                    hint: "Enter Referral Agent ID",
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    prefix: Icon(
                      Icons.confirmation_number_outlined,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  Spacing.h8,

                  Obx(() {
                    return controller.documentTypeState.value.when(
                      none: () => const SizedBox.shrink(),
                      loading: () => const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: Loader()),
                      ),
                      error: (msg) => ErrorWidget(msg),
                      success: (docs) {
                        final mandatory = docs
                            .where((d) => d.isMandatory == true)
                            .toList();
                        return RequiredDocumentsWidget(
                          requiredDocuments: mandatory,
                          documentFiles: controller.documentFiles,
                          onPick: controller.pickDocumentForType,
                          onRemove: controller.removeDocumentForType,
                        );
                      },
                    );
                  }),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RoundedButton(
                      radius: 10,
                      backgroundColor: context.colorScheme.primary,
                      foregroundColor: context.colorScheme.surface,
                      text: "Sign Up",
                      width: double.infinity,
                      onPressed: controller.signup,
                    ),
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: context.textStyle.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.onSurface,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: context.textStyle.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.primary,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.back();
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacing.h24,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*  Widget _requiredDocumentsWidget(BuildContext context) {
    final state = controller.documentTypeState.value;
    return state.when(
      none: () => const SizedBox.shrink(),
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          msg,
          style: TextStyle(color: context.colorScheme.error),
        ),
      ),
      success: (docs) {
        final mandatory = docs.where((d) => d.isMandatory == true).toList();
        if (mandatory.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Required Documents",
                style: context.textStyle.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacing.h8,
              ...mandatory.map((doc) {
                final typeId = doc.documentTypeId!;
                final filePath = controller.documentFiles[typeId];
                final isUploaded = filePath != null;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isUploaded
                        ? context.colorScheme.primaryContainer.withOpacity(.1)
                        : context.colorScheme.surfaceContainerLowest,
                    border: Border.all(
                      color: isUploaded
                          ? context.colorScheme.primary.withOpacity(.4)
                          : context.colorScheme.outline.withOpacity(.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isUploaded
                            ? Icons.check_circle_outline
                            : Icons.upload_file_outlined,
                        color: isUploaded
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurfaceVariant,
                      ),
                      Spacing.w8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc.documentName ?? '',
                              style: context.textStyle.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              isUploaded
                                  ? filePath.split('/').last
                                  : "Required  •  tap to upload",
                              style: context.textStyle.bodySmall?.copyWith(
                                color: isUploaded
                                    ? context.colorScheme.primary
                                    : context.colorScheme.error,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (isUploaded)
                        InkWell(
                          onTap: () => controller.removeDocumentForType(typeId),
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: context.colorScheme.error,
                          ),
                        )
                      else
                        InkWell(
                          onTap: () => controller.pickDocumentForType(typeId),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.colorScheme.primary,
                            ),
                            child: Text(
                              "Upload",
                              style: context.textStyle.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }*/
}

class RequiredDocumentsWidget extends StatelessWidget {
  final List<DocumentTypeResponse> requiredDocuments;
  final RxMap<int, String> documentFiles;
  final Future<void> Function(int) onPick;
  final void Function(int) onRemove;

  const RequiredDocumentsWidget({
    super.key,
    required this.requiredDocuments,
    required this.documentFiles,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (requiredDocuments.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Required Documents",
            style: context.textStyle.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacing.h8,
          Obx(
            () => Column(
              children: requiredDocuments.map((doc) {
                final typeId = doc.documentTypeId!;
                final filePath = documentFiles[typeId];
                final isUploaded = filePath != null;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isUploaded
                        ? context.colorScheme.primaryContainer.withOpacity(.1)
                        : context.colorScheme.surfaceContainerLowest,
                    border: Border.all(
                      color: isUploaded
                          ? context.colorScheme.primary.withOpacity(.4)
                          : context.colorScheme.outline.withOpacity(.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isUploaded
                            ? Icons.check_circle_outline
                            : Icons.upload_file_outlined,
                        color: isUploaded
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurfaceVariant,
                      ),
                      Spacing.w8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc.documentName ?? '',
                              style: context.textStyle.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              isUploaded
                                  ? filePath.split('/').last
                                  : "Required  •  tap to upload",
                              style: context.textStyle.bodySmall?.copyWith(
                                color: isUploaded
                                    ? context.colorScheme.primary
                                    : context.colorScheme.error,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (isUploaded)
                        InkWell(
                          onTap: () => onRemove(typeId),
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: context.colorScheme.error,
                          ),
                        )
                      else
                        InkWell(
                          onTap: () => onPick(typeId),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.colorScheme.primary,
                            ),
                            child: Text(
                              "Upload",
                              style: context.textStyle.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          label,
          textAlign: TextAlign.start,
          style: context.textStyle.bodyMedium,
        ),
      ),
    );
  }
}
