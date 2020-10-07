import 'package:flutter/material.dart';

class UploadPhoto extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _UploadPhotoState();
  }

}

class _UploadPhotoState extends State<UploadPhoto>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Image"),
        centerTitle: true,
      ),

      body: new Center(
        child: sampleImage == null? Text("Select an image!") : enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: getImage,
          tooltip: "Add a new Image",
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload(){

  }

  void getImage(){

  }

  void sampleImage(){

  }

}