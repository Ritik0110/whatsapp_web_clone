import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_web_clone/defaultColors/default_colors.dart';
import 'package:whatsapp_web_clone/extension/extension.dart';
import 'package:whatsapp_web_clone/models/user_model.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  bool isSingUp = false;
  Uint8List? selectedImage;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isPasswordVisible = true;

  selectImage() async {
    FilePickerResult? filePick =
        await FilePicker.platform.pickFiles(type: FileType.image);

    setState(() {
      selectedImage = filePick!.files.first.bytes;
    });
  }

  addStorageData(UserModel modelData) async {
    Reference ref =
        FirebaseStorage.instance.ref("profilePictures/${modelData.uuid}.jpg");
    UploadTask task = ref.putData(selectedImage!);
    await task.whenComplete(() async {
      String downloadUrl = await ref.getDownloadURL();
      print(downloadUrl);
      modelData.profilePicture = downloadUrl;
    });
    print(modelData.toJson());
    final storeData = FirebaseFirestore.instance.collection("/users");
    storeData.doc(modelData.uuid).set(modelData.toJson()).then((value) {
      setState(() {
        selectedImage = null;
        nameController.text = "";
        emailController.text = "";
        passwordController.clear();
        isLoading = false;
        Navigator.of(context).pushReplacementNamed("/home");
      });
    });
  }

  loginOrSignUp() async {
    if (formKey.currentState!.validate()) {
      if (isSingUp) {
        //register module
        if (selectedImage == null) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please Select Image")));
        } else {
          UserModel model;
          setState(() {
            isLoading = true;
          });
          try {
            final userCreated =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.toLowerCase().trim(),
              password: passwordController.text.trim(),
            );
            model = UserModel(
              uuid: userCreated.user!.uid,
              email: emailController.text.toLowerCase().trim(),
              name: nameController.text.trim(),
              password: passwordController.text.trim(),
            );

            await addStorageData(model);
          } catch (e) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
          setState(() {
            isLoading = false;
          });
        }
      } else {
        //login module
        try {
          setState(() {
            isLoading = true;
          });
          final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text.toLowerCase().trim(),
              password: passwordController.text.trim()).then((value) {
            setState(() {
              isLoading = false;
            });
            Navigator.of(context).pushReplacementNamed("/home");
          });
          print(user.user!.uid);
        } catch (e) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
                          Form(
                            key: formKey,
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
                                        onPressed: () {
                                          selectImage();
                                        },
                                        child: const Text("Select Image"),
                                      ),
                                      20.sizedBoxHeight,

                                      //Name TextField
                                      commonTextField(
                                        controller: nameController,
                                        hintText: "Enter Name",
                                        labelText: "Name",
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter Name";
                                          }
                                        },
                                        suffixIcon: Icons.person,
                                      ),
                                    ],
                                  ),
                                ),
                                //Email TextField
                                commonTextField(
                                  controller: emailController,
                                  hintText: "Enter Email Address",
                                  labelText: "Email Address",
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Email Address";
                                    } else if (!value
                                        .toString()
                                        .trim()
                                        .isValidEmail()) {
                                      return "Please Enter Valid Email Address";
                                    }
                                  },
                                  suffixIcon: Icons.email,
                                ),
                                //Password TextField
                                commonTextField(
                                  controller: passwordController,
                                  hintText: "Enter Password",
                                  labelText: "Password",
                                  obscureText: isPasswordVisible,
                                  suffixIconOnTap: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Password";
                                    } else if (!value
                                        .toString()
                                        .trim()
                                        .isValidPassword()) {
                                      return "Please Enter valid Password";
                                    }
                                  },
                                  suffixIcon: isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                )
                              ],
                            ),
                          ),
                          20.sizedBoxHeight,
                          //login OR Register Button
                          SizedBox(
                              height: 50,
                              width: size.width,
                              child: ElevatedButton(
                                  onPressed: () {
                                    loginOrSignUp();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: DefaultColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  child: isLoading
                                      ? const CircularProgressIndicator(
                                          color: DefaultColors
                                              .lightBarBackgroundColor,
                                        )
                                      : isSingUp
                                          ? const Text("Register")
                                          : const Text("Login"))),
                          15.sizedBoxHeight,
                          // toggle button for login and register
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Login"),
                              Switch(
                                  value: isSingUp,
                                  onChanged: (value) {
                                    //formKey.currentState?.reset();
                                    setState(() {
                                      selectedImage = null;
                                      isSingUp = value;
                                      isLoading = false;
                                      formKey.currentState?.reset();
                                    });
                                  }),
                              const Text("Register")
                            ],
                          ),
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

  Widget commonTextField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    bool obscureText = false,
    required IconData suffixIcon,
    void Function()? suffixIconOnTap,
    required validate,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        suffixIcon: GestureDetector(
          onTap: suffixIconOnTap,
          child: Icon(suffixIcon),
        ),
      ),
      obscureText: obscureText,
      validator: validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
