// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

import 'package:my_app/pages/loginpage.dart';

void main() {
  runApp(CalculatorIntroApp());
}

class CalculatorIntroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Color.fromARGB(255, 95, 109, 148),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              'Welcome to Calculator App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'start your calculations',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 117, 62, 62),
              ),
            ),
            SizedBox(height: 50),
            _button(context), // Invoke the _button method without const keyword
          ],
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: const Text(
        'Get Started',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 231, 83, 3),
      ),
    );
  }
    
  }




