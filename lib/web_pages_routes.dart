import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/pages/home_page.dart';
import 'package:whatsapp_web_clone/pages/login_signup.dart';
import 'package:whatsapp_web_clone/pages/messages_page.dart';

class WebPagesRoutes {
  static Route<dynamic> createRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const LoginSignUpPage());

      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginSignUpPage());

      case '/homePage':
        return MaterialPageRoute(builder: (context) => const HomePage());

      case '/messagePage':
        return MaterialPageRoute(builder: (context) => const MessagePage());

      default:
        return errorPageRoute();}
  }

  static Route<dynamic> errorPageRoute() {
    return MaterialPageRoute(builder: (context){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Page Not Found'),
        ),
        body: const Center(
          child: Text('Error: Web Page Not Found'),
        ),
      );
    });
  }
}
