import "package:flutter_demo/core/utils/extensions.dart";
import "package:flutter/material.dart";

import "../utils/extensions.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  ThemeData light() {
    return theme(
      const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff00387a),
        surfaceTint: Color(0xff275dae),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xff114fa0),
        onPrimaryContainer: Color(0xffa9c4ff),
        secondary: Color(0xff4e5e80),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xffc7d7fe),
        onSecondaryContainer: Color(0xff4d5d7e),
        tertiary: Color(0xff623da0),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xff7b56ba),
        onTertiaryContainer: Color(0xfff3e7ff),
        error: Color(0xffba1a1a),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff93000a),
        surface: Color(0xfff9f9ff),
        onSurface: Color(0xff191c21),
        onSurfaceVariant: Color(0xff424751),
        outline: Color(0xff737783),
        outlineVariant: Color(0xffc3c6d3),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff2e3036),
        inversePrimary: Color(0xffacc7ff),
        primaryFixed: Color(0xffd7e2ff),
        onPrimaryFixed: Color(0xff001a40),
        primaryFixedDim: Color(0xffacc7ff),
        onPrimaryFixedVariant: Color(0xff004492),
        secondaryFixed: Color(0xffd7e2ff),
        onSecondaryFixed: Color(0xff081b39),
        secondaryFixedDim: Color(0xffb6c7ed),
        onSecondaryFixedVariant: Color(0xff374766),
        tertiaryFixed: Color(0xffecdcff),
        onTertiaryFixed: Color(0xff270058),
        tertiaryFixedDim: Color(0xffd5bbff),
        onTertiaryFixedVariant: Color(0xff563093),
        surfaceDim: Color(0xffd9d9e1),
        surfaceBright: Color(0xfff9f9ff),
        surfaceContainerLowest: Color(0xffffffff),
        surfaceContainerLow: Color(0xfff3f3fb),
        surfaceContainer: Color(0xffededf5),
        surfaceContainerHigh: Color(0xffe7e7ef),
        surfaceContainerHighest: Color(0xffe2e2e9),
      ),
    );
  }

  ThemeData dark() {
    return theme(
      const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xffacc7ff),
        surfaceTint: Color(0xffacc7ff),
        onPrimary: Color(0xff002f67),
        primaryContainer: Color(0xff114fa0),
        onPrimaryContainer: Color(0xffa9c4ff),
        secondary: Color(0xffb6c7ed),
        onSecondary: Color(0xff20304f),
        secondaryContainer: Color(0xff394969),
        onSecondaryContainer: Color(0xffa8b8de),
        tertiary: Color(0xffd5bbff),
        onTertiary: Color(0xff3f147c),
        tertiaryContainer: Color(0xff7b56ba),
        onTertiaryContainer: Color(0xfff3e7ff),
        error: Color(0xffffb4ab),
        onError: Color(0xff690005),
        errorContainer: Color(0xff93000a),
        onErrorContainer: Color(0xffffdad6),
        surface: Color(0xff111318),
        onSurface: Color(0xffe2e2e9),
        onSurfaceVariant: Color(0xffc3c6d3),
        outline: Color(0xff8d909d),
        outlineVariant: Color(0xff424751),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xffe2e2e9),
        inversePrimary: Color(0xff275dae),
        primaryFixed: Color(0xffd7e2ff),
        onPrimaryFixed: Color(0xff001a40),
        primaryFixedDim: Color(0xffacc7ff),
        onPrimaryFixedVariant: Color(0xff004492),
        secondaryFixed: Color(0xffd7e2ff),
        onSecondaryFixed: Color(0xff081b39),
        secondaryFixedDim: Color(0xffb6c7ed),
        onSecondaryFixedVariant: Color(0xff374766),
        tertiaryFixed: Color(0xffecdcff),
        onTertiaryFixed: Color(0xff270058),
        tertiaryFixedDim: Color(0xffd5bbff),
        onTertiaryFixedVariant: Color(0xff563093),
        surfaceDim: Color(0xff111318),
        surfaceBright: Color(0xff37393f),
        surfaceContainerLowest: Color(0xff0c0e13),
        surfaceContainerLow: Color(0xff191c21),
        surfaceContainer: Color(0xff1d2025),
        surfaceContainerHigh: Color(0xff282a2f),
        surfaceContainerHighest: Color(0xff33353a),
      ),
    );
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );
}

/// displayLarge → size: 57.0, weight: FontWeight.w400
/// displayMedium → size: 45.0, weight: FontWeight.w400
/// displaySmall → size: 36.0, weight: FontWeight.w400
/// headlineLarge → size: 32.0, weight: FontWeight.w400
/// headlineMedium → size: 28.0, weight: FontWeight.w400
/// headlineSmall → size: 24.0, weight: FontWeight.w400
/// titleLarge → size: 22.0, weight: FontWeight.w400
/// titleMedium → size: 16.0, weight: FontWeight.w500
/// titleSmall → size: 14.0, weight: FontWeight.w500
/// bodyLarge → size: 16.0, weight: FontWeight.w400
/// bodyMedium → size: 14.0, weight: FontWeight.w400
/// bodySmall → size: 12.0, weight: FontWeight.w400
/// labelLarge → size: 14.0, weight: FontWeight.w500
/// labelMedium → size: 12.0, weight: FontWeight.w500
/// labelSmall → size: 11.0, weight: FontWeight.w500
TextTheme createTextTheme(
  BuildContext context,
  String bodyFontFamily,
  String displayFontFamily,
) {
  final base = Theme.of(context).textTheme;
  final bodyTextTheme = base.apply(fontFamily: bodyFontFamily);
  final displayTextTheme = base.apply(fontFamily: displayFontFamily);

  return bodyTextTheme.copyWith(
    /// displayLarge → size: 57.0, weight: FontWeight.w400
    /// displayMedium → size: 45.0, weight: FontWeight.w400
    /// displaySmall → size: 36.0, weight: FontWeight.w400
    displayLarge: displayTextTheme.displayLarge,
    displayMedium: displayTextTheme.displayMedium,
    displaySmall: displayTextTheme.displaySmall,

    /// headlineLarge → size: 32.0, weight: FontWeight.w400
    /// headlineMedium → size: 28.0, weight: FontWeight.w400
    /// headlineSmall → size: 24.0, weight: FontWeight.w400
    headlineLarge: displayTextTheme.headlineLarge,
    headlineMedium: displayTextTheme.headlineMedium,
    headlineSmall: bodyTextTheme.headlineSmall,

    /// titleLarge → size: 22.0, weight: FontWeight.w400
    /// titleMedium → size: 16.0, weight: FontWeight.w500
    /// titleSmall → size: 14.0, weight: FontWeight.w500
    titleLarge: bodyTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    titleMedium: bodyTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    titleSmall: bodyTextTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),

    /// bodyLarge → size: 16.0, weight: FontWeight.w400
    /// bodyMedium → size: 14.0, weight: FontWeight.w400
    /// bodySmall → size: 12.0, weight: FontWeight.w400
    bodyLarge: bodyTextTheme.bodyLarge?.copyWith(color: context.colorScheme.outlineVariant),
    bodyMedium: bodyTextTheme.bodyMedium?.copyWith(color: context.colorScheme.outlineVariant),
    bodySmall: bodyTextTheme.bodySmall?.copyWith(color: context.colorScheme.outlineVariant),

    /// labelLarge → size: 14.0, weight: FontWeight.w500
    /// labelMedium → size: 12.0, weight: FontWeight.w500
    /// labelSmall → size: 11.0, weight: FontWeight.w500
    labelLarge: bodyTextTheme.labelLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: context.colorScheme.outlineVariant,
    ),
    labelMedium: bodyTextTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: context.colorScheme.outlineVariant,
    ),
    labelSmall: bodyTextTheme.labelSmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: context.colorScheme.outlineVariant,
    ),
  );
}

void printAllFontSizes(BuildContext context) {
  final t = context.textStyle;

  void log(String name, TextStyle? s) {
    debugPrint(
      '$name → size: ${s?.fontSize}, weight: ${s?.fontWeight}',
    );
  }

  log('displayLarge', t.displayLarge);
  log('displayMedium', t.displayMedium);
  log('displaySmall', t.displaySmall);

  log('headlineLarge', t.headlineLarge);
  log('headlineMedium', t.headlineMedium);
  log('headlineSmall', t.headlineSmall);

  log('titleLarge', t.titleLarge);
  log('titleMedium', t.titleMedium);
  log('titleSmall', t.titleSmall);

  log('bodyLarge', t.bodyLarge);
  log('bodyMedium', t.bodyMedium);
  log('bodySmall', t.bodySmall);

  log('labelLarge', t.labelLarge);
  log('labelMedium', t.labelMedium);
  log('labelSmall', t.labelSmall);
}

