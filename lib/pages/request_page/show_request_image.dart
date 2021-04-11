import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';

class ShowRequestImage extends StatefulWidget {
  final String imageUrl;

  const ShowRequestImage({Key key, this.imageUrl}) : super(key: key);
  @override
  _ShowRequestImageState createState() => _ShowRequestImageState();
}

class _ShowRequestImageState extends State<ShowRequestImage> {
  @override
  void initState() {
    super.initState();
    print(widget.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fotoğraf Detayı"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              try {
                EralpHelper.startProgress();
                var request = await HttpClient().getUrl(
                  Uri.parse(
                    widget.imageUrl,
                  ),
                );
                var response = await request.close();
                Uint8List bytes =
                    await consolidateHttpClientResponseBytes(response);
                EralpHelper.stopProgress();
                await Share.file(
                    '${widget.imageUrl.split("/").last}',
                    '${widget.imageUrl.split("/").last}.jpg',
                    bytes,
                    'image/jpg');
              } catch (e) {} finally {
                EralpHelper.stopProgress();
              }

              // GallerySaver.saveImage(widget.imageUrl).then(
              //   (bool success) {
              //     FlushbarHelper.createSuccess(
              //       title: "Başarılı",
              //       message: "Fotoğraf galeriye kaydedildi",
              //     );
              //   },
              // );
            },
          ),
        ],
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: "${widget.imageUrl}",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
