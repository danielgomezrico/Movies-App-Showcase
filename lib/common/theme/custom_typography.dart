import 'package:flutter/material.dart';

import 'package:movie_flutter/common/theme/custom_color.dart';

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
