import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  File? image;
  PickedFile? pickedFile;

  final picker = ImagePicker();
  String imageData = '';

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

    if (pickedFile != null) {
      image = File(croppedImage!.path);
    } else {
      print('No image selected.');
    }
    imageData = base64Encode(image!.readAsBytesSync());

    notifyListeners();
  }

}
