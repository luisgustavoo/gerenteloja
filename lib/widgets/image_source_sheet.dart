import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  void ImageSelected(File image) async {
    if (image != null) {
      File imageCropper = await ImageCropper.cropImage(
          sourcePath: image.path, ratioX: 1.0, ratioY: 1.0);
      if (imageCropper != null) onImageSelected(imageCropper);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child: Text("Câmera"),
                onPressed: () async {
                  File image =
                      await ImagePicker.pickImage(source: ImageSource.camera);
                  ImageSelected(image);
                },
              ),
              FlatButton(
                child: Text("Galeria"),
                onPressed: () async {
                  File image =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                  ImageSelected(image);
                },
              ),
            ],
          ),
    );
  }
}