import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class ShowExplorationPdfPage extends StatefulWidget {
  final int explorationId;

  const ShowExplorationPdfPage({Key key, @required this.explorationId})
      : super(key: key);

  @override
  _ShowExplorationPdfPageState createState() => _ShowExplorationPdfPageState();
}

class _ShowExplorationPdfPageState extends State<ShowExplorationPdfPage> {
  Future<QuerySnapshot> _pdfUrl;

  @override
  void initState() {
    super.initState();
    _pdfUrl = FirebaseFirestore.instance
        .collection("exploration_pdf")
        .where("exploration_id", isEqualTo: widget.explorationId.toString())
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keşif Raporu Pdf'),
      ),
      body: FutureBuilder(
        future: _pdfUrl,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final String _pdfUrl =
                  snapshot.data.docs.first.data()["pdf_path"];
              return PDF.network(
                _pdfUrl,
                placeHolder: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Center(
              child: Text("Çizim bulunamadı"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
