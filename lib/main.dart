import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MiniMarketApp());
}

class MiniMarketApp extends StatelessWidget {
  const MiniMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Market',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2864e8)),
      ),
      home: const HomeScreen(),
    );
  }
}
