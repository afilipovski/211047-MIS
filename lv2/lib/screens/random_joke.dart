import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(JokeApp());

class JokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JokeScreen(),
    );
  }
}

class JokeScreen extends StatefulWidget {
  @override
  _JokeScreenState createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  String setup = '';
  String punchline = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJoke();
  }

  Future<void> fetchJoke() async {
    const String apiUrl = 'https://official-joke-api.appspot.com/random_joke';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          setup = data['setup'];
          punchline = data['punchline'];
          isLoading = false;
        });
      } else {
        setState(() {
          setup = 'Failed to fetch joke';
          punchline = 'Please try again later.';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        setup = 'An error occurred';
        punchline = 'Check your internet connection.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Joke'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      setup,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      punchline,
                      style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: fetchJoke,
                      child: Text('Get Another Joke'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
