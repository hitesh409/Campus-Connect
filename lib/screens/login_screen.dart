import 'package:campus_connect_app/utils/colors.dart';
import 'package:campus_connect_app/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
              height: 64,
            ),
            TextFieldInput(
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
              hintText: 'Enter your email or ID number',
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              textInputType: TextInputType.text,
              hintText: 'Enter your password',
              isPassword: true,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {},
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
                  "Log in",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: const Text("Don't have an account? "),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text(
                      "Sign Up.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      )),
    );
  }
}
