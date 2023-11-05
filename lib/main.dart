import 'package:coffee/pages/onboarding_srn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(   //used for Cart persistence
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoard(),
    );
  }
}
