import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/extensions.dart';
import '../utils/spacing.dart';

/// @Created by akash on 04-09-2025.
/// Know more about author at https://akash.cloudemy.in

final ImagePicker picker = ImagePicker();

class ImagePickerCard extends StatelessWidget {
  const ImagePickerCard({super.key, this.file, required this.onImageSelected});

  final File? file;
  final Function(File?) onImageSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.colorScheme.primary.withOpacity(.26),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: file != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(4),
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
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            onImageSelected(File(image.path));
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
                              Icon(
                                Icons.photo_outlined,
                                color: context.colorScheme.tertiary,
                                size: 36,
                              ),
                              Text(
                                " Gallery ",
                                style: context.textStyle.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 2,
                        color: context.colorScheme.outlineVariant.withOpacity(
                          .2,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      InkWell(
                        onTap: () async {
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.camera,
                          );
                          if (image != null) {
                            onImageSelected(File(image.path));
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
                              Icon(
                                Icons.camera_alt_outlined,
                                color: context.colorScheme.tertiary,
                                size: 36,
                              ),
                              Text(
                                "Camera",
                                style: context.textStyle.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacing.h8,
                  Text(
                    'Click to upload images'.tr,
                    style: context.textStyle.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
