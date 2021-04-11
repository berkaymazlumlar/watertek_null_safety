import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';

class RequestImages extends StatefulWidget {
  final String path;

  const RequestImages({Key key, this.path}) : super(key: key);
  @override
  _RequestImagesState createState() => _RequestImagesState();
}

class _RequestImagesState extends State<RequestImages>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 70,
      child: Image.file(
        File(widget.path),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class RequestImagesNetwork extends StatefulWidget {
  final String path;

  const RequestImagesNetwork({Key key, this.path}) : super(key: key);
  @override
  _RequestImagesNetworkState createState() => _RequestImagesNetworkState();
}

class _RequestImagesNetworkState extends State<RequestImagesNetwork>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 70,
      child: CachedNetworkImage(
        imageUrl: widget.path,
        fit: BoxFit.cover,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
