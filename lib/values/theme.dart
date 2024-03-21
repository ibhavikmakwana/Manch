/*
 * BSD 2-Clause License
 *
 * Copyright (c) 2021, Bhavik Makwana
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4287515952),
      surfaceTint: Color(4287515952),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294958030),
      onPrimaryContainer: Color(4281798144),
      secondary: Color(4286011211),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4294958030),
      onSecondaryContainer: Color(4281079308),
      tertiary: Color(4285030192),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4293977000),
      onTertiaryContainer: Color(4280359936),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294965494),
      onBackground: Color(4280490518),
      surface: Color(4294965494),
      onSurface: Color(4280490518),
      surfaceVariant: Color(4294303446),
      onSurfaceVariant: Color(4283646782),
      outline: Color(4286935917),
      outlineVariant: Color(4292395706),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281871914),
      inverseOnSurface: Color(4294962663),
      inversePrimary: Color(4294948248),
      primaryFixed: Color(4294958030),
      onPrimaryFixed: Color(4281798144),
      primaryFixedDim: Color(4294948248),
      onPrimaryFixedVariant: Color(4285609500),
      secondaryFixed: Color(4294958030),
      onSecondaryFixed: Color(4281079308),
      secondaryFixedDim: Color(4293377710),
      onSecondaryFixedVariant: Color(4284301365),
      tertiaryFixed: Color(4293977000),
      onTertiaryFixed: Color(4280359936),
      tertiaryFixedDim: Color(4292069262),
      onTertiaryFixedVariant: Color(4283385627),
      surfaceDim: Color(4293449424),
      surfaceBright: Color(4294965494),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963692),
      surfaceContainer: Color(4294765284),
      surfaceContainerHigh: Color(4294370526),
      surfaceContainerHighest: Color(4294041561),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4285280792),
      surfaceTint: Color(4287515952),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4289290820),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4283972657),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4287589728),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283122455),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4286543172),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294965494),
      onBackground: Color(4280490518),
      surface: Color(4294965494),
      onSurface: Color(4280490518),
      surfaceVariant: Color(4294303446),
      onSurfaceVariant: Color(4283318330),
      outline: Color(4285291605),
      outlineVariant: Color(4287199088),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281871914),
      inverseOnSurface: Color(4294962663),
      inversePrimary: Color(4294948248),
      primaryFixed: Color(4289290820),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4287318574),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4287589728),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4285814088),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4286543172),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4284832814),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293449424),
      surfaceBright: Color(4294965494),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963692),
      surfaceContainer: Color(4294765284),
      surfaceContainerHigh: Color(4294370526),
      surfaceContainerHighest: Color(4294041561),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4282520320),
      surfaceTint: Color(4287515952),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4285280792),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281605139),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283972657),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280820224),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283122455),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294965494),
      onBackground: Color(4280490518),
      surface: Color(4294965494),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4294303446),
      onSurfaceVariant: Color(4281213212),
      outline: Color(4283318330),
      outlineVariant: Color(4283318330),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281871914),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294961119),
      primaryFixed: Color(4285280792),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283440389),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283972657),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282394396),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283122455),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281609475),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293449424),
      surfaceBright: Color(4294965494),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963692),
      surfaceContainer: Color(4294765284),
      surfaceContainerHigh: Color(4294370526),
      surfaceContainerHighest: Color(4294041561),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294948248),
      surfaceTint: Color(4294948248),
      onPrimary: Color(4283768839),
      primaryContainer: Color(4285609500),
      onPrimaryContainer: Color(4294958030),
      secondary: Color(4293377710),
      onSecondary: Color(4282657312),
      secondaryContainer: Color(4284301365),
      onSecondaryContainer: Color(4294958030),
      tertiary: Color(4292069262),
      onTertiary: Color(4281872390),
      tertiaryContainer: Color(4283385627),
      onTertiaryContainer: Color(4293977000),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279898382),
      onBackground: Color(4294041561),
      surface: Color(4279898382),
      onSurface: Color(4294041561),
      surfaceVariant: Color(4283646782),
      onSurfaceVariant: Color(4292395706),
      outline: Color(4288712070),
      outlineVariant: Color(4283646782),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294041561),
      inverseOnSurface: Color(4281871914),
      inversePrimary: Color(4287515952),
      primaryFixed: Color(4294958030),
      onPrimaryFixed: Color(4281798144),
      primaryFixedDim: Color(4294948248),
      onPrimaryFixedVariant: Color(4285609500),
      secondaryFixed: Color(4294958030),
      onSecondaryFixed: Color(4281079308),
      secondaryFixedDim: Color(4293377710),
      onSecondaryFixedVariant: Color(4284301365),
      tertiaryFixed: Color(4293977000),
      onTertiaryFixed: Color(4280359936),
      tertiaryFixedDim: Color(4292069262),
      onTertiaryFixedVariant: Color(4283385627),
      surfaceDim: Color(4279898382),
      surfaceBright: Color(4282529587),
      surfaceContainerLowest: Color(4279503881),
      surfaceContainerLow: Color(4280490518),
      surfaceContainer: Color(4280753690),
      surfaceContainerHigh: Color(4281477156),
      surfaceContainerHighest: Color(4282200623),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294949792),
      surfaceTint: Color(4294948248),
      onPrimary: Color(4281207552),
      primaryContainer: Color(4291460445),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4293640882),
      onSecondary: Color(4280684808),
      secondaryContainer: Color(4289563003),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4292397970),
      onTertiary: Color(4279965184),
      tertiaryContainer: Color(4288450909),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279898382),
      onBackground: Color(4294041561),
      surface: Color(4279898382),
      onSurface: Color(4294965752),
      surfaceVariant: Color(4283646782),
      onSurfaceVariant: Color(4292658878),
      outline: Color(4289961879),
      outlineVariant: Color(4287790968),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294041561),
      inverseOnSurface: Color(4281477156),
      inversePrimary: Color(4285740829),
      primaryFixed: Color(4294958030),
      onPrimaryFixed: Color(4280616960),
      primaryFixedDim: Color(4294948248),
      onPrimaryFixedVariant: Color(4284229133),
      secondaryFixed: Color(4294958030),
      onSecondaryFixed: Color(4280290308),
      secondaryFixedDim: Color(4293377710),
      onSecondaryFixedVariant: Color(4283052069),
      tertiaryFixed: Color(4293977000),
      onTertiaryFixed: Color(4279570688),
      tertiaryFixedDim: Color(4292069262),
      onTertiaryFixedVariant: Color(4282267147),
      surfaceDim: Color(4279898382),
      surfaceBright: Color(4282529587),
      surfaceContainerLowest: Color(4279503881),
      surfaceContainerLow: Color(4280490518),
      surfaceContainer: Color(4280753690),
      surfaceContainerHigh: Color(4281477156),
      surfaceContainerHighest: Color(4282200623),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294965752),
      surfaceTint: Color(4294948248),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4294949792),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294965752),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4293640882),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294966004),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4292397970),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279898382),
      onBackground: Color(4294041561),
      surface: Color(4279898382),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4283646782),
      onSurfaceVariant: Color(4294965752),
      outline: Color(4292658878),
      outlineVariant: Color(4292658878),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294041561),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4283177475),
      primaryFixed: Color(4294959317),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4294949792),
      onPrimaryFixedVariant: Color(4281207552),
      secondaryFixed: Color(4294959317),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4293640882),
      onSecondaryFixedVariant: Color(4280684808),
      tertiaryFixed: Color(4294305708),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4292397970),
      onTertiaryFixedVariant: Color(4279965184),
      surfaceDim: Color(4279898382),
      surfaceBright: Color(4282529587),
      surfaceContainerLowest: Color(4279503881),
      surfaceContainerLow: Color(4280490518),
      surfaceContainer: Color(4280753690),
      surfaceContainerHigh: Color(4281477156),
      surfaceContainerHighest: Color(4282200623),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     fontFamily: GoogleFonts.poppins().fontFamily,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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
