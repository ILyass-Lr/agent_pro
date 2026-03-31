import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffb90e1b),
      surfaceTint: Color(0xffbc121d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdd2f31),
      onPrimaryContainer: Color(0xfffffbff),
      secondary: Color(0xffa33c37),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffe8077),
      onSecondaryContainer: Color(0xff731918),
      tertiary: Color(0xff864f00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa96400),
      onTertiaryContainer: Color(0xfffffbff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff281716),
      onSurfaceVariant: Color(0xff5c403d),
      outline: Color(0xff906f6c),
      outlineVariant: Color(0xffe5bdb9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3e2c2a),
      inversePrimary: Color(0xffffb3ac),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff410003),
      primaryFixedDim: Color(0xffffb3ac),
      onPrimaryFixedVariant: Color(0xff930010),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff410003),
      secondaryFixedDim: Color(0xffffb3ac),
      onSecondaryFixedVariant: Color(0xff832422),
      tertiaryFixed: Color(0xffffdcbd),
      onTertiaryFixed: Color(0xff2c1600),
      tertiaryFixedDim: Color(0xffffb86e),
      onTertiaryFixedVariant: Color(0xff693c00),
      surfaceDim: Color(0xfff1d3d0),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ef),
      surfaceContainer: Color(0xffffe9e7),
      surfaceContainerHigh: Color(0xffffe2de),
      surfaceContainerHighest: Color(0xfffadcd8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff73000a),
      surfaceTint: Color(0xffbc121d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd2262a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff6c1313),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb64a44),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff512e00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9e5e00),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff1c0d0c),
      onSurfaceVariant: Color(0xff49302d),
      outline: Color(0xff684b48),
      outlineVariant: Color(0xff856562),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3e2c2a),
      inversePrimary: Color(0xffffb3ac),
      primaryFixed: Color(0xffd2262a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xffae0015),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffb64a44),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff96322e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff9e5e00),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff7c4800),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddc0bd),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ef),
      surfaceContainer: Color(0xffffe2de),
      surfaceContainerHigh: Color(0xfff4d6d3),
      surfaceContainerHighest: Color(0xffe9cbc8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff600007),
      surfaceTint: Color(0xffbc121d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff980011),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5d070a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff862724),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff432500),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c3e00),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff3e2624),
      outlineVariant: Color(0xff5e423f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3e2c2a),
      inversePrimary: Color(0xffffb3ac),
      primaryFixed: Color(0xff980011),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff6d0009),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff862724),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff670f10),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c3e00),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4c2b00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcfb2af),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffedeb),
      surfaceContainer: Color(0xfffadcd8),
      surfaceContainerHigh: Color(0xffecceca),
      surfaceContainerHighest: Color(0xffddc0bd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb3ac),
      surfaceTint: Color(0xffffb3ac),
      onPrimary: Color(0xff680008),
      primaryContainer: Color(0xffff544e),
      onPrimaryContainer: Color(0xff280001),
      secondary: Color(0xffffb3ac),
      onSecondary: Color(0xff640c0e),
      secondaryContainer: Color(0xff832422),
      onSecondaryContainer: Color(0xffff9991),
      tertiary: Color(0xffffb86e),
      onTertiary: Color(0xff492900),
      tertiaryContainer: Color(0xffcc7f1e),
      onTertiaryContainer: Color(0xff1a0b00),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1e0f0e),
      onSurface: Color(0xfffadcd8),
      onSurfaceVariant: Color(0xffe5bdb9),
      outline: Color(0xffac8885),
      outlineVariant: Color(0xff5c403d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffadcd8),
      inversePrimary: Color(0xffbc121d),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff410003),
      primaryFixedDim: Color(0xffffb3ac),
      onPrimaryFixedVariant: Color(0xff930010),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff410003),
      secondaryFixedDim: Color(0xffffb3ac),
      onSecondaryFixedVariant: Color(0xff832422),
      tertiaryFixed: Color(0xffffdcbd),
      onTertiaryFixed: Color(0xff2c1600),
      tertiaryFixedDim: Color(0xffffb86e),
      onTertiaryFixedVariant: Color(0xff693c00),
      surfaceDim: Color(0xff1e0f0e),
      surfaceBright: Color(0xff483433),
      surfaceContainerLowest: Color(0xff190a09),
      surfaceContainerLow: Color(0xff281716),
      surfaceContainer: Color(0xff2c1b1a),
      surfaceContainerHigh: Color(0xff372524),
      surfaceContainerHighest: Color(0xff43302e),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd2cd),
      surfaceTint: Color(0xffffb3ac),
      onPrimary: Color(0xff540005),
      primaryContainer: Color(0xffff544e),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd2cd),
      onSecondary: Color(0xff540005),
      secondaryContainer: Color(0xffe46c64),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd5ad),
      onTertiary: Color(0xff3a1f00),
      tertiaryContainer: Color(0xffcc7f1e),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1e0f0e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffcd3cf),
      outline: Color(0xffcfa9a5),
      outlineVariant: Color(0xffab8885),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffadcd8),
      inversePrimary: Color(0xff950011),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff2d0002),
      primaryFixedDim: Color(0xffffb3ac),
      onPrimaryFixedVariant: Color(0xff73000a),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff2d0002),
      secondaryFixedDim: Color(0xffffb3ac),
      onSecondaryFixedVariant: Color(0xff6c1313),
      tertiaryFixed: Color(0xffffdcbd),
      onTertiaryFixed: Color(0xff1e0d00),
      tertiaryFixedDim: Color(0xffffb86e),
      onTertiaryFixedVariant: Color(0xff512e00),
      surfaceDim: Color(0xff1e0f0e),
      surfaceBright: Color(0xff543f3d),
      surfaceContainerLowest: Color(0xff100504),
      surfaceContainerLow: Color(0xff2a1918),
      surfaceContainer: Color(0xff352322),
      surfaceContainerHigh: Color(0xff412e2c),
      surfaceContainerHighest: Color(0xff4d3937),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffecea),
      surfaceTint: Color(0xffffb3ac),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffaea6),
      onPrimaryContainer: Color(0xff220001),
      secondary: Color(0xffffecea),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffaea6),
      onSecondaryContainer: Color(0xff220001),
      tertiary: Color(0xffffedde),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffb360),
      onTertiaryContainer: Color(0xff150800),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1e0f0e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffecea),
      outlineVariant: Color(0xffe1bab6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffadcd8),
      inversePrimary: Color(0xff950011),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb3ac),
      onPrimaryFixedVariant: Color(0xff2d0002),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb3ac),
      onSecondaryFixedVariant: Color(0xff2d0002),
      tertiaryFixed: Color(0xffffdcbd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb86e),
      onTertiaryFixedVariant: Color(0xff1e0d00),
      surfaceDim: Color(0xff1e0f0e),
      surfaceBright: Color(0xff604b49),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff2c1b1a),
      surfaceContainer: Color(0xff3e2c2a),
      surfaceContainerHigh: Color(0xff4a3735),
      surfaceContainerHighest: Color(0xff574240),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
