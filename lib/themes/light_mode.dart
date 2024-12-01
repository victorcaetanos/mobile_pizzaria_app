import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    onSurface: Colors.black,
    inverseSurface: Colors.grey.shade800,
    onInverseSurface: Colors.white,

    primary: Colors.grey.shade500,
    onPrimary: Colors.white,
    inversePrimary: Colors.grey.shade900,
    primaryFixed:  Colors.grey.shade700,
    onPrimaryFixedVariant: Colors.grey.shade600,

    secondary: Colors.grey.shade200,
    onSecondary: Colors.black,
    
    tertiary: const Color(0xFF901919),
    onTertiary: Colors.white,
    
    error: Colors.red.shade700,
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
);

