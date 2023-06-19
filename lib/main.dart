import 'package:daily_carbon_footprint/Screen/Tab.dart';
import 'package:daily_carbon_footprint/Screen/calculateScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var customlightColor = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 7, 140, 145),
);

void main() {
  runApp(const MyApp());
}

final customTheme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: customlightColor,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: customlightColor.primary.withOpacity(0.6),
  ),
  cardTheme: const CardTheme().copyWith(
    color: customlightColor.secondaryContainer,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: customlightColor.primaryContainer.withOpacity(0.6),
      foregroundColor: customlightColor.onBackground,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 69, 109),
          fontSize: 18,
        ),
      ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: customTheme, home: TabScreen()
        //home: const MealsScreen(title: 'some category', meals: []),
        );
  }
}
