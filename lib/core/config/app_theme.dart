import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffb70b13),
      surfaceTint: Color(0xffbd1217),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdb2d29),
      onPrimaryContainer: Color(0xfffff8f7),
      secondary: Color(0xffa43b33),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffff8073),
      onSecondaryContainer: Color(0xff741814),
      tertiary: Color(0xff815000),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa26600),
      onTertiaryContainer: Color(0xfffff9f7),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff281715),
      onSurfaceVariant: Color(0xff5c403c),
      outline: Color(0xff906f6b),
      outlineVariant: Color(0xffe5bdb8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3f2c29),
      inversePrimary: Color(0xffffb4ab),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff410002),
      primaryFixedDim: Color(0xffffb4ab),
      onPrimaryFixedVariant: Color(0xff93000a),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff410002),
      secondaryFixedDim: Color(0xffffb4ab),
      onSecondaryFixedVariant: Color(0xff84241e),
      tertiaryFixed: Color(0xffffddb8),
      onTertiaryFixed: Color(0xff2a1700),
      tertiaryFixedDim: Color(0xffffb960),
      onTertiaryFixedVariant: Color(0xff653e00),
      surfaceDim: Color(0xfff2d3cf),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ee),
      surfaceContainer: Color(0xffffe9e6),
      surfaceContainerHigh: Color(0xffffe2de),
      surfaceContainerHighest: Color(0xfffbdbd8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff740006),
      surfaceTint: Color(0xffbd1217),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd22624),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff6c1210),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb74940),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4f2f00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9a6000),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff1c0d0b),
      onSurfaceVariant: Color(0xff4a2f2c),
      outline: Color(0xff694b48),
      outlineVariant: Color(0xff866561),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3f2c29),
      inversePrimary: Color(0xffffb4ab),
      primaryFixed: Color(0xffd22624),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xffae000e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffb74940),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff97322b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff9a6000),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff784b00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddc0bc),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ee),
      surfaceContainer: Color(0xffffe2de),
      surfaceContainerHigh: Color(0xfff5d6d2),
      surfaceContainerHighest: Color(0xffe9cbc7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff600004),
      surfaceTint: Color(0xffbd1217),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff98000b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5e0607),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff872620),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff412600),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff694000),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff3e2623),
      outlineVariant: Color(0xff5f423f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3f2c29),
      inversePrimary: Color(0xffffb4ab),
      primaryFixed: Color(0xff98000b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff6d0005),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff872620),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff670e0d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff694000),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4a2c00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcfb2af),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffedea),
      surfaceContainer: Color(0xfffbdbd8),
      surfaceContainerHigh: Color(0xffecceca),
      surfaceContainerHighest: Color(0xffddc0bc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb4ab),
      surfaceTint: Color(0xffffb4ab),
      onPrimary: Color(0xff690005),
      primaryContainer: Color(0xffdb2d29),
      onPrimaryContainer: Color(0xfffff8f7),
      secondary: Color(0xffffb4ab),
      onSecondary: Color(0xff640c0b),
      secondaryContainer: Color(0xff84241e),
      onSecondaryContainer: Color(0xffff9a8e),
      tertiary: Color(0xffffb960),
      onTertiary: Color(0xff472a00),
      tertiaryContainer: Color(0xffa26600),
      onTertiaryContainer: Color(0xfffff9f7),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1f0f0e),
      onSurface: Color(0xfffbdbd8),
      onSurfaceVariant: Color(0xffe5bdb8),
      outline: Color(0xffac8884),
      outlineVariant: Color(0xff5c403c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffbdbd8),
      inversePrimary: Color(0xffbd1217),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff410002),
      primaryFixedDim: Color(0xffffb4ab),
      onPrimaryFixedVariant: Color(0xff93000a),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff410002),
      secondaryFixedDim: Color(0xffffb4ab),
      onSecondaryFixedVariant: Color(0xff84241e),
      tertiaryFixed: Color(0xffffddb8),
      onTertiaryFixed: Color(0xff2a1700),
      tertiaryFixedDim: Color(0xffffb960),
      onTertiaryFixedVariant: Color(0xff653e00),
      surfaceDim: Color(0xff1f0f0e),
      surfaceBright: Color(0xff483432),
      surfaceContainerLowest: Color(0xff190a09),
      surfaceContainerLow: Color(0xff281715),
      surfaceContainer: Color(0xff2c1b19),
      surfaceContainerHigh: Color(0xff382523),
      surfaceContainerHighest: Color(0xff43302e),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd2cc),
      surfaceTint: Color(0xffffb4ab),
      onPrimary: Color(0xff540003),
      primaryContainer: Color(0xffff5449),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd2cc),
      onSecondary: Color(0xff540003),
      secondaryContainer: Color(0xffe56c60),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd5a7),
      onTertiary: Color(0xff382000),
      tertiaryContainer: Color(0xffc58325),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1f0f0e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffcd3ce),
      outline: Color(0xffcfa9a4),
      outlineVariant: Color(0xffab8884),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffbdbd8),
      inversePrimary: Color(0xff95000a),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff2d0001),
      primaryFixedDim: Color(0xffffb4ab),
      onPrimaryFixedVariant: Color(0xff740006),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff2d0001),
      secondaryFixedDim: Color(0xffffb4ab),
      onSecondaryFixedVariant: Color(0xff6c1210),
      tertiaryFixed: Color(0xffffddb8),
      onTertiaryFixed: Color(0xff1c0e00),
      tertiaryFixedDim: Color(0xffffb960),
      onTertiaryFixedVariant: Color(0xff4f2f00),
      surfaceDim: Color(0xff1f0f0e),
      surfaceBright: Color(0xff543f3d),
      surfaceContainerLowest: Color(0xff110504),
      surfaceContainerLow: Color(0xff2a1917),
      surfaceContainer: Color(0xff352321),
      surfaceContainerHigh: Color(0xff412e2c),
      surfaceContainerHighest: Color(0xff4d3936),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffece9),
      surfaceTint: Color(0xffffb4ab),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffaea5),
      onPrimaryContainer: Color(0xff220001),
      secondary: Color(0xffffece9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffaea5),
      onSecondaryContainer: Color(0xff220001),
      tertiary: Color(0xffffeddc),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfffeb453),
      onTertiaryContainer: Color(0xff140900),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1f0f0e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffece9),
      outlineVariant: Color(0xffe1bab5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffbdbd8),
      inversePrimary: Color(0xff95000a),
      primaryFixed: Color(0xffffdad6),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb4ab),
      onPrimaryFixedVariant: Color(0xff2d0001),
      secondaryFixed: Color(0xffffdad6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb4ab),
      onSecondaryFixedVariant: Color(0xff2d0001),
      tertiaryFixed: Color(0xffffddb8),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb960),
      onTertiaryFixedVariant: Color(0xff1c0e00),
      surfaceDim: Color(0xff1f0f0e),
      surfaceBright: Color(0xff614b48),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff2c1b19),
      surfaceContainer: Color(0xff3f2c29),
      surfaceContainerHigh: Color(0xff4b3734),
      surfaceContainerHighest: Color(0xff57423f),
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


  List<ExtendedColor> get extendedColors => [
  ];
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
