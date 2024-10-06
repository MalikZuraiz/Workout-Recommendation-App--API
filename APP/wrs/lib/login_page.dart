// ignore_for_file: unused_local_variable, use_build_context_synchronously, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wrs/google_signin.dart';
import 'package:wrs/home.dart';
import 'package:wrs/my_button.dart';
import 'package:wrs/my_textfield.dart';
import 'package:wrs/page_animation.dart';
import 'package:wrs/reset_password.dart';
import 'package:wrs/signup_page.dart';
import 'package:wrs/square_tile.dart';
import 'package:wrs/utilities.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLoadingProgress = false;

  // sign user in method
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
      
                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
      
                  const SizedBox(height: 15),
      
                  // welcome back, you've been missed!
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: GoogleFonts.k2d(fontSize: 18),
                  ),
      
                  const SizedBox(height: 25),
      
                  // username textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
      
                  const SizedBox(height: 10),
      
                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(createPageRoute(const ResetPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  const SizedBox(height: 25),
      
                  // sign in button
      
                  MyButton(
                    onTap: () async {
                      try {
                        // Set loading state to true
                        setState(() {
                          isLoadingProgress = true;
                        });
      
                        // Attempt to sign in
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: usernameController.text,
                          password: passwordController.text,
                        );
      
                        // If sign-in is successful, navigate to the HomeScreen
                        Navigator.of(context).push(createPageRoute(const Home()));
                      } catch (e) {
                        // Handle sign-in errors here
                        Utilies.flushtoastmessage(
                            e.toString(), context);
                      } finally {
                        // Set loading state to false, whether the sign-in is successful or not
                        setState(() {
                          isLoadingProgress = false;
                        });
                      }
                    },
                    buttonText: 'Sign In',
                    isLoading: isLoadingProgress,
                  ),
      
                  const SizedBox(height: 25),
      
                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  const SizedBox(height: 10),
      
                  // google + apple sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      GestureDetector(
                          onTap: () async{
                            await FirebaseService().signinWithGoogle();
                            Navigator.of(context).push(createPageRoute(const Home())).onError((error, stackTrace) => 
                            Utilies.flushtoastmessage(error.toString(), context));
                          },
                          child: const SquareTile(
                              imagePath: 'lib/images/google.png')),
      
                   
      
                     
                    ],
                  ),
      
                  const SizedBox(height: 20),
      
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(createPageRoute(const SignUpPage()));
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
