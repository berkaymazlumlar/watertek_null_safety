import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/blocs/sale/sale_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/spare_part_list/bloc/spare_part_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_spare_part.dart';
import 'package:teknoloji_kimya_servis/models/spare_part.dart';
import 'package:teknoloji_kimya_servis/providers/choose_spare_part_provider.dart';
import 'package:teknoloji_kimya_servis/repositories/sale/sale_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/spare_part_list_repository/spare_part_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

SparePartListRepository _sparePartListRepository =
    locator<SparePartListRepository>();

class ChooseSparePart extends StatefulWidget {
  ChooseSparePart({Key key}) : super(key: key);

  @override
  _ChooseSparePartState createState() => _ChooseSparePartState();
}

class _ChooseSparePartState extends State<ChooseSparePart> {
  SparePartListBloc _sparePartListBloc;

  @override
  void initState() {
    super.initState();
    _sparePartListBloc = BlocProvider.of<SparePartListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final ChooseSparePartProvider _chooseSparePartProvider =
        Provider.of<ChooseSparePartProvider>(context);
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Yedek Parça Seç'),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: BlocBuilder(
        cubit: _sparePartListBloc,
        builder: (context, state) {
          if (state is SparePartListInitialState) {
            _sparePartListBloc.add(GetSparePartListEvent());
          }
          if (state is SparePartListLoadedState) {
            if (state.sparePartList.body.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ürün yok"),
                    SizedBox(height: 8),
                    RaisedButton(
                      onPressed: () {
                        _sparePartListBloc.add(ClearSparePartListEvent());
                      },
                      child: Text("Yeniden dene"),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                _sparePartListBloc.add(ClearSparePartListEvent());
                return Future.delayed(
                  Duration(milliseconds: 300),
                );
              },
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: state.sparePartList.body.length,
                itemBuilder: (context, index) {
                  final _sparePart = state.sparePartList.body[index];
                  return Card(
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Ürün ismi: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${_sparePart.productName}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Ürün modeli: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${_sparePart.productModel}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Yedek Parça: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${_sparePart.name}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Stok: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${_sparePart.count}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Birim fiyat: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${_sparePart.price}₺"),
                            ],
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: _chooseSparePartProvider.choosedSpareParts
                            .contains(_sparePart),
                        onChanged: (value) {
                          _chooseSparePartProvider
                              .addOrRemoveSparePart(_sparePart);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
          if (state is SparePartListErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Veri bulunamadı"),
                  SizedBox(height: 8),
                  RaisedButton(
                    onPressed: () {
                      _sparePartListBloc.add(ClearSparePartListEvent());
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
