// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, use_build_context_synchronously, deprecated_member_use, non_constant_identifier_names

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wrs/google_signin.dart';
import 'package:wrs/home.dart';
import 'package:wrs/my_button.dart';
import 'package:wrs/my_textfield.dart';
import 'package:wrs/page_animation.dart';
import 'package:wrs/square_tile.dart';
import 'package:wrs/utilities.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int selectedIndex = 0;
  bool isLoadingProgress = false;

  File? image;

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;

  // Firebase Realtime Database reference
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('users');

  Future getImageGallery() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (PickedFile != null) {
        image = File(PickedFile.path);
      } else {
        Utilies.flushtoastmessage('No image Picked', context);
      }
    });
  }

  Future getImageCamera() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    setState(() {
      if (PickedFile != null) {
        image = File(PickedFile.path);
      } else {
        Utilies.flushtoastmessage('No image Picked', context);
      }
    });
  }

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                getImageCamera();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                getImageGallery();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // sign up method
  @override
  Widget build(BuildContext context) {

    List<String> role = ['User', 'Trainer'];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _showImagePickerBottomSheet();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: SizedBox(
                      height: 150,
                      child: image != null
                          ? Image.file(image!.absolute)
                          : const Icon(
                              Icons.add_a_photo_rounded,
                              size: 100,
                            ),
                    ),
                  ),
                ), //add image here.....................

                const SizedBox(height: 5),
                Text(
                  'Join us and start your journey!',
                  style: GoogleFonts.k2d(fontSize: 18),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                MyButton(
                  onTap: () async {
                    try {
                      // Check if an image is selected
                      if (image == null) {
                        Utilies.flushtoastmessage(
                            'Please select an image', context);
                        return;
                      }

                      setState(() {
                        isLoadingProgress = true;
                      });

                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      String userID = FirebaseAuth.instance.currentUser!.uid;

                      firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref('/profilepicture/$userID');
                      firebase_storage.UploadTask uploadTask =
                          ref.putFile(image!.absolute);

                      // Get the selected role based on the index
                      String selectedRole = role[selectedIndex];

                      await uploadTask.whenComplete(() async {
                        var newUrl = await ref.getDownloadURL();

                        _databaseReference.push().set({
                          'id': '123',
                          'profileLink': newUrl.toString(),
                          'email': emailController.text,
                          'role': selectedRole,
                        });
                      });

                      // If sign-up is successful, navigate to the HomeScreen
                      Navigator.of(context).push(createPageRoute(const Home()));
                    } catch (e) {
                      Utilies.flushtoastmessage(e.toString(), context);
                      // Handle sign-up errors here
                    } finally {
                      // Set loading state to false, whether the sign-in is successful or not
                      setState(() {
                        isLoadingProgress = false;
                      });
                    }
                  },
                  buttonText: 'Sign Up',
                  isLoading: isLoadingProgress,
                ),

                const SizedBox(height: 20),
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    GestureDetector(
                        onTap: () async {
                          await FirebaseService().signinWithGoogle();
                          Navigator.of(context)
                              .push(createPageRoute(const Home()))
                              .onError((error, stackTrace) =>
                                  Utilies.flushtoastmessage(
                                      error.toString(), context));
                        },
                        child: const SquareTile(
                            imagePath: 'lib/images/google.png')),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context); // Navigate back to the login page
                      },
                      child: const Text(
                        'Login now',
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
    );
  }
}
