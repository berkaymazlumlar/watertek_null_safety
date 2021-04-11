import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/product_list/product_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/pages/show/choose_material_page.dart';
import 'package:teknoloji_kimya_servis/providers/material_provider.dart';
import 'package:teknoloji_kimya_servis/views/general/my_raised_button.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key key}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  List<TextEditingController> _controllers = [];
  TextEditingController _itemNameController;
  TextEditingController _modelController;
  DateTime _setupDate;
  DateTime _warrantyDate;
  String _barcode = "";
  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController();
    _modelController = TextEditingController();
    _barcode = DateTime.now().millisecondsSinceEpoch.toString();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChooseMaterialProvider>(context, listen: false).clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    ChooseMaterialProvider _chooseMaterialProvider =
        Provider.of<ChooseMaterialProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: ElasticInRight(child: Text("Ürün ekle")),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     controller: _itemNameController,
                //     maxLines: null,
                //     textInputAction: TextInputAction.next,
                //     textCapitalization: TextCapitalization.words,
                //     decoration: InputDecoration(
                //       hintText: "Ürün adı",
                //       labelText: "Ürün adı",
                //       prefixIcon: Icon(Icons.donut_large),
                //       border: OutlineInputBorder(),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyTextField(
                    controller: _itemNameController,
                    maxLines: null,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    hintText: "Ürün adı",
                    labelText: "Ürün adı",
                    prefixIcon: Icon(Icons.donut_large),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyTextField(
                    controller: _modelController,
                    maxLines: null,
                    textCapitalization: TextCapitalization.words,
                    hintText: "Model",
                    labelText: "Model",
                    prefixIcon: Icon(Icons.mode_outlined),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     controller: _modelController,
                //     maxLines: null,
                //     textCapitalization: TextCapitalization.words,
                //     decoration: InputDecoration(
                //       hintText: "Model",
                //       labelText: "Model",
                //       prefixIcon: Icon(Icons.mode_outlined),
                //       border: OutlineInputBorder(),
                //     ),
                //   ),
                // ),
                //
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChooseMaterial(),
                                ),
                              );
                            },
                            contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            leading: Icon(Icons.home_repair_service_outlined),
                            title: Transform.translate(
                              offset: Offset(-21, 0),
                              child: Text(
                                _chooseMaterialProvider
                                            .choosedMaterials.length >
                                        0
                                    ? "Sarf malzeme eklemeye devam etmek için dokunun"
                                    : "Kullanılan sarf malzemeleri ekleyin",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                          _chooseMaterialProvider.choosedMaterials.length > 0
                              ? Column(
                                  children: [
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _chooseMaterialProvider
                                            .choosedMaterials.length,
                                        itemBuilder: (context, index) {
                                          // if (index == 0) {
                                          //   _controllers.clear();
                                          // }
                                          _controllers
                                              .add(TextEditingController());
                                          return Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: ListTile(
                                                tileColor: Colors.grey.shade300,
                                                title: Text(
                                                  "${_chooseMaterialProvider.choosedMaterials[index].materialName} ${_chooseMaterialProvider.choosedMaterials[index].materialModel}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    color: Colors.white,
                                                    width: 30,
                                                    child: Center(
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        inputFormatters: <
                                                            TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'[0-9]')),
                                                        ],
                                                        controller:
                                                            _controllers[index],
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyRaisedButton(
                    buttonText: "Ekle",
                    onPressed: () async {
                      if (_itemNameController.text.length <= 0) {
                        MyFlushbarHelper(context: context).showInfoFlushbar(
                          title: "Ürün adı",
                          message:
                              "Ürün ekleyebilmeniz için ürün adını girmelisiniz",
                        );
                        return;
                      }
                      if (_modelController.text.length <= 0) {
                        MyFlushbarHelper(context: context).showInfoFlushbar(
                          title: "Model",
                          message:
                              "Ürün ekleyebilmeniz için model girmelisiniz",
                        );
                        return;
                      }

                      try {
                        EralpHelper.startProgress();
                        final _response = await PostApi.addProduct(
                          name: _itemNameController.text,
                          model: _modelController.text,
                          materialId: _chooseMaterialProvider
                              .choosedMaterials[index].id
                              .toString(),
                        );
                        if (_response is bool) {
                          BlocProvider.of<ProductListBloc>(context)
                              .add(ClearProductListEvent());
                          Navigator.pop(context);
                          MyFlushbarHelper(context: context)
                              .showSuccessFlushbar(
                            title: "Başarılı",
                            message: "Ürün başarıyla eklendi",
                          );
                        } else {
                          MyFlushbarHelper(context: context).showErrorFlushbar(
                            title: "Hata",
                            message:
                                "Ürün eklenirken bir hata ile karşılaşıldı: $_response",
                          );
                        }
                      } catch (e) {
                        MyFlushbarHelper(context: context).showErrorFlushbar(
                          title: "Hata",
                          message: "Ürün eklenirken bir hata ile karşılaşıldı",
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
