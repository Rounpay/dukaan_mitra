import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter_demo/core/widgets/text_field_with_label.dart';

/// @Created by akash on 29-12-2025.
/// Know more about author at https://akash.cloudemy.in

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.padding,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.label,
    this.readOnly = false, this.hint,
  });

  final EdgeInsetsGeometry? padding;
  final TextEditingController controller;
  final Function(String? value)? onChanged;
  final Function(String? value)? onSubmitted;

  final String? label;
  final String? hint;
  final bool readOnly;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    var isEmpty = controller.text.isEmpty.obs;
    return TextFieldWithLabel(
      controller: controller,
      padding: padding,
      label: label,
      readOnly: readOnly,
      isDense: true,
      hint: hint??"Search",
      focusNode: focusNode,
      textInputType: TextInputType.text,
      onChanged: (value) {
        onChanged?.call(value);
        isEmpty.value = controller.text.isEmpty;
      },
      onSubmitted: onSubmitted,
      inputAction: TextInputAction.search,
      suffix: Obx(
        () => isEmpty.value
            ? SizedBox()
            : IconButton(
                onPressed: () {
                  controller.text = '';
                  isEmpty.value = controller.text.isEmpty;
                  onChanged?.call(null);
                  onSubmitted?.call(null);
                },
                icon: Icon(
                  Icons.close,
                  color: context.colorScheme.outlineVariant,
                ),
              ),
      ),
      prefix: Icon(Icons.search, color: context.colorScheme.outlineVariant),
    );
  }
}
/*
class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.padding,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.readOnly = false,
    this.hint,
  });

  final EdgeInsetsGeometry? padding;
  final TextEditingController controller;
  final Function(String? value)? onChanged;
  final Function(String? value)? onSubmitted;
  final bool readOnly;
  final FocusNode? focusNode;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    var isEmpty = controller.text.isEmpty.obs;

    return Padding(
      padding:
      padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(
            () => Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            readOnly: readOnly,
            onChanged: (value) {
              onChanged?.call(value);
              isEmpty.value = value.isEmpty;
            },
            onSubmitted: onSubmitted,
            textInputAction: TextInputAction.search,
            style: TextStyle(color: context.colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: hint ?? "Search any Product..",
              hintStyle: context.textStyle.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              border: InputBorder.none,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 12),

              prefixIcon: Icon(
                Icons.search,
                color: context.colorScheme.onSurfaceVariant,
              ),


              suffixIcon: isEmpty.value
                  ? null
                  : IconButton(
                onPressed: () {
                  controller.clear();
                  isEmpty.value = true;
                  onChanged?.call(null);
                  onSubmitted?.call(null);
                },
                icon: Icon(
                  Icons.close,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
