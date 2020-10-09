import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/upload/UploadPhoto.dart';
import 'authentication/Authentication.dart';
import 'model/Blog.dart';

class Home extends StatefulWidget {
  Home({this.auth, this.onLoggedOut});

  final ImplementAuth auth;
  final VoidCallback onLoggedOut;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<Blog> blogs = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.reference().child("BlogList");
    databaseReference.once().then((DataSnapshot snapShot) {
      blogs.clear();
      var keys = snapShot.value.keys;
      var data = snapShot.value;
      for (var i in keys) {
        blogs.add(new Blog(data[i]["date"], data[i]["description"], data[i]["imageUrl"], data[i]["time"]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void _logout() async {
      try {
        await widget.auth.logout();
        widget.onLoggedOut();
      } catch (e) {
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
        child: blogs.length == 0 ? new Text("No new blogs available") : new ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (_, i){
              return blog(blogs[i]);
            })
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new UploadPhoto();
                  }));
                },
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

  Widget blog(Blog blog) {
    return new Card(
      elevation: 8.0,
      margin: EdgeInsets.all(15.0),

      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                blog.date,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              new Text(
                blog.time,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 10.0,),
          new Image.network(blog.imageUrl, fit: BoxFit.fitHeight ),
          SizedBox(height: 5.0,),
          new Text(
            blog.description,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ],
      )
    );
  }
}
