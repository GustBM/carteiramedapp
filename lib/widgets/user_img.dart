import 'package:carteiramedapp/widgets/ImageFromGallery.dart';
import 'package:flutter/material.dart';

enum ImageSourceType { gallery, camera }

class user_img extends StatelessWidget {
  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGallery(type)));
  }

  // # fazer tela com botões bonitos
  //   onPressed: () {
  //                 _handleURLButtonPress(context, ImageSourceType.gallery);
  //               },
  //   onPressed: () {
  //                 _handleURLButtonPress(context, ImageSourceType.camera);
  //               }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
