import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/material_list/bloc/material_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/product_list/product_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/pages/show/choose_material_page.dart';
import 'package:teknoloji_kimya_servis/providers/material_provider.dart';
import 'package:teknoloji_kimya_servis/views/general/my_raised_button.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class CreateMaterialPage extends StatefulWidget {
  const CreateMaterialPage({Key key}) : super(key: key);

  @override
  _CreateMaterialPageState createState() => _CreateMaterialPageState();
}

class _CreateMaterialPageState extends State<CreateMaterialPage> {
  TextEditingController _itemNameController;
  TextEditingController _modelController;
  TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController();
    _modelController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: ElasticInRight(child: Text("Sarf malzeme ekle")),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyTextField(
                    controller: _itemNameController,
                    maxLines: null,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    hintText: "Sarf malzeme adı giriniz",
                    labelText: "Sarf malzeme adı",
                    prefixIcon: Icon(Icons.donut_large),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyTextField(
                    controller: _modelController,
                    maxLines: null,
                    textCapitalization: TextCapitalization.words,
                    hintText: "Model giriniz",
                    labelText: "Model",
                    prefixIcon: Icon(Icons.mode_outlined),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyTextField(
                    controller: _priceController,
                    maxLines: null,
                    textCapitalization: TextCapitalization.words,
                    hintText: "Birim fiyat giriniz",
                    labelText: "Birim fiyat",
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyRaisedButton(
                    buttonText: "Ekle",
                    onPressed: () async {
                      if (_itemNameController.text.length <= 0) {
                        MyFlushbarHelper(context: context).showInfoFlushbar(
                          title: "Sarf malzeme adı",
                          message:
                              "Sarf malzeme ekleyebilmeniz için sarf malzeme adını girmelisiniz",
                        );
                        return;
                      }
                      if (_modelController.text.length <= 0) {
                        MyFlushbarHelper(context: context).showInfoFlushbar(
                          title: "Model",
                          message:
                              "Sarf malzeme ekleyebilmeniz için model girmelisiniz",
                        );
                        return;
                      }

                      try {
                        EralpHelper.startProgress();
                        final _response = await PostApi.addMaterial(
                          materialName: _itemNameController.text,
                          materialModel: _modelController.text,
                          materialPrice: int.parse(_priceController.text),
                        );
                        if (_response is bool) {
                          BlocProvider.of<MaterialListBloc>(context)
                              .add(ClearMaterialListEvent());
                          Navigator.pop(context);
                          MyFlushbarHelper(context: context)
                              .showSuccessFlushbar(
                            title: "Başarılı",
                            message: "Sarf malzeme başarıyla eklendi",
                          );
                        } else {
                          MyFlushbarHelper(context: context).showErrorFlushbar(
                            title: "Hata",
                            message:
                                "Sarf malzeme eklenirken bir hata ile karşılaşıldı: $_response",
                          );
                        }
                      } catch (e) {
                        MyFlushbarHelper(context: context).showErrorFlushbar(
                          title: "Hata",
                          message:
                              "Sarf malzeme eklenirken bir hata ile karşılaşıldı",
                        );
                      } finally {
                        EralpHelper.stopProgress();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
