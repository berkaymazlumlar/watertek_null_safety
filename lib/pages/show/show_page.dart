import 'package:flutter/material.dart';

class ShowProductsPage extends StatefulWidget {
  ShowProductsPage({Key key}) : super(key: key);

  @override
  _ShowProductsPageState createState() => _ShowProductsPageState();
}

class _ShowProductsPageState extends State<ShowProductsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              title: Text("Ürünleri göster"),
              onTap: () {
                Navigator.pushNamed(context, "/showProductListPage");
              },
            ),
          ),
        ),
      ],
    );
  }
}
