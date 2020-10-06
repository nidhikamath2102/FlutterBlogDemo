import 'package:flutter/material.dart';
import 'authentication/Authentication.dart';

class Home extends StatefulWidget{

  Home({this.auth, this.onLoggedOut});

  final ImplementAuth auth;
  final VoidCallback onLoggedOut;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {

    void _logout() async{
      try{
        await widget.auth.logout();
        widget.onLoggedOut();
      }catch(e){
        print("error = " + e.toString());
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Home",
        ),
      ),
      body: new Container(
        
      ),
      
      bottomNavigationBar: new BottomAppBar(
        color: Colors.red,
        elevation: 5,
        child: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.add_a_photo),
                  iconSize: 36,
                  color: Colors.white,
                onPressed: () {  },
              ),
              new IconButton(
                  icon: new Icon(Icons.logout),
                  iconSize: 36,
                  color: Colors.white,
                onPressed: _logout,
              )
            ],
          ),
        ),
      ),
    );
  }
  
}