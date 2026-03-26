import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/core/network/ui_state.dart';
import 'package:flutter_demo/core/utils/spacing.dart';
import 'package:flutter_demo/core/widgets/error_text_widget.dart';
import 'package:flutter_demo/core/widgets/loader.dart';
import 'package:flutter_demo/modules/profile/update/update_profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/common_controller.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/rounded_button.dart';
import '../../../core/widgets/text_field_with_label.dart';
import '../../dashboard/dashboard_controller.dart';

class UpdateProfileScreen extends GetView<UpdateProfileController> {
  const UpdateProfileScreen({super.key});

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
                          : null,
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

            Spacing.h12,
            _SectionLabel(label: 'Uploaded Documents'),
            Spacing.h8,
            Obx(() {
              final state = CommonController.to.profileState.value;
              return state.when(
                success: (data) {
                  final docs = data.documents ?? [];
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: docs.length,
                    separatorBuilder: (_, _) => Spacing.h12,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      return _DocCard(
                        name: doc.documentName ?? '',
                        status: doc.verificationStatus ?? 'Pending',
                        filePath: doc.filePath,
                        uploadedDate: doc.uploadedDate,
                      );
                    },
                  );
                },
                loading: () => Center(child: Loader()),
                error: (error) => ErrorTextWidget(msg: error),
                none: () => const SizedBox(),
              );
            }),

            Spacing.h12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 50,
                child: RoundedButton(
                  text: "Save",
                  width: double.infinity,
                  radius: 10,
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.surface,
                  onPressed: () {
                    //  controller.updateProfile();
                  },
                ),
              ),
            ),
            Spacing.h80,
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

class _DocCard extends StatelessWidget {
  final String name;
  final String status;
  final String? filePath;
  final String? uploadedDate;

  const _DocCard({
    required this.name,
    required this.status,
    this.filePath,
    this.uploadedDate,
  });

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final dt = DateTime.parse(dateStr);
      return '${dt.day.toString().padLeft(2, '0')}/'
          '${dt.month.toString().padLeft(2, '0')}/'
          '${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:'
          '${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }
  bool get _isImage {
    if (filePath == null) return false;
    final lower = filePath!.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.webp');
  }
  IconData get _fileIcon {
    if (filePath == null) return Icons.insert_drive_file_outlined;
    final lower = filePath!.toLowerCase();
    if (lower.endsWith('.pdf')) return Icons.picture_as_pdf_outlined;
    if (lower.endsWith('.doc') || lower.endsWith('.docx')) return Icons.description_outlined;
    if (lower.endsWith('.zip') || lower.endsWith('.rar')) return Icons.folder_zip_outlined;
    return Icons.insert_drive_file_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final bgColor = status.bgColor(colorScheme);
    final dotColor = status.dotColor(colorScheme);
    final textColor = status.textColor(colorScheme);
    final formattedDate = _formatDate(uploadedDate);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 56,
              height: 56,
              color: colorScheme.surfaceVariant,
              child: _isImage && filePath != null
                  ? Image.network(
                filePath!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Loader(),
                    ),
                  );
                },
                errorBuilder: (_, _, _) => Icon(
                  Icons.broken_image_outlined,
                  color: colorScheme.onSurfaceVariant,
                  size: 24,
                ),
              )
                  : Icon(
                _fileIcon,
                color: colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
          ),

       Spacing.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textStyle.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacing.h4,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: dotColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Spacing.w4,
                      Text(
                        status,
                        style:  context.textStyle.labelSmall?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                if (formattedDate.isNotEmpty) ...[
                  Spacing.h4,
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      Spacing.w4,
                      Text(
                        formattedDate,
                        style:  context.textStyle.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
