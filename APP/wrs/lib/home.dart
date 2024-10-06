import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'tts.dart';
import 'recommend.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = '';
  var data = '';
  bool dataFetching = false;
  String query = '';

  @override
  void initState() {
    super.initState();
    TtsHelper.speak('Welcome to the AI Powered, Workout Recommendation Module');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                    child: Text(
                  'Welcome To AI-Powered WRM',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                )),
                const SizedBox(height: 50),
                Center(
                  child: Lottie.asset('animations/api.json',
                      width: 250, height: 200),
                ),
                const SizedBox(height: 150),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Your Query',
                  ),
                  onChanged: (value) {
                    query = value;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
  if (query.isEmpty) {
    Fluttertoast.showToast(
      msg: 'Empty Query',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
    return;
  }

  url = 'https://wrs.pythonanywhere.com/api?query=$query';
  setState(() {
    dataFetching = true; // Show circular progress indicator when pressed
  });

  http.Response response = await http.get(Uri.parse(url));
  setState(() {
    dataFetching = false; // Hide circular progress indicator after fetching
  });
  String data = response.body;
  final responseData = json.decode(data);
  if (response.statusCode == 200) {
    if (responseData is Map && responseData.containsKey('error')) {
      // Show toast for "Irrelevant Query"
      Fluttertoast.showToast(
        msg: 'Irrelevant / Invalid Query',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );
    } else if (responseData is List) {
      // Navigate to the second screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExerciseScreen(data: data),
        ),
      );
    } else {
      // Handle unexpected response format
      Fluttertoast.showToast(
        msg: 'Unexpected response format from the server',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  } else {
    // Handle HTTP errors here
    Fluttertoast.showToast(
      msg: 'Error: Might Be Connection Issue',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
},
                  child: const Text('Fetch'),
                ),
                const SizedBox(height: 10),
                if (dataFetching) const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
