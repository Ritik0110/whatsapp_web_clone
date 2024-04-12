import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/defaultColors/default_colors.dart';
import 'package:whatsapp_web_clone/extension/extension.dart';
import 'package:whatsapp_web_clone/models/user_model.dart';

class ChatArea extends StatelessWidget {
  final UserModel currentUserData;
  const ChatArea({super.key, required this.currentUserData});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: const BoxDecoration(
            color: DefaultColors.lightBarBackgroundColor,
            border: Border(
              right: BorderSide(
                color: DefaultColors.backgroundColor,
                width: 1,
              ),
            )),
        child: Column(
          children: [
            Container(
              color: DefaultColors.lightBarBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    foregroundImage:
                        currentUserData.profilePicture.trim().isNotEmpty
                            ? NetworkImage(currentUserData.profilePicture)
                            : const AssetImage("assets/images/profile.png")
                                as ImageProvider,
                  ),
                  10.sizedBoxWidth,
                  Text(
                    currentUserData.name.trim().isNotEmpty
                        ? currentUserData.name
                        : "User Name",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  10.sizedBoxWidth,
                  IconButton(
                      onPressed: () async {
                        // This function will sign out the user from the app
                        await FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        });
                      },
                      icon: const Icon(Icons.logout)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
