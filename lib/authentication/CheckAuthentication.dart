import 'package:flutter/material.dart';
import 'package:flutter_blog/Home.dart';
import 'package:flutter_blog/LoginSignUp.dart';
import 'Authentication.dart';

class CheckAuth extends StatefulWidget {
  final ImplementAuth implementAuth;

  CheckAuth({this.implementAuth,});

  State<StatefulWidget> createState() {
    return _CheckAuthState();
  }
}

enum AuthState { loggedIn, loggedOut }

class _CheckAuthState extends State<CheckAuth> {
  AuthState authState = AuthState.loggedOut;

  void _loggedIn(){
    setState(() {
      authState = AuthState.loggedIn;
    });
  }

  void _loggedOut(){
    setState(() {
      authState = AuthState.loggedOut;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.implementAuth.currentUser().then((firebaseUID) {
      setState(() {
        authState =
            firebaseUID == null ? AuthState.loggedOut : AuthState.loggedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authState){

      case AuthState.loggedIn:
        return new Home(
            auth: widget.implementAuth,
            onLoggedOut: _loggedOut
        );

      case AuthState.loggedOut:
        return new LoginSignUp(
          auth: widget.implementAuth,
          onLoggedIn: _loggedIn
        );
    }
  }
}
