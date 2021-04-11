import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:teknoloji_kimya_servis/models/api_spare_part.dart';

class ShowWorkOrderImage extends StatefulWidget {
  ShowWorkOrderImage({this.imagePath});

  final String imagePath;

  @override
  _ShowWorkOrderImageState createState() => _ShowWorkOrderImageState();
}

class _ShowWorkOrderImageState extends State<ShowWorkOrderImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Center(
        child: PhotoView(
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.contained * 2,
          imageProvider: NetworkImage(
            widget.imagePath,
          ),
        ),
      ),
    );
  }
}

class ShowRequestImage extends StatefulWidget {
  ShowRequestImage({this.imagePath});

  final String imagePath;

  @override
  _ShowRequestImageState createState() => _ShowRequestImageState();
}

class _ShowRequestImageState extends State<ShowRequestImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Center(
        child: PhotoView(
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.contained * 2,
          imageProvider: FileImage(
            File(widget.imagePath),
          ),
        ),
      ),
    );
  }
}
