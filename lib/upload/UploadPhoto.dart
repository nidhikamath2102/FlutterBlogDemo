import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_blog/Home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UploadPhoto extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadPhotoState();
  }
}

class _UploadPhotoState extends State<UploadPhoto> {
  File image;
  final formkey = new GlobalKey<FormState>();
  String _description;
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Image"),
        centerTitle: true,
      ),
      body: new Center(
        child: image == null ? Text("Select an image!") : enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add a new Image",
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
        child: new Form(
      key: formkey,
      child: new Column(
        children: <Widget>[
          Image.file(
            image,
            height: 300.0,
            width: 500.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            decoration: new InputDecoration(labelText: "Description"),
            validator: (value) {
              return value.isEmpty ? "Description is mandatory" : null;
            },
            onSaved: (value) {
              return _description = value;
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
              elevation: 8.0,
              child: Text("Add Post"),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: uploadToFirestore)
        ],
      ),
    ));
  }

  Future getImage() async {
    var tempImage = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      image = File(tempImage.path);
    });
  }

  bool formValidated() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadToFirestore() async {
    if (formValidated()) {
      final StorageReference storageReference = FirebaseStorage.instance.ref().child("Blogs");
      var time = new DateTime.now();
      final StorageUploadTask uploadTask = storageReference.child(time.toString() + ".jpg").putFile(image);
      var imageUploadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      if (uploadTask.isComplete && uploadTask.isSuccessful) {
        imageUrl = imageUploadUrl.toString();
        print("image url " + imageUrl);
      }
      gotoHome();
      uploadToFirebase(imageUrl);
    }
  }

  void uploadToFirebase(url) {
    var currentTime = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE hh:mm:ss aaa');

    String date = formatDate.format(currentTime);
    String time = formatTime.format(currentTime);

    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    var post = {
      "imageUrl": url,
      "description": _description,
      "date": date,
      "time": time,
    };

    databaseReference.child("BlogList").push().set(post);
  }

  void gotoHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new Home();
    }));
  }
}
