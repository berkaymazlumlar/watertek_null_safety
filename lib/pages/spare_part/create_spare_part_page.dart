import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/spare_part_list/bloc/spare_part_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_product.dart';
import 'package:teknoloji_kimya_servis/pages/show/choose_product_page.dart';
import 'package:teknoloji_kimya_servis/repositories/product_list/product_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class CreateSparePartPage extends StatefulWidget {
  @override
  _CreateSparePartPageState createState() => _CreateSparePartPageState();
}

class _CreateSparePartPageState extends State<CreateSparePartPage> {
  ApiProductData _product;
  final TextEditingController _sparePartNameController =
      TextEditingController();
  final TextEditingController _sparePartPriceController =
      TextEditingController();
  final TextEditingController _sparePartStockController =
      TextEditingController();
  final ProductListRepository _productListRepository =
      locator<ProductListRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yedek Parça Oluştur'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              try {
                FocusScope.of(context).unfocus();
                if (_product == null) {
                  MyFlushbarHelper(context: context).showInfoFlushbar(
                    title: "Lütfen girişleri kontrol edin",
                    message: "Ürün boş olamaz",
                  );
                  return;
                }
                if (_sparePartNameController.text.length < 1) {
                  MyFlushbarHelper(context: context).showInfoFlushbar(
                    title: "Lütfen girişleri kontrol edin",
                    message: "Ürün boş olamaz",
                  );
                  return;
                }
                if (_sparePartStockController.text.length < 1) {
                  MyFlushbarHelper(context: context).showInfoFlushbar(
                    title: "Lütfen girişleri kontrol edin",
                    message: "Ürün stok bilgisi boş olamaz",
                  );
                  return;
                }
                if (_sparePartPriceController.text.length < 1) {
                  MyFlushbarHelper(context: context).showInfoFlushbar(
                    title: "Lütfen girişleri kontrol edin",
                    message: "Ürün fiyatı olamaz",
                  );
                  return;
                }
                EralpHelper.startProgress();
                final _response = await PostApi.addSparePart(
                  productId: _product.id,
                  name: _sparePartNameController.text,
                  count: _sparePartStockController.text,
                  price: _sparePartPriceController.text,
                );
                if (_response is bool) {
                  Navigator.pop(context);
                  BlocProvider.of<SparePartListBloc>(context)
                      .add(ClearSparePartListEvent());
                  MyFlushbarHelper(context: context).showSuccessFlushbar(
                    title: "Başarılı",
                    message: "Yedek parça ekleme işlemi başarılı",
                  );
                } else {
                  MyFlushbarHelper(context: context).showErrorFlushbar(
                    title: "Başarısız",
                    message:
                        "Yedek parça ekleme işlemi gerçekleştirilemedi: $_response",
                  );
                }
              } catch (e) {
                MyFlushbarHelper(context: context).showErrorFlushbar(
                  title: "Başarısız",
                  message: "Yedek parça ekleme işlemi gerçekleştirilemedi: $e",
                );
              } finally {
                EralpHelper.stopProgress();
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: ListTile(
                leading: _product == null
                    ? Icon(Icons.folder_outlined)
                    : Icon(Icons.folder, color: Colors.blue[300]),
                title: _product == null
                    ? Text(
                        "Lütfen ürün seçin",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Text("${_product.name} - ${_product.model}"),
                onTap: () async {
                  final product = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseProductPage(),
                    ),
                  );
                  if (product != null) {
                    _product = product;
                    setState(() {});
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: MyTextField(
              controller: _sparePartNameController,
              prefixIcon: Icon(Icons.home_repair_service),
              hintText: "Yedek parça adı giriniz",
              labelText: "Yedek parça adı",
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          //   child: TextField(
          //     controller: _sparePartNameController,
          //     decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.home_repair_service),
          //       hintText: "Yedek parça adı giriniz",
          //       labelText: "Yedek parça adı",
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: MyTextField(
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: _sparePartPriceController,
              prefixIcon: Icon(Icons.attach_money),
              hintText: "Yedek parça fiyatı giriniz",
              labelText: "Yedek parça fiyatı",
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          //   child: TextField(
          //     controller: _sparePartPriceController,
          //     decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.attach_money),
          //       hintText: "Yedek parça fiyatı giriniz",
          //       labelText: "Yedek parça fiyatı",
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: MyTextField(
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: _sparePartStockController,
              prefixIcon: Icon(Icons.storage),
              hintText: "Yedek parça stok bilgisi giriniz",
              labelText: "Yedek parça stok bilgisi",
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          //   child: TextField(
          //     controller: _sparePartStockController,
          //     decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.storage),
          //       hintText: "Yedek parça stok bilgisi giriniz",
          //       labelText: "Yedek parça stok bilgisi",
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
