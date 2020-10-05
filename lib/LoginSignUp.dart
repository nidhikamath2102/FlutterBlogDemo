import 'dart:math';

import 'package:flutter/material.dart';

class LoginSignUp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LoginSignUpState();
  }
}

enum FormType { login, register }

class _LoginSignUpState extends State<LoginSignUp> {
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  bool validate(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void login() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  void register() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("User Login/Register"),
      ),
      body: new Container(
        margin: EdgeInsets.all(20.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: inputWidgets() + buttons(),
          ),
        ),
      ),
    );
  }

  List<Widget> inputWidgets() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 30.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "Email"),
        validator: (val) {
          return val.isEmpty ? 'Email is mandatory' : null;
        },
        onSaved: (email) {
          return _email = email;
        },
      ),
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "Password"),
        validator: (value) {
          return value.isEmpty ? 'Password is needed' : null;
        },
        onSaved: (password) {
          return _password = password;
        },
        obscureText: true,
      ),
      SizedBox(
        height: 40.0,
      ),
    ];
  }

  List<Widget> buttons() {
    if(_formType == FormType.login){
      return[
        new RaisedButton(
          child: new Text(
            "Login",
            style: new TextStyle(
                fontSize: 20.0
            ),
          ),
          textColor: Colors.white,
          color: Colors.red,
          onPressed: validate,
        ),
        SizedBox(height: 10.0,),
        new FlatButton(
          child: new Text(
            "Do not have an account? Sign Up",
            style: new TextStyle(
                fontSize: 14.0
            ),
          ),
          textColor: Colors.red,
          color: Colors.white,
          onPressed: register,
        ),
      ];
    }else{
      return[
        new RaisedButton(
          child: new Text(
            "Create An Account",
            style: new TextStyle(
                fontSize: 20.0
            ),
          ),
          textColor: Colors.white,
          color: Colors.red,
          onPressed: validate,
        ),
        SizedBox(height: 10.0,),
        new FlatButton(
          child: new Text(
            "Have an account? Log In",
            style: new TextStyle(
                fontSize: 14.0
            ),
          ),
          textColor: Colors.red,
          color: Colors.white,
          onPressed: login,
        ),
      ];
    }
  }

  Widget logo() {
    return new Hero(
      tag: 'Hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 80.0,
        backgroundImage: AssetImage('images/logo1.png'),
      ),
    );
  }
}
