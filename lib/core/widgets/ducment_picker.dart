import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/extensions.dart';
import '../utils/spacing.dart';

class DocumentPickerBottomSheet extends StatelessWidget {
  final Function(String path) onFilePicked;

  const DocumentPickerBottomSheet({super.key, required this.onFilePicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Spacing.h16,
            Text(
              "Upload Document",
              style: context.textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacing.h4,
            Text(
              "Choose how you'd like to upload",
              style: context.textStyle.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            Spacing.h24,
            Row(
              children: [
                Expanded(
                  child: _PickerOption(
                    icon: Icons.camera_alt_outlined,
                    label: "Camera",
                    onTap: () async {
                      Get.back();
                      final XFile? image = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        imageQuality: 85,
                      );
                      if (image != null) onFilePicked(image.path);
                    },
                  ),
                ),
                Spacing.w12,
                Expanded(
                  child: _PickerOption(
                    icon: Icons.photo_library_outlined,
                    label: "Gallery",
                    onTap: () async {
                      Get.back();
                      final XFile? image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 85,
                      );
                      if (image != null) onFilePicked(image.path);
                    },
                  ),
                ),
                Spacing.w12,
                Expanded(
                  child: _PickerOption(
                    icon: Icons.insert_drive_file_outlined,
                    label: "Document",
                    onTap: () async {
                      Get.back();
                      final result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
                      );
                      if (result != null && result.paths.first != null) {
                        onFilePicked(result.paths.first!);
                      }
                    },
                  ),
                ),
              ],
            ),
            Spacing.h16,
            TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                foregroundColor: context.colorScheme.error,
                side: BorderSide(color: context.colorScheme.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: context.colorScheme.primaryContainer.withOpacity(.08),
          border: Border.all(
            color: context.colorScheme.outline.withOpacity(.15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withOpacity(.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: context.colorScheme.primary, size: 28),
            ),
            Spacing.h8,
            Text(
              label,
              style: context.textStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
