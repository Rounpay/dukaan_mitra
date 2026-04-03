import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/geo_location.dart';
import '../network/ui_state.dart';
import '../theme/theme_colors.dart';
import '../widgets/sorting_button.dart';

/// @Created by akash on 17-12-2025.
/// Know more about author at https://akash.cloudemy.in

extension PositionToGeoLocation on Position {
  Future<GeoLocation> toGeoLocation() async {
    final placemarks = await placemarkFromCoordinates(latitude, longitude);

    return GeoLocation.from(position: this, placemark: placemarks.first);
  }
}

extension ContextExtensions on BuildContext {
  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textStyle => theme.textTheme;
}

extension UiStateExt<T> on UiState<T> {
  T? get getDataOrNull => whenOrNull(success: (data) => data);

  String? get getErrorOrNull => whenOrNull(error: (msg) => msg);

  bool get isLoading => whenOrNull(loading: () => true) ?? false;

  bool get isError => whenOrNull(error: (e) => true) ?? false;

  bool get isSuccess => whenOrNull(success: (e) => true) ?? false;

  bool get isNone => whenOrNull(none: () => true) ?? false;
}

extension RxFileCompressX on Rx<File?> {
  Future<File?> compressIfLocal() async {
    final file = value;
    if (file == null) return null;
    if (file.path.startsWith("http")) return null;

    return await file.compressImage();
  }
}

extension ImageExtension on String {
  SvgPicture svg({Color? color, BlendMode blendMode = BlendMode.srcIn}) {
    return SvgPicture.asset(
      this,
      colorFilter: color != null ? ColorFilter.mode(color, blendMode) : null,
    );
  }

  Image img({
    Color? color,
    BlendMode? blendMode,
    BoxFit? fit,
    double? width,
    double? height,
  }) {
    return Image.asset(
      this,
      fit: fit,
      width: width,
      height: height,
      color: color,
      colorBlendMode: color != null ? blendMode : null,
    );
  }
}

extension ImageExtensions on XFile {
  Future<XFile> compressImage({int quality = 70}) async {
    var compressed = await FlutterImageCompress.compressAndGetFile(
      path,
      "${Directory.systemTemp.path}/$name${Platform.isAndroid ? ".jpg" : ""}",
      quality: quality,
    );
    if (compressed == null) {
      return this;
    }
    return compressed;
  }
}

extension ImageFileExtensions on File {
  Future<File> compressImage({int quality = 70}) async {
    var compressed = await FlutterImageCompress.compressAndGetFile(
      path,
      "${Directory.systemTemp.path}/$path${Platform.isAndroid ? ".jpg" : ""}",
      quality: quality,
    );
    if (compressed == null) {
      return this;
    }
    return File(compressed.path);
  }

  MultipartFile get toMultipartFile {
    return MultipartFile(path, filename: path.split("/").last);
  }
}

extension NullableListExt<T> on List<T>? {
  List<T> orEmpty() => this ?? [];
}

extension NonNullableListExt<T> on List<T> {
  T firstWhereOrFirst(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return first;
  }
}

extension LocaleExtension on Locale? {
  bool get isArabic => this?.languageCode == 'ar';
}

extension ColorExtension on Color {
  Color withOpacityX(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }
}

extension StringX on String {
  Color colorFromString() {
    // Generate a stable hash
    int hash = 0;
    for (int i = 0; i < length; i++) {
      hash = codeUnitAt(i) + ((hash << 5) - hash);
    }

    // Map hash to hue [0..360)
    final double hue = (hash % 360).toDouble();

    // Fixed saturation & lightness for light colors
    return HSLColor.fromAHSL(
      1, // alpha
      hue, // hue
      0.5, // saturation (soft)
      0.5, // lightness (light color)
    ).toColor();
  }
}

extension RxImageValidation on List<MapEntry<Rx<dynamic>, String>> {
  String? validate() {
    for (final e in this) {
      if (e.key.value == null) return e.value;
    }
    return null;
  }
}

extension SortOrderExt on SortOrder {
  String get label {
    switch (this) {
      case SortOrder.createdDesc:
        return '￪ Created';
      case SortOrder.createdAsc:
        return '￬ Created';
      case SortOrder.deliveryDesc:
        return '￪ Delivery';
      case SortOrder.deliveryAsc:
        return '￬ Delivery';
    }
  }

  bool get isAscending =>
      this == SortOrder.createdAsc || this == SortOrder.deliveryAsc;

  bool get isCreated =>
      this == SortOrder.createdAsc || this == SortOrder.createdDesc;
}

extension IterableX<T> on Iterable<T> {
  List<T> sortedBy(int? Function(T item) selector, {bool descending = false}) {
    final list = List<T>.from(this);

    list.sort((a, b) {
      final aVal = selector(a) ?? 0;
      final bVal = selector(b) ?? 0;
      return descending ? bVal.compareTo(aVal) : aVal.compareTo(bVal);
    });
    return list;
  }
}

extension StatusColorExtension on String {
  String get _normalized => toLowerCase().trim();
  bool get isSuccess =>
      _normalized == 'verified' ||
          _normalized == 'success' ||
          _normalized == 'approved';
  bool get isPending => _normalized == 'pending';
  bool get isRejected => _normalized == 'rejected';
  Color bgColor(ColorScheme colorScheme) {
    if (isSuccess) {
      return ThemeColors.colorGreen.withOpacity(0.1);
    } else if (isPending) {
      return Colors.orange.withOpacity(0.1);
    } else if (isRejected) {
      return ThemeColors.colorRed.withOpacity(0.1);
    }
    return colorScheme.surfaceVariant;
  }
  Color dotColor(ColorScheme colorScheme) {
    if (isSuccess) return ThemeColors.colorGreen;
    if (isPending) return ThemeColors.colorOrange;
    if (isRejected) return colorScheme.error;
    return colorScheme.onSurfaceVariant;
  }
  Color textColor(ColorScheme colorScheme) {
    return dotColor(colorScheme);
  }

}


extension RoleNavigationExtension on int? {
  bool get isFieldInspector => this == 4;
  bool get isDashboardUser => this == 6;

}


extension CallExtension on String {
  Future<void> call() async {
    final uri = Uri.parse("tel:$this");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Cannot make call";
    }
  }
}

extension FiStatusExtension on String? {
  String get _normalized => (this ?? '').toLowerCase().trim();
  bool get isAssigned => _normalized == 'assigned';
  bool get isCompleted => _normalized == 'completed';
  Color fiBgColor(ColorScheme colorScheme) {
    if (isCompleted) {
      return ThemeColors.colorGreen.withOpacity(0.1);
    } else if (isAssigned) {
      return ThemeColors.colorRed.withOpacity(0.1);
    }
    return colorScheme.surfaceVariant;
  }
  Color fiTextColor(ColorScheme colorScheme) {
    if (isCompleted) return ThemeColors.colorGreen;
    if (isAssigned) return ThemeColors.colorRed;
    return colorScheme.onSurfaceVariant;
  }
}