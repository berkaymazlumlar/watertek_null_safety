import 'package:flutter/material.dart';

class CameraOrGalleryHelper {
  static Future showBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context, 0);
                return 0;
              },
              leading: Icon(Icons.camera_alt),
              title: Text("Kamera"),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.pop(context, 1);
                return 1;
              },
              leading: Icon(Icons.photo_album),
              title: Text("Galeri"),
            ),
          ],
        );
      },
    );
  }
}
