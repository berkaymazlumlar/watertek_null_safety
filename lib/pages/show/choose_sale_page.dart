import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:teknoloji_kimya_servis/blocs/sale/sale_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/repositories/sale/sale_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

SaleListRepository _saleListRepository = locator<SaleListRepository>();

class ChooseSalePage extends StatefulWidget {
  ChooseSalePage({Key key}) : super(key: key);

  @override
  _ChooseSalePageState createState() => _ChooseSalePageState();
}

class _ChooseSalePageState extends State<ChooseSalePage> {
  SaleBloc _saleListBloc;

  @override
  void initState() {
    super.initState();
    _saleListBloc = BlocProvider.of<SaleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Satış seç'),
      ),
      body: BlocBuilder(
        cubit: _saleListBloc,
        builder: (context, state) {
          if (state is SaleInitialState) {
            _saleListBloc.add(GetSaleEvent());
          }
          if (state is SaleLoadedState) {
            if (state.sale.data.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ürün yok"),
                    SizedBox(height: 8),
                    RaisedButton(
                      onPressed: () {
                        _saleListBloc.add(ClearSaleEvent());
                      },
                      child: Text("Yeniden dene"),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                _saleListBloc.add(ClearSaleEvent());
                return Future.delayed(
                  Duration(milliseconds: 300),
                );
              },
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                padding: EdgeInsets.all(8),
                itemCount: state.sale.data.length,
                itemBuilder: (context, index) {
                  final _sale = state.sale.data[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pop(context, _sale);
                    },
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Ürün ismi: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${_sale.productName}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Ürün modeli: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${_sale.productModel}"),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Müşteri: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${_sale.companyName}"),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          if (state is SaleFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Veri bulunamadı"),
                  SizedBox(height: 8),
                  RaisedButton(
                    onPressed: () {
                      _saleListBloc.add(ClearSaleEvent());
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
    );
  }

  // void _printScreen(final _printKey) {
  //   Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
  //     final doc = pw.Document();

  //     final image = await wrapWidget(
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
