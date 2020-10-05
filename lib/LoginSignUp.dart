import 'package:flutter/material.dart';

class LoginSignUp extends StatefulWidget{
  State<StatefulWidget> createState(){
    return _LoginSignUpState();
  }
}

class _LoginSignUpState extends State<LoginSignUp>{

  void login(){

  }

  void register(){

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
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: inputWidgets(),
          ),
        ),
      ),
    );
  }

  List<Widget> inputWidgets(){
    return[
      SizedBox(height: 10.0,),
      logo(),
      SizedBox(height: 30.0,),

      new TextFormField(
        decoration: new InputDecoration(
          labelText: "Email"
        ),
      ),
      SizedBox(height: 10.0,),
      new TextFormField(
        decoration: new InputDecoration(
            labelText: "Password"
        ),
      ),
      SizedBox(height: 40.0,),
      new RaisedButton(
        child: new Text(
          "Login",
          style: new TextStyle(
            fontSize: 20.0
          ),
        ),
        textColor: Colors.white,
        color: Colors.red,
        onPressed: login,
      ),
      SizedBox(height: 10.0,),
      new FlatButton(
        child: new Text(
          "Sign Up",
          style: new TextStyle(
              fontSize: 14.0
          ),
        ),
        textColor: Colors.red,
        color: Colors.white,
        onPressed: register,
      ),
    ];
  }

  Widget logo(){
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