import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/sale/sale_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_company.dart';
import 'package:teknoloji_kimya_servis/models/api_product.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/models/company.dart';
import 'package:teknoloji_kimya_servis/models/product.dart';
import 'package:teknoloji_kimya_servis/pages/company/choose_company_page.dart';
import 'package:teknoloji_kimya_servis/pages/show/choose_product_page.dart';
import 'package:teknoloji_kimya_servis/pages/users_page/choose_user_page.dart';
import 'package:teknoloji_kimya_servis/providers/company_provider.dart';
import 'package:teknoloji_kimya_servis/views/general/my_raised_button.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({Key key}) : super(key: key);

  @override
  _AddSalePageState createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  TextEditingController _itemNameController;
  TextEditingController _modelController;
  TextEditingController _departmanController;
  TextEditingController _lokasyonController;
  DateTime _setupDate;
  DateTime _warrantyDate;
  String _barcode = "";
  ApiProductData _product;
  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController();
    _modelController = TextEditingController();
    _departmanController = TextEditingController();
    _lokasyonController = TextEditingController();
    _barcode = DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sat???? Ekle"),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: _product == null
                      ? Icon(Icons.folder_outlined)
                      : Icon(Icons.folder, color: Colors.blue[300]),
                  title: _product == null
                      ? Text(
                          "L??tfen ??r??n se??in",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: _setupDate == null
                      ? Icon(Icons.calendar_today_outlined)
                      : Icon(Icons.calendar_today, color: Colors.blue[300]),
                  title: _setupDate == null
                      ? Text(
                          "L??tfen kurulum tarihi se??in",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Text(
                          "Kurulum tarihi: ${DateHelper.getStringDateTR(_setupDate)}"),
                  onTap: () async {
                    await _chooseSetupDate(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: _warrantyDate == null
                      ? Icon(Icons.calendar_today_outlined)
                      : Icon(Icons.calendar_today, color: Colors.blue[300]),
                  title: _warrantyDate == null
                      ? Text(
                          "L??tfen garanti tarihi se??in",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Text(
                          "Garanti tarihi: ${DateHelper.getStringDateTR(_warrantyDate)}"),
                  onTap: () async {
                    await _chooseWarrantyDate(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<CompanyProvider>(
                  builder: (context, value, child) {
                    return ListTile(
                      leading: value.selectedCompany == null
                          ? Icon(Icons.shopping_bag_outlined)
                          : Icon(Icons.shopping_bag, color: Colors.blue[300]),
                      title: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              value.selectedCompany != null ? "M????teri: " : ""),
                          Text(
                            value.selectedCompany != null
                                ? "${value.selectedCompany.fullName}"
                                : "L??ften m????teri se??in",
                            style: value.selectedCompany == null
                                ? TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  )
                                : TextStyle(),
                          ),
                        ],
                      ),
                      onTap: () {
                        NavigatorHelper(context).goTo(
                          ChooseUserPage(
                            onCompanyChoosed: (ApiUsersData company) {
                              Provider.of<CompanyProvider>(context,
                                      listen: false)
                                  .selectedCompany = company;
                              Navigator.pop(context);
                            },
                          ),
                        );
                        // Navigator.pushNamed(context, "/chooseCompanyPage");
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.qr_code),
                  title: Text("QR: $_barcode"),
                  // subtitle: Text("$_barcode"),
                  trailing: Icon(Icons.refresh),
                  onTap: () {
                    _barcode = DateTime.now().millisecondsSinceEpoch.toString();
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  hintText: "Departman giriniz",
                  labelText: "Departman",
                  controller: _departmanController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  hintText: "Lokasyon giriniz",
                  labelText: "Lokasyon",
                  controller: _lokasyonController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyRaisedButton(
                    onPressed: () async {
                      if (_product == null) {
                        MyFlushbarHelper(context: context).showInfoFlushbar(
                          title: "??r??n",
                          message:
                              "Sat???? bilgisi ekleyebilmeniz i??in ??r??n se??melisiniz",
                        );
                        return;
                      }
                      if (_setupDate == null) {
                        MyFlushbarHelper(context: context).showInfoFlushbar(
                          title: "Kurulum tarihi",
                          message:
                              "Sat???? bilgisi ekleyebilmeniz i??in kurulum tarihini se??melisiniz",
                        );
                        return;
                      }
                      if (_warrantyDate == null) {
                        MyFlushbarHelper(context: context).showInfoFlushbar(
                          title: "Garanti tarihi",
                          message:
                              "Sat???? bilgisi ekleyebilmeniz i??in garanti tarihi se??melisiniz",
                        );
                        return;
                      }
                      if (Provider.of<CompanyProvider>(context, listen: false)
                              .selectedCompany ==
                          null) {
                        MyFlushbarHelper(context: context).showInfoFlushbar(
                          title: "M????teri",
                          message:
                              "Sat???? bilgisi ekleyebilmeniz i??in m????teri se??melisiniz",
                        );
                        return;
                      }
                      try {
                        final _response = await PostApi.addSale(
                          companyId:
                              "${Provider.of<CompanyProvider>(context, listen: false).selectedCompany.id}",
                          productId: "${_product.id}",
                          setupDate: _setupDate,
                          warrantyDate: _warrantyDate,
                          barcode: "$_barcode",
                          departman: _departmanController.text,
                          lokasyon: _lokasyonController.text,
                        );

                        if (_response is bool) {
                          BlocProvider.of<SaleBloc>(context)
                              .add(ClearSaleEvent());
                          Navigator.pop(context);
                          MyFlushbarHelper(context: context)
                              .showSuccessFlushbar(
                            title: "Ba??ar??l??",
                            message: "Sat???? bilgisi ba??ar??yla eklendi",
                          );
                        } else {
                          MyFlushbarHelper(context: context).showErrorFlushbar(
                            title: "Hata",
                            message:
                                "Sat???? bilgisi eklenirken bir hata ile kar????la????ld??: $_response",
                          );
                        }
                      } catch (e) {
                        print(e);
                        MyFlushbarHelper(context: context).showErrorFlushbar(
                          title: "Hata",
                          message:
                              "Sat???? bilgisi eklenirken bir hata ile kar????la????ld??",
                        );
                      }
                    },
                    buttonText: "Ekle",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _chooseSetupDate(BuildContext context) async {
    FocusScope.of(context).unfocus();

    DateTime _pickedDate = await showDatePicker(
      locale: Locale("tr", "TR"),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(days: 7),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 10000),
      ),
    );
    if (_pickedDate != null) {
      _setupDate = _pickedDate;
      setState(() {});
    }
  }

  Future _chooseWarrantyDate(BuildContext context) async {
    FocusScope.of(context).unfocus();

    DateTime _pickedDate = await showDatePicker(
      locale: Locale("tr", "TR"),
      context: context,
      initialDate: DateTime.now().add(
        Duration(days: 365),
      ),
      firstDate: DateTime.now().subtract(
        Duration(days: 7),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 10000),
      ),
    );
    if (_pickedDate != null) {
      _warrantyDate = _pickedDate;
      setState(() {});
    }
  }
}
