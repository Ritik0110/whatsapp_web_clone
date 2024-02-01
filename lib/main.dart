import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/defaultColors/default_colors.dart';

import 'web_pages_routes.dart';

String initialRoute = '/';
void main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAnnXwuHyZ37Q1Ts5HqnokboO1Uv1oqqcs",
          authDomain: "whatsapp-web-clone-3ed5c.firebaseapp.com",
          projectId: "whatsapp-web-clone-3ed5c",
          storageBucket: "whatsapp-web-clone-3ed5c.appspot.com",
          messagingSenderId: "805157363636",
          appId: "1:805157363636:web:b54c706ded635f6df5dce1",
          measurementId: "G-19Y63M4RYJ"));
  runApp(const MyApp());
}

final ThemeData defaultThemeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: DefaultColors.primaryColor));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      theme: defaultThemeData,
      initialRoute: initialRoute,
      onGenerateRoute: WebPagesRoutes.createRoute,
    );
  }
}
