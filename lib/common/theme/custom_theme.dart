import 'package:flutter/material.dart';
import 'package:movie_flutter/common/theme/custom_color.dart';
import 'package:movie_flutter/common/theme/custom_typography.dart';

abstract class CustomTheme {
  static final ThemeData light = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColor.primary,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    ),
    useMaterial3: true,
  );

  static final ThemeData dark = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColor.primary,
      brightness: Brightness.dark,
      dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
    ),
  );

  static TextTheme create() {
    return const TextTheme(
      displayLarge: CustomTypography.displayLarge,
      displayMedium: CustomTypography.displayMedium,
      displaySmall: CustomTypography.displaySmall,
      headlineLarge: CustomTypography.headlineLarge,
      headlineMedium: CustomTypography.headlineMedium,
      headlineSmall: CustomTypography.headlineSmall,
      titleLarge: CustomTypography.titleLarge,
      titleMedium: CustomTypography.titleMedium,
      titleSmall: CustomTypography.titleSmall,
      bodyLarge: CustomTypography.bodyLarge,
      bodyMedium: CustomTypography.bodyMedium,
      bodySmall: CustomTypography.bodySmall,
      labelLarge: CustomTypography.labelLarge,
      labelMedium: CustomTypography.labelMedium,
      labelSmall: CustomTypography.labelSmall,
    );
  }
}
