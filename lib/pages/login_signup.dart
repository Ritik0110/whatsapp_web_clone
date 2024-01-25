import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/defaultColors/default_colors.dart';
import 'package:whatsapp_web_clone/extension/extension.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  bool isSingUp = true;
  Uint8List? selectedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          color: DefaultColors.backgroundColor,
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                height: size.height * 0.5,
                width: size.width,
                color: DefaultColors.primaryColor,
              )),
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.1),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.05),
                      child: Column(
                        children: [
                          Visibility(
                              child: Column(
                            children: [
                              Visibility(
                                visible: isSingUp,
                                child: Column(
                                  children: [
                                    ClipOval(
                                      child: selectedImage != null
                                          ? Image.memory(
                                              selectedImage!,
                                              height: size.height * 0.1,
                                              width: size.height * 0.1,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/profile.png',
                                              height: size.height * 0.1,
                                              width: size.height * 0.1,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    20.sizedBoxHeight,
                                    OutlinedButton(
                                      onPressed: () {},
                                      child: const Text("Select Image"),
                                    ),
                                    20.sizedBoxHeight,
                                    commonTextField(
                                      controller: nameController,
                                      hintText: "Enter Name",
                                      labelText: "Name",
                                      validate: (value) {},
                                    ),
                                    commonTextField(
                                      controller: emailController,
                                      hintText: "Enter Email Address",
                                      labelText: "Email Address",
                                      validate: (value) {},
                                    ),
                                    commonTextField(
                                      controller: passwordController,
                                      hintText: "Enter Password",
                                      labelText: "Password",
                                      validate: (value) {},
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget commonTextField(
      {required TextEditingController controller,
      required String hintText,
      required String labelText,
      required validate}) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
      ),
      validator: validate,
      keyboardType: TextInputType.text,
    );
  }
}
