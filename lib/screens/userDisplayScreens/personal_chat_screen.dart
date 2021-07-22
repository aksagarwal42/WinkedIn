import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class PersonalChatScreen extends StatefulWidget {
  const PersonalChatScreen({Key? key}) : super(key: key);

  @override
  _PersonalChatScreenState createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  // ignore: unused_field
  File? _image;
  PickedFile? pickedFile ;
  final picker = ImagePicker();
  getImage(ImageSource source) async {
    pickedFile = await picker.getImage(source: source);
    final croppedImage = await ImageCropper.cropImage(
      sourcePath: pickedFile!.path,
      compressQuality: 100,
      maxHeight: 900,
      maxWidth: 900,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
    );
    setState(
      () {
        if (pickedFile != null) {
          _image = File(croppedImage!.path);
        } else {
          print('No image selected.');
        }
      },
    );
  }

  _sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              showModalBottomSheet(
            context: context,
            builder: (context) => Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
            },
          ),
          Expanded(
            child: TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Ankit Upadhyay\n',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              TextSpan(
                text: 'Online',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Text(
                              'Data Data Data Data Data 5 Data Data Data Data Data 10 Data Data Data Data'),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://scontent.fccu3-1.fna.fbcdn.net/v/t1.6435-9/82447142_781104979058981_3072033993357524992_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=174925&_nc_ohc=vy0lI09_NQEAX9ptq9F&_nc_ht=scontent.fccu3-1.fna&oh=9c3632419cac1df910ef62dbc1540196&oe=60DDFF75'),
                              radius: 15,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '12:30 pm',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.6),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Text(
                            'Data Data Data Data Data 5 Data Data Data Data Data 10 Data Data Data Data',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '12:30 pm',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white54,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://scontent.fccu3-1.fna.fbcdn.net/v/t1.6435-9/82447142_781104979058981_3072033993357524992_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=174925&_nc_ohc=vy0lI09_NQEAX9ptq9F&_nc_ht=scontent.fccu3-1.fna&oh=9c3632419cac1df910ef62dbc1540196&oe=60DDFF75'),
                              radius: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
