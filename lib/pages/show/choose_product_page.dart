import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:teknoloji_kimya_servis/blocs/product_list/product_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/repositories/product_list/product_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

ProductListRepository _productListRepository = locator<ProductListRepository>();

class ChooseProductPage extends StatefulWidget {
  ChooseProductPage({Key key}) : super(key: key);

  @override
  _ChooseProductPageState createState() => _ChooseProductPageState();
}

class _ChooseProductPageState extends State<ChooseProductPage> {
  ProductListBloc _productListBloc;

  @override
  void initState() {
    super.initState();
    _productListBloc = BlocProvider.of<ProductListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürünler'),
      ),
      body: BlocBuilder(
        cubit: _productListBloc,
        builder: (context, state) {
          if (state is ProductListInitialState) {
            _productListBloc.add(GetProductListEvent());
          }
          if (state is ProductListLoadedState) {
            if (state.productList.count == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ürün yok"),
                    SizedBox(height: 8),
                    RaisedButton(
                      onPressed: () {
                        _productListBloc.add(ClearProductListEvent());
                      },
                      child: Text("Yeniden dene"),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                _productListBloc.add(ClearProductListEvent());
                return Future.delayed(
                  Duration(milliseconds: 300),
                );
              },
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: state.productList.count,
                itemBuilder: (context, index) {
                  final _product = state.productList.body[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context, _product);
                      },
                      title: Text(
                          "Ürün ismi: ${_product.name}\n\nÜrün modeli: ${_product.model}\n\nOluşturulma tarihi: ${DateHelper.getStringDateHourTR(_product.createdAt)}"),
                      // subtitle: Text(
                      // "Ürün modeli: ${_product.model} \nFirma: ${_product.companyName}"),
                    ),
                  );
                },
              ),
            );
          }
          if (state is ProductListErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Veri bulunamadı"),
                  SizedBox(height: 8),
                  Text(
                    "${state.error}",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  RaisedButton(
                    onPressed: () {
                      _productListBloc.add(ClearProductListEvent());
                    },
                    child: Text("Yeniden dene"),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addItemPage");
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // void _printScreen(final _printKey) {
  //   Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
  //     final doc = pw.Document();

  //     final image = await WidgetWraper.(
  //       doc.document,
  //       key: _printKey,
  //       pixelRatio: 2.0,
  //     );

  //     doc.addPage(
  //       pw.Page(
  //         pageFormat: PdfPageFormat.a3,
  //         build: (pw.Context context) {
  //           return pw.Center(
  //             child: pw.Expanded(
  //               child: pw.Image(image),
  //             ),
  //           );
  //         },
  //       ),
  //     );
  //     // final file = File('example.pdf');
  //     // file.writeAsBytesSync(doc.save());
  //     return doc.save();
  //   });
  // }
}
