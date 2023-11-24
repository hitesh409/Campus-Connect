import 'package:campus_connect_app/resources/auth_methods.dart';
import 'package:campus_connect_app/responsive/mobile_screen_layout.dart';
import 'package:campus_connect_app/responsive/responsive_layout_screen.dart';
import 'package:campus_connect_app/responsive/web_screen_layout.dart';
import 'package:campus_connect_app/screens/signup_screen.dart';
import 'package:campus_connect_app/utils/colors.dart';
import 'package:campus_connect_app/utils/utils.dart';
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
  bool _isLoading = false;

  @override
  void dispose() {
    // implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
  }

  void navigatorToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
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
              hintText: 'Enter your college email',
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
              onTap: loginUser,
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
                  onTap: navigatorToSignup,
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
