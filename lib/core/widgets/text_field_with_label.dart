/// @Created by akash on 16-02-2024.
/// Know more about author at https://akash.cloudemy.in

import 'package:flutter_demo/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String? label;
  final String? hint;
  final int minLines;
  final double borderRadius;
  final Widget? suffix;
  final Widget? prefix;
  final bool enabled;
  final bool readOnly;
  final bool filled;
  final int? maxLines;
  final bool isLoading;
  final bool? isDense;
  final TextInputType textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization? textCapitalization;
  final Color? fillColor;
  final Color? themeColor;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputAction? inputAction;
  final ValueChanged<String>? onSubmitted;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final Iterable<String>? autofillHints;

  const TextFieldWithLabel({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.textInputType = TextInputType.text,
    this.textInputFormatter,
    this.minLines = 1,
    this.maxLines,
    this.enabled = true,
    this.validator,
    this.suffix,
    this.borderSide,
    this.contentPadding,
    this.textStyle,
    this.textCapitalization,
    this.fillColor,
    this.themeColor,
    this.hintTextStyle,
    this.padding,
    this.prefix,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.borderRadius = 32,
    this.inputAction,
    this.onSubmitted,
    this.focusNode,
    this.floatingLabelBehavior,
    this.autofillHints,
    this.isDense,
    this.isLoading = false,  this.filled=true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: TextFormField(
        enabled: enabled,
        validator: validator,
        textDirection: textDirection,
        textAlign: textAlign,

        autofillHints: autofillHints,
        readOnly: readOnly,
        onTap: onTap,
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(FocusNode()),
        controller: controller,
        textCapitalization:
            textCapitalization ??
            (minLines == 1
                ? TextCapitalization.words
                : TextCapitalization.sentences),
        style:
            textStyle ??
            context.textStyle.bodyMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        keyboardType: textInputType,
        maxLines: minLines,
        minLines: minLines,

        focusNode: focusNode,
        onFieldSubmitted:
            onSubmitted /*?? ((str) => FocusScope.of(context).nextFocus())*/,
        textInputAction: inputAction ?? TextInputAction.next,
        cursorColor: themeColor ?? context.colorScheme.primaryContainer,
        inputFormatters: textInputFormatter,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: context.textStyle.bodyMedium,
          isDense: isDense,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  themeColor ??
                  context.colorScheme.outlineVariant.withAlpha(120),
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: themeColor ?? context.colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: themeColor ?? context.colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          hintText: hint?.toString() ?? "",
          hintStyle:
              hintTextStyle ??
              context.textStyle.bodyMedium?.copyWith(
                color: context.colorScheme.outlineVariant,
              ),
          fillColor: fillColor ?? context.colorScheme.surfaceContainerLowest,
          filled: filled,
          contentPadding: contentPadding,
          floatingLabelBehavior:
              floatingLabelBehavior ?? FloatingLabelBehavior.auto,

          suffixIcon: suffix,
          prefixIconConstraints: isLoading
              ? BoxConstraints(minHeight: 18, minWidth: 18)
              : null,
          prefixIcon: isLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CircularProgressIndicator(
                    constraints: BoxConstraints(minHeight: 18, minWidth: 18),
                    strokeWidth: 2,
                  ),
                )
              : prefix,
        ),
      ),
    );
  }
}

class DropDownTextField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<T> items;
  final Widget? prefix;
  final String Function(T item) getTitle;
  final ValueChanged<T?> onChanged;
  final bool? isDense;
  final bool isLoading;
  final bool filled;
  final FormFieldValidator<T?>? validator;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? themeColor;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;

  const DropDownTextField({
    super.key,
    this.isDense,
    required this.getTitle,
    this.value,
    required this.items,
    this.prefix,
    required this.label,
    this.hint = "",
    required this.onChanged,
    this.validator,
    this.contentPadding,
    this.fillColor,
    this.themeColor,
    this.focusNode,
    this.padding,
    this.isLoading = false,  this.filled=true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<T>(
            initialValue: value,
            validator: validator,
            style: context.textStyle.bodyMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
            hint: Text(hint),
            onChanged: onChanged,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: context.textStyle.bodyMedium,
              isDense: isDense,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      themeColor ??
                      context.colorScheme.outlineVariant.withAlpha(120),
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: themeColor ?? context.colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: themeColor ?? context.colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              hintStyle: context.textStyle.bodyMedium?.copyWith(
                color: context.colorScheme.outlineVariant,
              ),
              fillColor:
                  fillColor ?? context.colorScheme.surfaceContainerLowest,
              filled: filled,
              contentPadding: contentPadding,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              suffixIcon: Icon(Icons.arrow_drop_down_outlined),
              prefixIconConstraints: isLoading
                  ? BoxConstraints(minHeight: 18, minWidth: 18)
                  : null,
              prefixIcon: isLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CircularProgressIndicator(
                        constraints: BoxConstraints(
                          minHeight: 18,
                          minWidth: 18,
                        ),
                        strokeWidth: 2,
                      ),
                    )
                  : prefix,
            ),
            items: items
                .map(
                  (e) =>
                      DropdownMenuItem<T>(value: e, child: Text(getTitle(e))),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class PassWordTextFormFieldWithLabel extends StatelessWidget {
  final String? label;
  final String? hint;
  final bool enabled;
  final bool filled;
  final bool showPrefixIcon;
  final List<TextInputFormatter>? textInputFormatter;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Iterable<String>? autofillHints;
  final TextInputAction? inputAction;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Color? fillColor;
  final Color? themeColor;
  final EdgeInsetsGeometry? padding;
  final _obscureText = true.obs;

  PassWordTextFormFieldWithLabel({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.textInputFormatter,
    this.enabled = true,
    this.showPrefixIcon = true,
    this.validator,
    this.labelTextStyle,
    this.textStyle,
    this.fillColor,
    this.themeColor,
    this.hintTextStyle,
    this.inputAction,
    this.autofillHints,
    this.padding,  this.filled=true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding:
            padding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: TextFormField(
          enabled: enabled,
          validator: validator,
          autofillHints: autofillHints,
          onTapOutside: (event) =>
              FocusScope.of(context).requestFocus(FocusNode()),
          controller: controller,
          style:
              textStyle ??
              context.textStyle.bodyMedium?.copyWith(
                color: context.colorScheme.primary,
              ),
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          obscureText: _obscureText.value,
          minLines: 1,
          textInputAction: inputAction ?? TextInputAction.next,
          cursorColor: themeColor ?? context.colorScheme.primaryContainer,
          inputFormatters: textInputFormatter,
          decoration: InputDecoration(
            labelText: label,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    themeColor ??
                    context.colorScheme.outlineVariant.withAlpha(120),
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: themeColor ?? context.colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: themeColor ?? context.colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            hintText: hint?.toString() ?? "",
            hintStyle:
                hintTextStyle ??
                context.textStyle.bodyMedium?.copyWith(
                  color: context.colorScheme.outlineVariant,
                ),
            fillColor: fillColor ?? context.colorScheme.surfaceContainerLowest,
            filled: filled,
            prefixIcon: showPrefixIcon
                ? Icon(
                    Icons.lock_outline,
                    color: context.colorScheme.primaryContainer,
                  )
                : null,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  _obscureText.value ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  _obscureText.value = !_obscureText.value;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
