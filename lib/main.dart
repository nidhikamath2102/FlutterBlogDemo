import 'package:flutter/material.dart';
import 'LoginSignUp.dart';

void main() {
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Blog App",
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginSignUp(),
    );
  }
}
