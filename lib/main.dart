import 'package:campus_connect_app/providers/user_provider.dart';
import 'package:campus_connect_app/responsive/mobile_screen_layout.dart';
import 'package:campus_connect_app/responsive/responsive_layout_screen.dart';
import 'package:campus_connect_app/responsive/web_screen_layout.dart';
import 'package:campus_connect_app/screens/login_screen.dart';
import 'package:campus_connect_app/screens/signup_screen.dart';
import 'package:campus_connect_app/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //A concrete binding for applications based on the Widgets framework.This is the glue that binds the framework to the Flutter engine.

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAJdxUZg4aLT3APqozPKvjdBvr5WQAbUEY',
        appId: '1:614294494809:web:45bc50fad4439284a89b48',
        messagingSenderId: '614294494809',
        projectId: 'campus-connect-app-71fc4',
        storageBucket: 'campus-connect-app-71fc4.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Campus Connect',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Oops! Some internal error occured'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }

              return const LoginScreen();
            },
          )
          //const SignupScreen(),
          ),
    );
  }
}
