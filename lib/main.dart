import 'package:flutter/material.dart';
import 'screens/step_one_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF00A8CC);
    const error = Color(0xFFD32F2F);
    final r = BorderRadius.circular(8);
    OutlineInputBorder bord(Color c, [double w = 1]) =>
        OutlineInputBorder(borderRadius: r, borderSide: BorderSide(color: c, width: w));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primary, error: error),
        appBarTheme: const AppBarTheme(
            backgroundColor: primary, foregroundColor: Colors.white, centerTitle: true),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF2F7F9),
          enabledBorder: bord(Colors.grey),
          focusedBorder: bord(primary, 2),
          errorBorder: bord(error),
          focusedErrorBorder: bord(error, 2),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48), shape: const StadiumBorder()),
        ),
      ),
      home: const StepOneScreen(),
    );
  }
}