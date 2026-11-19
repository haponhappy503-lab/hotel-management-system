
import 'package:flutter/material.dart';

import 'features/general/home/general_home_page.dart';


void main() {
  runApp(const RoyalHotelApp());
}

class RoyalHotelApp extends StatelessWidget {
  const RoyalHotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Royal Hotel',

      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F3EF),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF142B45),
        ),

        useMaterial3: true,
      ),

      home: const GeneralHomePage()
    );
  }
}


