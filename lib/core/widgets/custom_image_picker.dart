import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/common_methods.dart';
import '../utils/extensions.dart';
import '../utils/spacing.dart';
import 'dotted_border.dart';

final ImagePicker picker = ImagePicker();

class CustomImagePickerCard extends StatelessWidget {
  const CustomImagePickerCard({super.key, this.file, required this.child, required this.onImageSelected});

  final File? file;
  final Widget child;
  final Function(File?) onImageSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: file != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.colorScheme.primary.withOpacity(.26), width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: file?.path.startsWith("http") == true
                          ? Image.network(file!.path, fit: BoxFit.cover)
                          : Image.file(file!, fit: BoxFit.cover),
                    ),
                    IconButton(
                      onPressed: () {
                        onImageSelected.call(null);
                      },
                      icon: const Icon(Icons.delete_forever, color: Colors.red),
                    ),
                  ],
                ),
              ),
            )
          : InkWell(onTap: () => shopImagePickerOptionSheet(context,onImageSelected), child: child),
    );
  }


}
void shopImagePickerOptionSheet(BuildContext context, Function(File?) onImageSelected) {
  openBottomSheet(
    isScrollControlled: true,
    title: "Select Image From",
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      onImageSelected(File(image.path));
                      Get.back();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.tertiary.withOpacity(.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo_outlined, color: context.colorScheme.tertiary, size: 36),
                        Text(" Gallery ", style: context.textStyle.labelMedium),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 2,
                  color: context.colorScheme.outlineVariant.withOpacity(.2),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                InkWell(
                  onTap: () async {
                    final XFile? image = await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      onImageSelected(File(image.path));
                      Get.back();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.tertiary.withOpacity(.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Icon(Icons.camera_alt_outlined, color: context.colorScheme.tertiary, size: 36),
                        Text("Camera", style: context.textStyle.labelMedium),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Spacing.h8,
            Text('Click to upload images'.tr, style: context.textStyle.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    ),
  );
}
