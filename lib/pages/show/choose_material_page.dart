import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/blocs/material_list/bloc/material_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/sale/sale_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/spare_part_list/bloc/spare_part_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_spare_part.dart';
import 'package:teknoloji_kimya_servis/models/spare_part.dart';
import 'package:teknoloji_kimya_servis/providers/choose_spare_part_provider.dart';
import 'package:teknoloji_kimya_servis/providers/material_provider.dart';
import 'package:teknoloji_kimya_servis/repositories/material_repository/material_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/sale/sale_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/spare_part_list_repository/spare_part_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

MaterialRepository _materialListRepository = locator<MaterialRepository>();

class ChooseMaterial extends StatefulWidget {
  ChooseMaterial({Key key}) : super(key: key);

  @override
  _ChooseMaterialState createState() => _ChooseMaterialState();
}

class _ChooseMaterialState extends State<ChooseMaterial> {
  MaterialListBloc _materialListBloc;

  @override
  void initState() {
    super.initState();
    _materialListBloc = BlocProvider.of<MaterialListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final ChooseMaterialProvider _chooseMaterialProvider =
        Provider.of<ChooseMaterialProvider>(context);
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sarf Malzeme Seç'),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: BlocBuilder(
        cubit: _materialListBloc,
        builder: (context, state) {
          if (state is MaterialListInitialState) {
            _materialListBloc.add(GetMaterialListEvent());
          }
          if (state is MaterialListLoadedState) {
            if (state.materialList.body.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ürün yok"),
                    SizedBox(height: 8),
                    RaisedButton(
                      onPressed: () {
                        _materialListBloc.add(ClearMaterialListEvent());
                      },
                      child: Text("Yeniden dene"),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                _materialListBloc.add(ClearMaterialListEvent());
                return Future.delayed(
                  Duration(milliseconds: 300),
                );
              },
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: state.materialList.body.length,
                itemBuilder: (context, index) {
                  final _material = state.materialList.body[index];
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
                              Text("${_material.materialName}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Ürün modeli: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${_material.materialModel}"),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Birim fiyat: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${_material.materialPrice}"),
                            ],
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: _chooseMaterialProvider.choosedMaterials
                            .contains(_material),
                        onChanged: (value) {
                          _chooseMaterialProvider
                              .addOrRemoveMaterial(_material);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
          if (state is MaterialListErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Veri bulunamadı"),
                  SizedBox(height: 8),
                  RaisedButton(
                    onPressed: () {
                      _materialListBloc.add(ClearMaterialListEvent());
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
}
