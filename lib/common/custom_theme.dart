import 'package:flutter/material.dart';

abstract class CustomTheme {
  static final ThemeData light = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
    useMaterial3: true,
  );

  static final ThemeData dark = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.dark,
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

abstract class CustomTypography {
  static const displayXXLarge = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 48,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const displayXLarge = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 40,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const displayLarge = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 32,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const displayMedium = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 28,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const displaySmall = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 24,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const headlineLarge = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 32,
    fontWeight: CustomFontWeight.regular,
  );

  static const headlineMedium = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 28,
    fontWeight: CustomFontWeight.regular,
  );

  static const headlineSmall = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 24,
    fontWeight: CustomFontWeight.regular,
  );

  static const titleLarge = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 28,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const titleMedium = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 24,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const titleSmall = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 22,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodyXLarge = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 18,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodyLarge = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 16,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodyLarge700 = TextStyle(
    color: CustomColor.neutral700,
    fontSize: 16,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodyLarge500 = TextStyle(
    color: CustomColor.neutral500,
    fontSize: 16,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodyRegular700 = TextStyle(
    color: CustomColor.neutral700,
    fontSize: 14,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodyMedium = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 14,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodySmall = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 12,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodySmall500 = TextStyle(
    color: CustomColor.neutral500,
    fontSize: 12,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodySmall700 = TextStyle(
    color: CustomColor.neutral700,
    fontSize: 12,
    fontWeight: CustomFontWeight.regular,
  );

  static const bodyXXLargeSemiBold = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 20,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodyXLargeSemiBold = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 18,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodyLargeSemiBold = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 16,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodyLargeSemiBold700 = TextStyle(
    color: CustomColor.neutral700,
    fontSize: 16,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodyMediumSemiBold = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 14,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodyMediumSemiBold700 = TextStyle(
    color: CustomColor.neutral700,
    fontSize: 14,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodySmallSemiBold = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 12,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const bodySmallSemiBold500 = TextStyle(
    color: CustomColor.neutral500,
    fontSize: 12,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const labelLarge = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 14,
    fontWeight: CustomFontWeight.regular,
  );

  static const labelMedium = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 12,
    fontWeight: CustomFontWeight.regular,
  );

  static const labelMedium500 = TextStyle(
    color: CustomColor.neutral500,
    fontSize: 12,
    fontWeight: CustomFontWeight.regular,
  );

  static const labelSmall = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 10,
    fontWeight: CustomFontWeight.regular,
  );

  static const labelSemiBold = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 12,
    fontWeight: CustomFontWeight.semiBold,
  );

  static const captionLarge = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 16,
    fontWeight: CustomFontWeight.regular,
  );

  static const captionMedium = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 14,
    fontWeight: CustomFontWeight.regular,
    height: 1.28,
  );

  static const captionSmall = TextStyle(
    color: CustomColor.neutral1000,
    fontSize: 12,
    fontWeight: CustomFontWeight.regular,
  );
}

abstract class CustomFontWeight {
  static const regular = FontWeight.w400;
  static const semiBold = FontWeight.w600;
}

abstract class CustomColor {
  static const Color neutral1000 = Color(0xFF000000);
  static const Color neutral700 = Color(0xFF333333);
  static const Color neutral500 = Color(0xFF666666);
}
