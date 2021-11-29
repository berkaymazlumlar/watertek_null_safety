import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowDrawsPage extends StatefulWidget {
  final int explorationId;
  ShowDrawsPage({Key key, @required this.explorationId}) : super(key: key);

  @override
  _ShowDrawsPageState createState() => _ShowDrawsPageState();
}

class _ShowDrawsPageState extends State<ShowDrawsPage> {
  Future<QuerySnapshot> _imageUrls;

  @override
  void initState() {
    super.initState();
    _imageUrls = FirebaseFirestore.instance
        .collection("exploration_draw")
        .where("exploration_id", isEqualTo: widget.explorationId.toString())
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keşif Raporu Çizimleri'),
      ),
      body: FutureBuilder(
        future: _imageUrls,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final String _imageUrl =
                      snapshot.data.docs[index].get("draw_path");
                  return Image.network(
                    "$_imageUrl",
                  );
                },
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
