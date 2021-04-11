import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_sale.dart';
import 'package:teknoloji_kimya_servis/models/sale.dart';

class ShowSaleDetailPage extends StatefulWidget {
  final ApiSaleData sale;

  const ShowSaleDetailPage({Key key, this.sale}) : super(key: key);

  @override
  _ShowSaleDetailPageState createState() => _ShowSaleDetailPageState();
}

class _ShowSaleDetailPageState extends State<ShowSaleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(
          //   icon: Icon(Icons.error),
          //   onPressed: () {},
          // ),
        ],
        title: Text("Ürün Bilgisi"),
      ),
      body: Card(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: _buildExpansionTileElement(
                "Ürün adı",
                widget.sale.productName,
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: _buildExpansionTileElement(
                "Model adı",
                widget.sale.productModel,
              ),
            ),
            Container(
              color: Colors.white,
              child: _buildExpansionTileElement(
                "Firma adı",
                widget.sale.companyName,
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: _buildExpansionTileElement(
                "Kurulum tarihi",
                DateHelper.getStringDateTR(widget.sale.setupDate),
              ),
            ),
            Container(
              color: Colors.white,
              child: _buildExpansionTileElement(
                "Garanti tarihi",
                DateHelper.getStringDateTR(widget.sale.warrantyDate),
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: _buildExpansionTileElement(
                "Oluşturulma tarihi",
                DateHelper.getStringDateTR(widget.sale.createdAt),
              ),
            ),
            Container(
              color: Colors.white,
              child: _buildExpansionTileElement(
                "Departman",
                widget.sale.departman,
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: _buildExpansionTileElement(
                "Lokasyon",
                widget.sale.lokasyon,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: QrImage(
                      data: "${widget.sale.barcode}",
                      version: QrVersions.auto,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildExpansionTileElement(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$key",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("$value"),
        ],
      ),
    );
  }
}
