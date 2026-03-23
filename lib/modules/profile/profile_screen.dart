import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/core/theme/theme_colors.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_demo/route/app_routes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/common_controller.dart';
import '../../core/utils/extensions.dart';
import '../../core/widgets/custom_dialog.dart';
import '../../core/widgets/icon_text_button.dart';
import '../../core/widgets/rounded_button.dart';
import '../../core/widgets/text_field_with_label.dart';
import '../dashboard/dashboard_controller.dart';

class ProfileScreen extends GetView<DashboardController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Details"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: controller.profileImage.value != null
                          ? FileImage(controller.profileImage.value!)
                          : const AssetImage("assets/images/boy.png")
                                as ImageProvider,
                    );
                  }),

                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => showImagePickerSheet(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                return emailRegex.hasMatch(value) ? null : "Enter valid email";
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

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => passwordDialog(context),
                    );
                  },
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      color: context.colorScheme.error,
                      decoration: TextDecoration.underline,
                      decorationColor: context.colorScheme.error,
                    ),
                  ),
                ),
              ),
            ),
            Spacing.h8,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 50,
                child: RoundedButton(
                  text: "Save",
                  width: double.infinity,radius: 10,
                    backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.surface,
                  onPressed: () {
                  //  controller.updateProfile();
                  }
                ),
              ),
            ),
            Spacing.h16,
            IconTextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => CustomDialog(
                    title: 'Sure you want to Log-out ?',
                    icon: Icons.block,
                    iconColor:ThemeColors.colorRed,
                    primaryBtnText: 'Yes',
                    onPrimaryPressed: (){
                      CommonController.to.logout();
                      Get.back();
                    },
                    onCancelPressed: () {
                      Get.back();
                    }
                  )
                );
              },
              label: "Logout",
              icon: Icons.logout,
              color: context.colorScheme.primary,
            ),
            Spacing.h32,
          ],
        ),
      ),
    );
  }

  Widget passwordDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Spacing.h16,

            PassWordTextFormFieldWithLabel(
              controller: controller.newPasswordController,
              hint: "Enter New Password",
              autofillHints: const [AutofillHints.newPassword],
              textInputFormatter: [LengthLimitingTextInputFormatter(16)],
              validator: (value) =>
                  (value?.length ?? 0) < 6 ? "Minimum 6 characters" : null,
            ),
            Spacing.h12,

            PassWordTextFormFieldWithLabel(
              controller: controller.confirmPasswordController,
              hint: "Re-enter New Password",
              autofillHints: const [AutofillHints.newPassword],
              textInputFormatter: [LengthLimitingTextInputFormatter(16)],
              validator: (value) {
                if ((value?.length ?? 0) < 6) {
                  return "Minimum 6 characters";
                }
                if (value != controller.newPasswordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            Spacing.h16,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: RoundedButton(
                    radius: 10,
                    onPressed: () {
                      Get.back();
                    },
                    text: "Cancel",
                    backgroundColor: context.colorScheme.surfaceContainerHighest,
                    foregroundColor: context.colorScheme.onSurface,
                  ),
                ),
                Spacing.w8,
                Expanded(
                  child: RoundedButton(
                    radius: 10,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => CustomDialog(
                            title: 'Password Changed Successfully!',
                            icon: Icons.check_circle_outline,
                            iconColor: ThemeColors.colorGreen,
                            primaryBtnText: 'OK',
                            onPrimaryPressed: () {
                              Get.back();
                            },
                          )
                      );
                    },
                    text: "Done",
                    backgroundColor: context.colorScheme.primary,
                    foregroundColor: context.colorScheme.onPrimary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showImagePickerSheet(BuildContext context) {
    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.colorScheme.surface.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  "Choose Profile Picture",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                Spacing.h16,
                _buildPickerOption(
                  icon: Icons.camera_alt,
                  title: "Camera",
                  subtitle: "Take a new photo",
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.camera);
                  },
                  context,
                ),
                const SizedBox(height: 12),
                _buildPickerOption(
                  icon: Icons.photo_library,
                  title: "Gallery",
                  subtitle: "Choose from gallery",
                  onTap: () {
                    Get.back();
                    controller.pickImage(ImageSource.gallery);
                  },
                  context,
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildPickerOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.colorScheme.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: context.colorScheme.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: context.colorScheme.onSurface.withOpacity(
                              0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: context.colorScheme.primary.withOpacity(0.5),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
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
