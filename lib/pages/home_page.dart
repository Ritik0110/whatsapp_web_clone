import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/defaultColors/default_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DefaultColors.lightBarBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
              child: Container(
            color: DefaultColors.primaryColor,
            height: size.height * 0.1,
            width: size.width,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                  color: DefaultColors.primaryColor,
                ),
                const Text(
                  'WhatsApp',
                  style: TextStyle(
                    color: DefaultColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
