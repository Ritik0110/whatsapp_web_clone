import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/defaultColors/default_colors.dart';
import 'package:whatsapp_web_clone/models/user_model.dart';

class ChatArea extends StatelessWidget {
  final UserModel currentUserData;
  const ChatArea({super.key, required this.currentUserData});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        child: Container(
          decoration: const BoxDecoration(
            color: DefaultColors.lightBarBackgroundColor,
            border: Border(
              right: BorderSide(
                color: DefaultColors.backgroundColor,
                width: 1,
              ),
            )
          ),
        )
      ,);
  }
}
