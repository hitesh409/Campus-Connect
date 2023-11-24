import 'dart:typed_data';

import 'package:campus_connect_app/resources/auth_methods.dart';
import 'package:campus_connect_app/utils/colors.dart';
import 'package:campus_connect_app/utils/utils.dart';
import 'package:campus_connect_app/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _img;
  RegExp regExp = RegExp(r'^([a-zA-Z0-9._%+-]+)@bvmengineering\.ac\.in');
  String userId = "20XX001";
  String userRole = 'Student';
  bool _isLoading = false;

  bool validateCollegeConstraints(String email) {
    //email follows the pattern 20CP010@bvmengineering.ac.in
    if (!regExp.hasMatch(email.toLowerCase())) {
      return false;
    }
    return true;
  }

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    if (!validateCollegeConstraints(_emailController.text)) {
      print("Invalid constraints");
      return;
    }

    // Check if passwords match
    if (_passwordController.text != _confirmpasswordController.text) {
      print("Passwords do not match");
      // You can display an error message or take appropriate action
      return;
    }

    // Continue with the sign-up logic here
    Match? match = regExp.firstMatch(_emailController.text);
    userId = match!.group(1)!;
    userRole =
        RegExp(r'^[a-zA-Z]+$').hasMatch(userId[0]) ? 'Faculty' : 'Student';
    print("User Role: $userRole");
    print(userId);

    print("Sign-up successful!");
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        userId: userId,
        userRole: userRole,
        file: _img!);

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  @override
  void dispose() {
    // implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _img = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity, //full width of device
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets/MyLogo_Top.svg',
                height: 64,
              ),
              const SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  _img != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_img!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundColor: Color.fromARGB(255, 190, 190, 190),
                          child: Icon(
                            Icons.person,
                            size: 64,
                            color: Color.fromARGB(255, 237, 236, 236),
                          ),
                        ),
                  Positioned(
                    bottom: 3,
                    left: 90,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _usernameController,
                textInputType: TextInputType.text,
                hintText: 'Enter Full Name',
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress,
                hintText: 'Enter email',
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                hintText: 'Enter password',
                isPassword: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _confirmpasswordController,
                textInputType: TextInputType.text,
                hintText: 'Confirm password',
                isPassword: true,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: _signUp,
                child: Container(
                  width: 200,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      color: blueColor),
                  child: _isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        )
                      : const Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text("Already have an account? "),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "Login.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
