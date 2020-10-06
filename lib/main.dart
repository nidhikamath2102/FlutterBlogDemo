import 'package:flutter/material.dart';
import 'authentication/CheckAuthentication.dart';
import 'authentication/Authentication.dart';

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
      home: CheckAuth(implementAuth: Auth(),),
    );
  }
}