import 'package:campus_connect_app/utils/colors.dart';
import 'package:campus_connect_app/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool validateCollegeConstraints(String email) {
    //email follows the pattern 20CP010@bvmengineering.ac.in
    if (!RegExp(
            r'^\d{2}(?:CE|CP|EL|EE|EC|ME|PE|IT)\d{2}@bvmengineering\.ac\.in')
        .hasMatch(email.toLowerCase())) {
      return false;
    }
    return true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity, //full width of device
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                const CircleAvatar(
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
                    onPressed: () {},
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
              onTap: () {
                if (!validateCollegeConstraints(_emailController.text)) {
                  print("Invalid college constraints");
                  return;
                }
              },
              child: Container(
                width: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    color: blueColor),
                child: const Text(
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
      )),
    );
  }
}
