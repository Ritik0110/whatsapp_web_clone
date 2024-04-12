import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/chatMessagesArea/chat_area.dart';
import 'package:whatsapp_web_clone/defaultColors/default_colors.dart';

import '../models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  late UserModel currentUserData;
  readCurrentUserData(){
    // This function will read the current user data from the Firebase FireStore
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Read the user data from the FireStore
      print("${currentUser}");
      print("${currentUser.displayName} ${currentUser.email} ${currentUser.photoURL} ${currentUser.uid}");
     currentUserData = UserModel(
        uuid: currentUser.uid,
        email: currentUser.email ?? "",
        password: "",
        name: currentUser.displayName ?? "",
        profilePicture: currentUser.photoURL ?? "",
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCurrentUserData();
  }
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
                        color: DefaultColors.lightBarBackgroundColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
              top: size.height * 0.07,
              bottom: size.height * 0.1,
              left: size.width * 0.1,
              right: size.width * 0.1,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: ChatArea(currentUserData: currentUserData),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
