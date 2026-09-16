//därför jag kan använda Flutter widgets
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

//Programmet börjar här
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UpNext',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color(0xFF7C5CFC)
        ),
        useMaterial3: true,
      ),
      //hompage blir första sidan som visas
      home: const HomePage(),
    );
  }
}

