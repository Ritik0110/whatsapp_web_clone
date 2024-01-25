import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/defaultColors/default_colors.dart';


import 'web_pages_routes.dart';


String initialRoute = '/';
void main() {
  runApp(const MyApp());
}
final ThemeData defaultThemeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: DefaultColors.primaryColor)
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      theme: defaultThemeData,
      initialRoute:initialRoute,
      onGenerateRoute: WebPagesRoutes.createRoute,
    );
  }
}