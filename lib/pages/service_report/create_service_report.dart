import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/api/put_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/service_report/service_report_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/spare_part_list/bloc/spare_part_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/create_service_report_pdf_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_sale.dart';
import 'package:teknoloji_kimya_servis/models/spare_part.dart';
import 'package:teknoloji_kimya_servis/pages/service_report/show_pdf_page.dart';
import 'package:teknoloji_kimya_servis/pages/show/choose_sale_page.dart';
import 'package:teknoloji_kimya_servis/pages/show/choose_spare_part_page.dart';
import 'package:teknoloji_kimya_servis/providers/choose_spare_part_provider.dart';
import 'dart:convert';
import 'package:teknoloji_kimya_servis/api/api_urls.dart';
import 'package:http/http.dart' as http;
import 'package:teknoloji_kimya_servis/providers/sign_provider.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/service_report/service_report_data_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/service_report_repository/service_report_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

ServiceReportDataRepository _serviceReportRepository =
    locator<ServiceReportDataRepository>();

class CreateServiceReport extends StatefulWidget {
  @override
  _CreateServiceReportState createState() => _CreateServiceReportState();
}

class _CreateServiceReportState extends State<CreateServiceReport> {
  AuthRepository _authRepository = locator<AuthRepository>();
  TextEditingController _descriptionController;
  List<TextEditingController> _controllers = [];
  List<SparePart> _sparePartList = [];
  ApiSaleData _sale;
  int raporValue = 0;
  int anaTesisatVeyaIcmeSuyuValue = 0;
  int kurumsalValue = 0;
  int bireyselValue = 0;
  int tezgahAltiKasaValue = 0;
  int tezgahAltiKapaliKasaValue = 0;
  bool filtrelerValue = false;
  bool yumusatmaValue = false;
  bool karbonValue = false;
  bool klorlamaValue = false;
  bool kumValue = false;
  bool endustriyelROValue = false;
  bool ultravioleValue = false;
  bool hizmetCinsiValue = false;
  bool servisHizmetiValue = false;
  bool icmeSuyuSistemleriValue = false;
  bool filtrelerTemizlendiValue = false;
  bool filtrelerDegistirildiValue = false;
  bool filtrelerGeriYikamaYapildiValue = false;
  bool yumusatmaZamanAyariValue = false;
  bool yumusatmaSizdirmazlikValue = false;
  bool yumusatmaCikisSuyuValue = false;
  bool yumusatmaTuzSeviyesiValue = false;
  bool yumusatmaRecineValue = false;
  bool karbonZamanAyariValue = false;
  bool karbonSizdirmazlikValue = false;
  bool karbonTersYikamaValue = false;
  bool karbonKarbonMineraliValue = false;
  bool kumZamanAyariValue = false;
  bool kumSizdirmazlikValue = false;
  bool kumTersYikamaValue = false;
  bool kumMineralValue = false;
  bool klorCekvalflerValue = false;
  bool klorOlcumValue = false;
  bool klorIlaveValue = false;
  bool klorSizdirmazlikValue = false;
  bool endustriyelROGuvenlikValue = false;
  bool endustriyelROMembranValue = false;
  bool endustriyelROKimyasalValue = false;
  bool endustriyelROSizdirmazlikValue = false;
  bool uvLambaKontrolValue = false;
  bool uvSizdirmazlikValue = false;
  bool uvVoltajRegulatoruValue = false;
  bool uvLambaDegistirildiValue = false;
  bool uvQuvartsKilifValue = false;
  bool servisYeriServisteValue = false;
  bool servisYeriYerindeValue = false;
  bool hizmetCinsiGarantiValue = false;
  bool hizmetCinsiIlkValue = false;
  bool hizmetCinsiNormalValue = false;
  bool setUstuFotoselValue = false;
  bool setUstuPompaValue = false;
  bool tezgahAltiFotoselValue = false;
  bool tezgahAltiPompaValue = false;
  bool acikKasaValue = false;
  bool kapaliKasaValue = false;
  bool kapaliKasaAkilliValue = false;
  bool kapaliKasaKlasikValue = false;
  bool aritmaliSebilFotoselValue = false;
  bool anaTesisatYumusatmaValue = false;
  bool anaTesisatYumusatmaZamanAyariValue = false;
  bool anaTesisatYumusatmaSizdirmazlikValue = false;
  bool anaTesisatYumusatmaCikisSuyuValue = false;
  bool anaTesisatYumusatmaTuzSeviyesiValue = false;
  bool anaTesisatYumusatmaRecineValue = false;
  bool anaTesisatKumValue = false;
  bool anaTesisatKumZamanAyariValue = false;
  bool anaTesisatKumSizdirmazlikValue = false;
  bool anaTesisatKumTersYikamaValue = false;
  bool anaTesisatKumMineralValue = false;
  bool anaTesisatKarbonValue = false;
  bool anaTesisatKarbonZamanAyariValue = false;
  bool anaTesisatKarbonSizdirmazlikValue = false;
  bool anaTesisatKarbonTersYikamaValue = false;
  bool anaTesisatKarbonKarbonMineraliValue = false;
  bool anaTesisatFiltrelerValue = false;
  bool anaTesisatFiltrelerTemizlendiValue = false;
  bool anaTesisatFiltrelerDegistirildiValue = false;
  bool anaTesisatFiltrelerGeriYikamaYapildiValue = false;
  String description;
  String pdfUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChooseSparePartProvider>(context, listen: false).clear();
      _descriptionController = TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    ChooseSparePartProvider _chooseSparePartProvider =
        Provider.of<ChooseSparePartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Servis Raporu Oluştur"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              if (_sale == null) {
                MyFlushbarHelper(context: context).showErrorFlushbar(
                  title: "Lütfen girişleri kontrol edin",
                  message: "Satış kısmı boş olamaz",
                );
                return;
              }

              // bool _isReturnFalse = false;
              // print(_controllers.length);
              // _controllers.forEach((element) {
              //   if (element.text.length <= 0) {
              //     MyFlushbarHelper(context: context).showErrorFlushbar(
              //       title: "Hata",
              //       message: "Yedek parça adedi boş olamaz",
              //     );
              //     _isReturnFalse = true;
              //     return;
              //   } else {
              //     if (int.parse(element.text) <= 0) {
              //       MyFlushbarHelper(context: context).showErrorFlushbar(
              //         title: "Hata",
              //         message: "Yedek parça adedi negatif olamaz",
              //       );
              //       _isReturnFalse = true;
              //       return;
              //     }
              //   }
              // });

              // if (_isReturnFalse) {
              //   return;
              // }

              _assignValuesToServiceReportRepository(_chooseSparePartProvider);
              Provider.of<SignProvider>(context, listen: false).customerSign =
                  null;
              Provider.of<SignProvider>(context, listen: false).workerSign =
                  null;
              CreateServiceReportPdfHelper _creatServiceReportPdfHelper =
                  CreateServiceReportPdfHelper();
              final _myPdf =
                  await _creatServiceReportPdfHelper.getPdf(context: context);
              NavigatorHelper(context).goTo(
                ShowPdfPage(pdf: _myPdf),
              );
              return;
              // return await _pushToDatabase(_chooseSparePartProvider, context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              leading: _sale == null
                  ? Icon(Icons.folder_outlined)
                  : Icon(Icons.folder, color: Colors.blue[300]),
              title: _sale == null
                  ? Text(
                      "Satış seçin",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Text(
                      "${_sale.productName} - ${_sale.productModel}\nMüşteri: ${_sale.companyName}"),
              onTap: () async {
                final product = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseSalePage(),
                  ),
                );
                if (product != null) {
                  _sale = product;
                  setState(() {});
                }
              },
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseSparePart(),
                  ),
                );
              },
              contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              leading: Icon(Icons.home_repair_service_outlined),
              title: Text(
                "Kullanılan yedek parçaları ekleyin",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _chooseSparePartProvider.choosedSpareParts.length,
              itemBuilder: (context, index) {
                // if (index == 0) {
                //   _controllers.clear();
                // }
                _controllers.add(TextEditingController());
                return ListTile(
                  tileColor: Colors.grey.shade300,
                  title: Text(
                    "${_chooseSparePartProvider.choosedSpareParts[index].productName} ${_chooseSparePartProvider.choosedSpareParts[index].productModel} - ${_chooseSparePartProvider.choosedSpareParts[index].name}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      width: 30,
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          controller: _controllers[index],
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 0,
                      groupValue: raporValue,
                      onChanged: (value) {
                        if (raporValue != 0) {
                          clearValues();
                          MyFlushbarHelper(context: context).showInfoFlushbar(
                            title: "Rapor tipi değiştirildi",
                            message: "Tüm filtreler sıfırlandı",
                          );
                        }
                        raporValue = value;
                        setState(() {});
                      },
                    ),
                    Text(
                      "Kurumsal",
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: raporValue,
                      onChanged: (value) {
                        if (raporValue != 1) {
                          clearValues();
                          MyFlushbarHelper(context: context).showInfoFlushbar(
                            title: "Rapor tipi değiştirildi",
                            message: "Tüm filtreler sıfırlandı",
                          );
                        }
                        raporValue = value;
                        setState(() {});
                      },
                    ),
                    Text("Bireysel"),
                  ],
                ),
              ],
            ),
            Divider(),
            raporValue == 0
                ? Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Radio(
                      //             value: 0,
                      //             groupValue: kurumsalValue,
                      //             onChanged: (value) {
                      //               kurumsalValue = value;
                      //               setState(() {});
                      //             }),
                      //         Text(
                      //           "Endüstriyel",
                      //         ),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Radio(
                      //             value: 1,
                      //             groupValue: kurumsalValue,
                      //             onChanged: (value) {
                      //               kurumsalValue = value;
                      //               setState(() {});
                      //             }),
                      //         Text("Kobi"),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Radio(
                      //             value: 2,
                      //             groupValue: kurumsalValue,
                      //             onChanged: (value) {
                      //               kurumsalValue = value;
                      //               setState(() {});
                      //             }),
                      //         Text("Toplu Konut"),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Radio(
                      //             value: 3,
                      //             groupValue: kurumsalValue,
                      //             onChanged: (value) {
                      //               kurumsalValue = value;
                      //               setState(() {});
                      //             }),
                      //         Text("İçme Suyu Sistemleri"),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          dropdownColor: Colors.grey.shade200,
                          value: kurumsalValue,
                          onChanged: (int newValue) {
                            kurumsalValue = newValue;
                            setState(() {});
                          },
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<int>(
                              child: Text("Endüstriyel"),
                              value: 0,
                            ),
                            DropdownMenuItem<int>(
                              child: Text("Kobi"),
                              value: 1,
                            ),
                            DropdownMenuItem<int>(
                              child: Text("Toplu Konut"),
                              value: 2,
                            ),
                            DropdownMenuItem<int>(
                              child: Text("İçme Suyu Sistemleri"),
                              value: 3,
                            ),
                          ],
                        ),
                      ),

                      Divider(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Filtreler",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: filtrelerValue,
                                onChanged: (value) {
                                  filtrelerValue = !filtrelerValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          filtrelerValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Temizlendi"),
                                        Checkbox(
                                          value: filtrelerTemizlendiValue,
                                          onChanged: (value) {
                                            filtrelerTemizlendiValue =
                                                !filtrelerTemizlendiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Değiştirildi"),
                                        Checkbox(
                                          value: filtrelerDegistirildiValue,
                                          onChanged: (value) {
                                            filtrelerDegistirildiValue =
                                                !filtrelerDegistirildiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Geri Yıkama Yapıldı"),
                                        Checkbox(
                                          value:
                                              filtrelerGeriYikamaYapildiValue,
                                          onChanged: (value) {
                                            filtrelerGeriYikamaYapildiValue =
                                                !filtrelerGeriYikamaYapildiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Su Yumuşatma",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: yumusatmaValue,
                                onChanged: (value) {
                                  yumusatmaValue = !yumusatmaValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          yumusatmaValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Zaman/Debi Ayarı Yapıldı"),
                                        Checkbox(
                                          value: yumusatmaZamanAyariValue,
                                          onChanged: (value) {
                                            yumusatmaZamanAyariValue =
                                                !yumusatmaZamanAyariValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sızdırmazlık Kontrolü Yapıldı"),
                                        Checkbox(
                                          value: yumusatmaSizdirmazlikValue,
                                          onChanged: (value) {
                                            yumusatmaSizdirmazlikValue =
                                                !yumusatmaSizdirmazlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Çıkış Suyu Sertlik Kontrolü Yapıldı"),
                                        Checkbox(
                                          value: yumusatmaCikisSuyuValue,
                                          onChanged: (value) {
                                            yumusatmaCikisSuyuValue =
                                                !yumusatmaCikisSuyuValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Tuz Seviyesi Kontrol Edildi"),
                                        Checkbox(
                                          value: yumusatmaTuzSeviyesiValue,
                                          onChanged: (value) {
                                            yumusatmaTuzSeviyesiValue =
                                                !yumusatmaTuzSeviyesiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Reçine Minerali Değiştirildi"),
                                        Checkbox(
                                          value: yumusatmaRecineValue,
                                          onChanged: (value) {
                                            yumusatmaRecineValue =
                                                !yumusatmaRecineValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Aktif Karbon",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: karbonValue,
                                onChanged: (value) {
                                  karbonValue = !karbonValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          karbonValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Zaman Ayarı Yapıldı"),
                                        Checkbox(
                                          value: karbonZamanAyariValue,
                                          onChanged: (value) {
                                            karbonZamanAyariValue =
                                                !karbonZamanAyariValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sızdırmazlık Kontrolü Yapıldı"),
                                        Checkbox(
                                          value: karbonSizdirmazlikValue,
                                          onChanged: (value) {
                                            karbonSizdirmazlikValue =
                                                !karbonSizdirmazlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ters Yıkama Yaptırıldı"),
                                        Checkbox(
                                          value: karbonTersYikamaValue,
                                          onChanged: (value) {
                                            karbonTersYikamaValue =
                                                !karbonTersYikamaValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Ak. Karbon Minerali Değiştirildi"),
                                        Checkbox(
                                          value: karbonKarbonMineraliValue,
                                          onChanged: (value) {
                                            karbonKarbonMineraliValue =
                                                !karbonKarbonMineraliValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Kum Filtresi",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: kumValue,
                                onChanged: (value) {
                                  kumValue = !kumValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          kumValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Zaman Ayarı Yapıldı"),
                                        Checkbox(
                                          value: kumZamanAyariValue,
                                          onChanged: (value) {
                                            kumZamanAyariValue =
                                                !kumZamanAyariValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sızdırmazlık Kontrolü Yapıldı"),
                                        Checkbox(
                                          value: kumSizdirmazlikValue,
                                          onChanged: (value) {
                                            kumSizdirmazlikValue =
                                                !kumSizdirmazlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ters Yıkama Yaptırıldı"),
                                        Checkbox(
                                          value: kumTersYikamaValue,
                                          onChanged: (value) {
                                            kumTersYikamaValue =
                                                !kumTersYikamaValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Mineral Değiştirildi"),
                                        Checkbox(
                                          value: kumMineralValue,
                                          onChanged: (value) {
                                            kumMineralValue = !kumMineralValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Klorlama",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: klorlamaValue,
                                onChanged: (value) {
                                  klorlamaValue = !klorlamaValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          klorlamaValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Çekvalfler Temizlendi"),
                                        Checkbox(
                                          value: klorCekvalflerValue,
                                          onChanged: (value) {
                                            klorCekvalflerValue =
                                                !klorCekvalflerValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Klor Ölçümü Yapıldı"),
                                        Checkbox(
                                          value: klorOlcumValue,
                                          onChanged: (value) {
                                            klorOlcumValue = !klorOlcumValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Klor İlave Edildi"),
                                        Checkbox(
                                          value: klorIlaveValue,
                                          onChanged: (value) {
                                            klorIlaveValue = !klorIlaveValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sızdırmazlık Kontrolü Yapıldı"),
                                        Checkbox(
                                          value: klorSizdirmazlikValue,
                                          onChanged: (value) {
                                            klorSizdirmazlikValue =
                                                !klorSizdirmazlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Endüstriyel RO",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: endustriyelROValue,
                                onChanged: (value) {
                                  endustriyelROValue = !endustriyelROValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          endustriyelROValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Ön Güvenlik Filtreler Değiştirildi"),
                                        Checkbox(
                                          value: endustriyelROGuvenlikValue,
                                          onChanged: (value) {
                                            endustriyelROGuvenlikValue =
                                                !endustriyelROGuvenlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Membran Değiştirildi"),
                                        Checkbox(
                                          value: endustriyelROMembranValue,
                                          onChanged: (value) {
                                            endustriyelROMembranValue =
                                                !endustriyelROMembranValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Kimyasal Yıkama Yapıldı"),
                                        Checkbox(
                                          value: endustriyelROKimyasalValue,
                                          onChanged: (value) {
                                            endustriyelROKimyasalValue =
                                                !endustriyelROKimyasalValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sızdırmazlık Kontrolü Yapıldı"),
                                        Checkbox(
                                          value: endustriyelROSizdirmazlikValue,
                                          onChanged: (value) {
                                            endustriyelROSizdirmazlikValue =
                                                !endustriyelROSizdirmazlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ultraviole",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: ultravioleValue,
                                onChanged: (value) {
                                  ultravioleValue = !ultravioleValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          ultravioleValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("UV Lamba Kontrol Edildi"),
                                        Checkbox(
                                          value: uvLambaKontrolValue,
                                          onChanged: (value) {
                                            uvLambaKontrolValue =
                                                !uvLambaKontrolValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sızdırmazlık Kontrolü Yapıldı"),
                                        Checkbox(
                                          value: uvSizdirmazlikValue,
                                          onChanged: (value) {
                                            uvSizdirmazlikValue =
                                                !uvSizdirmazlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Voltaj Regülatörü Var"),
                                        Checkbox(
                                          value: uvVoltajRegulatoruValue,
                                          onChanged: (value) {
                                            uvVoltajRegulatoruValue =
                                                !uvVoltajRegulatoruValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("UV Lamba Değiştirildi"),
                                        Checkbox(
                                          value: uvLambaDegistirildiValue,
                                          onChanged: (value) {
                                            uvLambaDegistirildiValue =
                                                !uvLambaDegistirildiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("UV Quvarts Kılıf Değiştirildi"),
                                        Checkbox(
                                          value: uvQuvartsKilifValue,
                                          onChanged: (value) {
                                            uvQuvartsKilifValue =
                                                !uvQuvartsKilifValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Servis Hizmeti",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: servisHizmetiValue,
                                onChanged: (value) {
                                  servisHizmetiValue = !servisHizmetiValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          servisHizmetiValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Serviste"),
                                        Checkbox(
                                          value: servisYeriServisteValue,
                                          onChanged: (value) {
                                            servisYeriServisteValue =
                                                !servisYeriServisteValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Yerinde"),
                                        Checkbox(
                                          value: servisYeriYerindeValue,
                                          onChanged: (value) {
                                            servisYeriYerindeValue =
                                                !servisYeriYerindeValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Divider(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hizmet Cinsi",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: hizmetCinsiValue,
                                onChanged: (value) {
                                  hizmetCinsiValue = !hizmetCinsiValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          hizmetCinsiValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Garanti"),
                                        Checkbox(
                                          value: hizmetCinsiGarantiValue,
                                          onChanged: (value) {
                                            hizmetCinsiGarantiValue =
                                                !hizmetCinsiGarantiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("İlk Çalıştırma"),
                                        Checkbox(
                                          value: hizmetCinsiIlkValue,
                                          onChanged: (value) {
                                            hizmetCinsiIlkValue =
                                                !hizmetCinsiIlkValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Normal"),
                                        Checkbox(
                                          value: hizmetCinsiNormalValue,
                                          onChanged: (value) {
                                            hizmetCinsiNormalValue =
                                                !hizmetCinsiNormalValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                value: 0,
                                groupValue: anaTesisatVeyaIcmeSuyuValue,
                                onChanged: (value) {
                                  anaTesisatVeyaIcmeSuyuValue = value;
                                  setState(() {});
                                }),
                            Expanded(
                              child: Text(
                                "Ana Tesisat Girişi",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: anaTesisatVeyaIcmeSuyuValue,
                                onChanged: (value) {
                                  anaTesisatVeyaIcmeSuyuValue = value;
                                  setState(() {});
                                }),
                            Expanded(child: Text("İçme Suyu Sistemleri")),
                          ],
                        ),
                      ),
                    ],
                  ),
            Divider(),
            anaTesisatVeyaIcmeSuyuValue == 1 && raporValue == 1
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                    value: 0,
                                    groupValue: bireyselValue,
                                    onChanged: (value) {
                                      bireyselValue = value;
                                      setState(() {});
                                    }),
                                Text(
                                  "Set Üstü",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                    value: 1,
                                    groupValue: bireyselValue,
                                    onChanged: (value) {
                                      bireyselValue = value;
                                      setState(() {});
                                    }),
                                Text("Arıtmalı\nSebil"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                    value: 2,
                                    groupValue: bireyselValue,
                                    onChanged: (value) {
                                      bireyselValue = value;
                                      setState(() {});
                                    }),
                                Text("Tezgah\nAltı"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      bireyselValue == 0
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pompa"),
                                  Checkbox(
                                    value: setUstuPompaValue,
                                    onChanged: (value) {
                                      setUstuPompaValue = !setUstuPompaValue;
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            )
                          : bireyselValue == 1
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Fotosel"),
                                          Checkbox(
                                            value: aritmaliSebilFotoselValue,
                                            onChanged: (value) {
                                              aritmaliSebilFotoselValue =
                                                  !aritmaliSebilFotoselValue;
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                                value: 0,
                                                groupValue: tezgahAltiKasaValue,
                                                onChanged: (value) {
                                                  tezgahAltiKasaValue = value;
                                                  setState(() {});
                                                }),
                                            Text("Açık Kasa"),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                                value: 1,
                                                groupValue: tezgahAltiKasaValue,
                                                onChanged: (value) {
                                                  tezgahAltiKasaValue = value;
                                                  setState(() {});
                                                }),
                                            Text("Kapalı Kasa"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    tezgahAltiKasaValue == 1
                                        ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: 0,
                                                          groupValue:
                                                              tezgahAltiKapaliKasaValue,
                                                          onChanged: (value) {
                                                            tezgahAltiKapaliKasaValue =
                                                                value;
                                                            setState(() {});
                                                          }),
                                                      Text("Akıllı"),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 35,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: 1,
                                                          groupValue:
                                                              tezgahAltiKapaliKasaValue,
                                                          onChanged: (value) {
                                                            tezgahAltiKapaliKasaValue =
                                                                value;
                                                            setState(() {});
                                                          }),
                                                      Text("Klasik"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Su Yumuşatma",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Switch(
                            value: yumusatmaValue,
                            onChanged: (value) {
                              yumusatmaValue = !yumusatmaValue;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      yumusatmaValue
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Zaman/Debi Ayarı Yapıldı"),
                                    Checkbox(
                                      value: yumusatmaZamanAyariValue,
                                      onChanged: (value) {
                                        yumusatmaZamanAyariValue =
                                            !yumusatmaZamanAyariValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Sızdırmazlık Kontrolü Yapıldı"),
                                    Checkbox(
                                      value: yumusatmaSizdirmazlikValue,
                                      onChanged: (value) {
                                        yumusatmaSizdirmazlikValue =
                                            !yumusatmaSizdirmazlikValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Çıkış Suyu Sertlik Kontrolü Yapıldı"),
                                    Checkbox(
                                      value: yumusatmaCikisSuyuValue,
                                      onChanged: (value) {
                                        yumusatmaCikisSuyuValue =
                                            !yumusatmaCikisSuyuValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Tuz Seviyesi Kontrol Edildi"),
                                    Checkbox(
                                      value: yumusatmaTuzSeviyesiValue,
                                      onChanged: (value) {
                                        yumusatmaTuzSeviyesiValue =
                                            !yumusatmaTuzSeviyesiValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Reçine Minerali Değiştirildi"),
                                    Checkbox(
                                      value: yumusatmaRecineValue,
                                      onChanged: (value) {
                                        yumusatmaRecineValue =
                                            !yumusatmaRecineValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Kum Filtresi",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Switch(
                            value: kumValue,
                            onChanged: (value) {
                              kumValue = !kumValue;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      kumValue
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Zaman Ayarı Yapıldı"),
                                    Checkbox(
                                      value: kumZamanAyariValue,
                                      onChanged: (value) {
                                        kumZamanAyariValue =
                                            !kumZamanAyariValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Sızdırmazlık Kontrolü Yapıldı"),
                                    Checkbox(
                                      value: kumSizdirmazlikValue,
                                      onChanged: (value) {
                                        kumSizdirmazlikValue =
                                            !kumSizdirmazlikValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Ters Yıkama Yaptırıldı"),
                                    Checkbox(
                                      value: kumTersYikamaValue,
                                      onChanged: (value) {
                                        kumTersYikamaValue =
                                            !kumTersYikamaValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Mineral Değiştirildi"),
                                    Checkbox(
                                      value: kumMineralValue,
                                      onChanged: (value) {
                                        kumMineralValue = !kumMineralValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Aktif Karbon",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Switch(
                            value: karbonValue,
                            onChanged: (value) {
                              karbonValue = !karbonValue;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      karbonValue
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Zaman Ayarı Yapıldı"),
                                    Checkbox(
                                      value: karbonZamanAyariValue,
                                      onChanged: (value) {
                                        karbonZamanAyariValue =
                                            !karbonZamanAyariValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Sızdırmazlık Kontrolü Yapıldı"),
                                    Checkbox(
                                      value: karbonSizdirmazlikValue,
                                      onChanged: (value) {
                                        karbonSizdirmazlikValue =
                                            !karbonSizdirmazlikValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Ters Yıkama Yaptırıldı"),
                                    Checkbox(
                                      value: karbonTersYikamaValue,
                                      onChanged: (value) {
                                        karbonTersYikamaValue =
                                            !karbonTersYikamaValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Ak. Karbon Minerali Değiştirildi"),
                                    Checkbox(
                                      value: karbonKarbonMineraliValue,
                                      onChanged: (value) {
                                        karbonKarbonMineraliValue =
                                            !karbonKarbonMineraliValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filtreler",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Switch(
                            value: filtrelerValue,
                            onChanged: (value) {
                              filtrelerValue = !filtrelerValue;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      filtrelerValue
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Temizlendi"),
                                    Checkbox(
                                      value: filtrelerTemizlendiValue,
                                      onChanged: (value) {
                                        filtrelerTemizlendiValue =
                                            !filtrelerTemizlendiValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Değiştirildi"),
                                    Checkbox(
                                      value: filtrelerDegistirildiValue,
                                      onChanged: (value) {
                                        filtrelerDegistirildiValue =
                                            !filtrelerDegistirildiValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Geri Yıkama Yapıldı"),
                                    Checkbox(
                                      value: filtrelerGeriYikamaYapildiValue,
                                      onChanged: (value) {
                                        filtrelerGeriYikamaYapildiValue =
                                            !filtrelerGeriYikamaYapildiValue;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  )
                : anaTesisatVeyaIcmeSuyuValue == 0 && raporValue == 1
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Su Yumuşatma",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: anaTesisatYumusatmaValue,
                                onChanged: (value) {
                                  anaTesisatYumusatmaValue =
                                      !anaTesisatYumusatmaValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          anaTesisatYumusatmaValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Zaman/Debi Ayarı Yapıldı"),
                                        Checkbox(
                                          value:
                                              anaTesisatYumusatmaZamanAyariValue,
                                          onChanged: (value) {
                                            anaTesisatYumusatmaZamanAyariValue =
                                                !anaTesisatYumusatmaZamanAyariValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sızdırmazlık Kontrolü Yapıldı"),
                                        Checkbox(
                                          value:
                                              anaTesisatYumusatmaSizdirmazlikValue,
                                          onChanged: (value) {
                                            anaTesisatYumusatmaSizdirmazlikValue =
                                                !anaTesisatYumusatmaSizdirmazlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Çıkış Suyu Sertlik Kontrolü Yapıldı"),
                                        Checkbox(
                                          value:
                                              anaTesisatYumusatmaCikisSuyuValue,
                                          onChanged: (value) {
                                            anaTesisatYumusatmaCikisSuyuValue =
                                                !anaTesisatYumusatmaCikisSuyuValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Tuz Seviyesi Kontrol Edildi"),
                                        Checkbox(
                                          value:
                                              anaTesisatYumusatmaTuzSeviyesiValue,
                                          onChanged: (value) {
                                            anaTesisatYumusatmaTuzSeviyesiValue =
                                                !anaTesisatYumusatmaTuzSeviyesiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Reçine Minerali Değiştirildi"),
                                        Checkbox(
                                          value: anaTesisatYumusatmaRecineValue,
                                          onChanged: (value) {
                                            anaTesisatYumusatmaRecineValue =
                                                !anaTesisatYumusatmaRecineValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " Otomatik Kum Filtresi",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: anaTesisatKumValue,
                                onChanged: (value) {
                                  anaTesisatKumValue = !anaTesisatKumValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          anaTesisatKumValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Zaman Ayarı Yapıldı"),
                                        Checkbox(
                                          value: anaTesisatKumZamanAyariValue,
                                          onChanged: (value) {
                                            anaTesisatKumZamanAyariValue =
                                                !anaTesisatKumZamanAyariValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sızdırmazlık Kontrolü Yapıldı"),
                                        Checkbox(
                                          value: anaTesisatKumSizdirmazlikValue,
                                          onChanged: (value) {
                                            anaTesisatKumSizdirmazlikValue =
                                                !anaTesisatKumSizdirmazlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ters Yıkama Yaptırıldı"),
                                        Checkbox(
                                          value: anaTesisatKumTersYikamaValue,
                                          onChanged: (value) {
                                            anaTesisatKumTersYikamaValue =
                                                !anaTesisatKumTersYikamaValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Mineral Değiştirildi"),
                                        Checkbox(
                                          value: anaTesisatKumMineralValue,
                                          onChanged: (value) {
                                            anaTesisatKumMineralValue =
                                                !anaTesisatKumMineralValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Otomatik Karbon",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: anaTesisatKarbonValue,
                                onChanged: (value) {
                                  anaTesisatKarbonValue =
                                      !anaTesisatKarbonValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          anaTesisatKarbonValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Zaman Ayarı Yapıldı"),
                                        Checkbox(
                                          value:
                                              anaTesisatKarbonZamanAyariValue,
                                          onChanged: (value) {
                                            anaTesisatKarbonZamanAyariValue =
                                                !anaTesisatKarbonZamanAyariValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sızdırmazlık Kontrolü Yapıldı"),
                                        Checkbox(
                                          value:
                                              anaTesisatKarbonSizdirmazlikValue,
                                          onChanged: (value) {
                                            anaTesisatKarbonSizdirmazlikValue =
                                                !anaTesisatKarbonSizdirmazlikValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ters Yıkama Yaptırıldı"),
                                        Checkbox(
                                          value:
                                              anaTesisatKarbonTersYikamaValue,
                                          onChanged: (value) {
                                            anaTesisatKarbonTersYikamaValue =
                                                !anaTesisatKarbonTersYikamaValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Ak. Karbon Minerali Değiştirildi"),
                                        Checkbox(
                                          value:
                                              anaTesisatKarbonKarbonMineraliValue,
                                          onChanged: (value) {
                                            anaTesisatKarbonKarbonMineraliValue =
                                                !anaTesisatKarbonKarbonMineraliValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Mekanik Filtreler",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: anaTesisatFiltrelerValue,
                                onChanged: (value) {
                                  anaTesisatFiltrelerValue =
                                      !anaTesisatFiltrelerValue;
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          anaTesisatFiltrelerValue
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Temizlendi"),
                                        Checkbox(
                                          value:
                                              anaTesisatFiltrelerTemizlendiValue,
                                          onChanged: (value) {
                                            anaTesisatFiltrelerTemizlendiValue =
                                                !anaTesisatFiltrelerTemizlendiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Değiştirildi"),
                                        Checkbox(
                                          value:
                                              anaTesisatFiltrelerDegistirildiValue,
                                          onChanged: (value) {
                                            anaTesisatFiltrelerDegistirildiValue =
                                                !anaTesisatFiltrelerDegistirildiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Geri Yıkama Yapıldı"),
                                        Checkbox(
                                          value:
                                              anaTesisatFiltrelerGeriYikamaYapildiValue,
                                          onChanged: (value) {
                                            anaTesisatFiltrelerGeriYikamaYapildiValue =
                                                !anaTesisatFiltrelerGeriYikamaYapildiValue;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      )
                    : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                controller: _descriptionController,
                hintText: "Bir açıklama girin",
                labelText: "Açıklama",
                maxLines: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _assignValuesToServiceReportRepository(
      ChooseSparePartProvider _chooseSparePartProvider) {
    _serviceReportRepository.sale = _sale;
    _serviceReportRepository.description = _descriptionController.text;
    _serviceReportRepository.raporValue = raporValue;
    _serviceReportRepository.anaTesisatVeyaIcmeSuyuValue =
        anaTesisatVeyaIcmeSuyuValue;
    _serviceReportRepository.kurumsalValue = kurumsalValue;
    _serviceReportRepository.bireyselValue = bireyselValue;
    _serviceReportRepository.tezgahAltiKasaValue = tezgahAltiKasaValue;
    _serviceReportRepository.tezgahAltiKapaliKasaValue =
        tezgahAltiKapaliKasaValue;
    _serviceReportRepository.filtrelerValue = filtrelerValue;
    _serviceReportRepository.yumusatmaValue = yumusatmaValue;
    _serviceReportRepository.karbonValue = karbonValue;
    _serviceReportRepository.klorlamaValue = klorlamaValue;
    _serviceReportRepository.kumValue = kumValue;
    _serviceReportRepository.endustriyelROValue = endustriyelROValue;
    _serviceReportRepository.ultravioleValue = ultravioleValue;
    _serviceReportRepository.hizmetCinsiValue = hizmetCinsiValue;
    _serviceReportRepository.servisHizmetiValue = servisHizmetiValue;
    _serviceReportRepository.icmeSuyuSistemleriValue = icmeSuyuSistemleriValue;
    _serviceReportRepository.filtrelerTemizlendiValue =
        filtrelerTemizlendiValue;
    _serviceReportRepository.filtrelerDegistirildiValue =
        filtrelerDegistirildiValue;
    _serviceReportRepository.filtrelerGeriYikamaYapildiValue =
        filtrelerGeriYikamaYapildiValue;
    _serviceReportRepository.yumusatmaZamanAyariValue =
        yumusatmaZamanAyariValue;
    _serviceReportRepository.yumusatmaSizdirmazlikValue =
        yumusatmaSizdirmazlikValue;
    _serviceReportRepository.yumusatmaCikisSuyuValue = yumusatmaCikisSuyuValue;
    _serviceReportRepository.yumusatmaTuzSeviyesiValue =
        yumusatmaTuzSeviyesiValue;
    _serviceReportRepository.yumusatmaRecineValue = yumusatmaRecineValue;
    _serviceReportRepository.karbonZamanAyariValue = karbonZamanAyariValue;
    _serviceReportRepository.karbonSizdirmazlikValue = karbonSizdirmazlikValue;
    _serviceReportRepository.karbonTersYikamaValue = karbonTersYikamaValue;
    _serviceReportRepository.karbonKarbonMineraliValue =
        karbonKarbonMineraliValue;
    _serviceReportRepository.kumZamanAyariValue = kumZamanAyariValue;
    _serviceReportRepository.kumSizdirmazlikValue = kumSizdirmazlikValue;
    _serviceReportRepository.kumTersYikamaValue = kumTersYikamaValue;
    _serviceReportRepository.kumMineralValue = kumMineralValue;
    _serviceReportRepository.klorCekvalflerValue = klorCekvalflerValue;
    _serviceReportRepository.klorOlcumValue = klorOlcumValue;
    _serviceReportRepository.klorIlaveValue = klorIlaveValue;
    _serviceReportRepository.klorSizdirmazlikValue = klorSizdirmazlikValue;
    _serviceReportRepository.endustriyelROGuvenlikValue =
        endustriyelROGuvenlikValue;
    _serviceReportRepository.endustriyelROMembranValue =
        endustriyelROMembranValue;
    _serviceReportRepository.endustriyelROKimyasalValue =
        endustriyelROKimyasalValue;
    _serviceReportRepository.endustriyelROSizdirmazlikValue =
        endustriyelROSizdirmazlikValue;
    _serviceReportRepository.uvLambaKontrolValue = uvLambaKontrolValue;
    _serviceReportRepository.uvSizdirmazlikValue = uvSizdirmazlikValue;
    _serviceReportRepository.uvVoltajRegulatoruValue = uvVoltajRegulatoruValue;
    _serviceReportRepository.uvLambaDegistirildiValue =
        uvLambaDegistirildiValue;
    _serviceReportRepository.uvQuvartsKilifValue = uvQuvartsKilifValue;
    _serviceReportRepository.servisYeriServisteValue = servisYeriServisteValue;
    _serviceReportRepository.servisYeriYerindeValue = servisYeriYerindeValue;
    _serviceReportRepository.hizmetCinsiGarantiValue = hizmetCinsiGarantiValue;
    _serviceReportRepository.hizmetCinsiIlkValue = hizmetCinsiIlkValue;
    _serviceReportRepository.hizmetCinsiNormalValue = hizmetCinsiNormalValue;
    _serviceReportRepository.setUstuFotoselValue = setUstuFotoselValue;
    _serviceReportRepository.setUstuPompaValue = setUstuPompaValue;
    _serviceReportRepository.tezgahAltiFotoselValue = tezgahAltiFotoselValue;
    _serviceReportRepository.tezgahAltiPompaValue = tezgahAltiPompaValue;
    _serviceReportRepository.acikKasaValue = acikKasaValue;
    _serviceReportRepository.kapaliKasaValue = kapaliKasaValue;
    _serviceReportRepository.kapaliKasaAkilliValue = kapaliKasaAkilliValue;
    _serviceReportRepository.kapaliKasaKlasikValue = kapaliKasaKlasikValue;
    _serviceReportRepository.aritmaliSebilFotoselValue =
        aritmaliSebilFotoselValue;
    _serviceReportRepository.anaTesisatYumusatmaValue =
        anaTesisatYumusatmaValue;
    _serviceReportRepository.anaTesisatYumusatmaZamanAyariValue =
        anaTesisatYumusatmaZamanAyariValue;
    _serviceReportRepository.anaTesisatYumusatmaSizdirmazlikValue =
        anaTesisatYumusatmaSizdirmazlikValue;
    _serviceReportRepository.anaTesisatYumusatmaCikisSuyuValue =
        anaTesisatYumusatmaCikisSuyuValue;
    _serviceReportRepository.anaTesisatYumusatmaTuzSeviyesiValue =
        anaTesisatYumusatmaTuzSeviyesiValue;
    _serviceReportRepository.anaTesisatYumusatmaRecineValue =
        anaTesisatYumusatmaRecineValue;
    _serviceReportRepository.anaTesisatKumValue = anaTesisatKumValue;
    _serviceReportRepository.anaTesisatKumZamanAyariValue =
        anaTesisatKumZamanAyariValue;
    _serviceReportRepository.anaTesisatKumSizdirmazlikValue =
        anaTesisatKumSizdirmazlikValue;
    _serviceReportRepository.anaTesisatKumTersYikamaValue =
        anaTesisatKumTersYikamaValue;
    _serviceReportRepository.anaTesisatKumMineralValue =
        anaTesisatKumMineralValue;
    _serviceReportRepository.anaTesisatKarbonValue = anaTesisatKarbonValue;
    _serviceReportRepository.anaTesisatKarbonZamanAyariValue =
        anaTesisatKarbonZamanAyariValue;
    _serviceReportRepository.anaTesisatKarbonSizdirmazlikValue =
        anaTesisatKarbonSizdirmazlikValue;
    _serviceReportRepository.anaTesisatKarbonTersYikamaValue =
        anaTesisatKarbonTersYikamaValue;
    _serviceReportRepository.anaTesisatKarbonKarbonMineraliValue =
        anaTesisatKarbonKarbonMineraliValue;
    _serviceReportRepository.anaTesisatFiltrelerValue =
        anaTesisatFiltrelerValue;
    _serviceReportRepository.anaTesisatFiltrelerTemizlendiValue =
        anaTesisatFiltrelerTemizlendiValue;
    _serviceReportRepository.anaTesisatFiltrelerDegistirildiValue =
        anaTesisatFiltrelerDegistirildiValue;
    _serviceReportRepository.anaTesisatFiltrelerGeriYikamaYapildiValue =
        anaTesisatFiltrelerGeriYikamaYapildiValue;
    _serviceReportRepository.spareParts =
        _chooseSparePartProvider.choosedSpareParts;
    _serviceReportRepository.counts = _controllers;
  }

  Future _pushToDatabase(ChooseSparePartProvider _chooseSparePartProvider,
      BuildContext context) async {
    try {
      EralpHelper.startProgress();
      final _response = await http.post(
        Uri.parse(
          ApiUrls.serviceReport,
        ),
        headers: {
          'Content-Type': 'application/json',
          "token": _authRepository.apiUser.token,
        },
        body: jsonEncode(
          {
            "description": _descriptionController.text,
            "pdfUrl": pdfUrl,
            "saleId": _sale.id,
            "raporValue": raporValue,
            "anaTesisatVeyaIcmeSuyuValue": anaTesisatVeyaIcmeSuyuValue,
            "kurumsalValue": kurumsalValue,
            "bireyselValue": bireyselValue,
            "tezgahAltiKasaValue": tezgahAltiKasaValue,
            "tezgahAltiKapaliKasaValue": tezgahAltiKapaliKasaValue,
            "filtrelerValue": filtrelerValue ? 1 : 0,
            "yumusatmaValue": yumusatmaValue ? 1 : 0,
            "karbonValue": karbonValue ? 1 : 0,
            "klorlamaValue": klorlamaValue ? 1 : 0,
            "kumValue": kumValue ? 1 : 0,
            "endustriyelROValue": endustriyelROValue ? 1 : 0,
            "ultravioleValue": ultravioleValue ? 1 : 0,
            "hizmetCinsiValue": hizmetCinsiValue ? 1 : 0,
            "servisHizmetiValue": servisHizmetiValue ? 1 : 0,
            "icmeSuyuSistemleriValue": icmeSuyuSistemleriValue ? 1 : 0,
            "filtrelerTemizlendiValue": filtrelerTemizlendiValue ? 1 : 0,
            "filtrelerDegistirildiValue": filtrelerDegistirildiValue ? 1 : 0,
            "filtrelerGeriYikamaYapildiValue":
                filtrelerGeriYikamaYapildiValue ? 1 : 0,
            "yumusatmaZamanAyariValue": yumusatmaZamanAyariValue ? 1 : 0,
            "yumusatmaSizdirmazlikValue": yumusatmaSizdirmazlikValue ? 1 : 0,
            "yumusatmaCikisSuyuValue": yumusatmaCikisSuyuValue ? 1 : 0,
            "yumusatmaTuzSeviyesiValue": yumusatmaTuzSeviyesiValue ? 1 : 0,
            "yumusatmaRecineValue": yumusatmaRecineValue ? 1 : 0,
            "karbonZamanAyariValue": karbonZamanAyariValue ? 1 : 0,
            "karbonSizdirmazlikValue": karbonSizdirmazlikValue ? 1 : 0,
            "karbonTersYikamaValue": karbonTersYikamaValue ? 1 : 0,
            "karbonKarbonMineraliValue": karbonKarbonMineraliValue ? 1 : 0,
            "kumZamanAyariValue": kumZamanAyariValue ? 1 : 0,
            "kumSizdirmazlikValue": kumSizdirmazlikValue ? 1 : 0,
            "kumTersYikamaValue": kumTersYikamaValue ? 1 : 0,
            "kumMineralValue": kumMineralValue ? 1 : 0,
            "klorCekvalflerValue": klorCekvalflerValue ? 1 : 0,
            "klorOlcumValue": klorOlcumValue ? 1 : 0,
            "klorIlaveValue": klorIlaveValue ? 1 : 0,
            "klorSizdirmazlikValue": klorSizdirmazlikValue ? 1 : 0,
            "endustriyelROGuvenlikValue": endustriyelROGuvenlikValue ? 1 : 0,
            "endustriyelROMembranValue": endustriyelROMembranValue ? 1 : 0,
            "endustriyelROKimyasalValue": endustriyelROKimyasalValue ? 1 : 0,
            "endustriyelROSizdirmazlikValue":
                endustriyelROSizdirmazlikValue ? 1 : 0,
            "uvLambaKontrolValue": uvLambaKontrolValue ? 1 : 0,
            "uvSizdirmazlikValue": uvSizdirmazlikValue ? 1 : 0,
            "uvVoltajRegulatoruValue": uvVoltajRegulatoruValue ? 1 : 0,
            "uvLambaDegistirildiValue": uvLambaDegistirildiValue ? 1 : 0,
            "uvQuvartsKilifValue": uvQuvartsKilifValue ? 1 : 0,
            "servisYeriServisteValue": servisYeriServisteValue ? 1 : 0,
            "servisYeriYerindeValue": servisYeriYerindeValue ? 1 : 0,
            "hizmetCinsiGarantiValue": hizmetCinsiGarantiValue ? 1 : 0,
            "hizmetCinsiIlkValue": hizmetCinsiIlkValue ? 1 : 0,
            "hizmetCinsiNormalValue": hizmetCinsiNormalValue ? 1 : 0,
            "setUstuFotoselValue": setUstuFotoselValue ? 1 : 0,
            "setUstuPompaValue": setUstuPompaValue ? 1 : 0,
            "tezgahAltiFotoselValue": tezgahAltiFotoselValue ? 1 : 0,
            "tezgahAltiPompaValue": tezgahAltiPompaValue ? 1 : 0,
            "acikKasaValue": acikKasaValue ? 1 : 0,
            "kapaliKasaValue": kapaliKasaValue ? 1 : 0,
            "kapaliKasaAkilliValue": kapaliKasaAkilliValue ? 1 : 0,
            "kapaliKasaKlasikValue": kapaliKasaKlasikValue ? 1 : 0,
            "aritmaliSebilFotoselValue": aritmaliSebilFotoselValue ? 1 : 0,
            "anaTesisatYumusatmaValue": anaTesisatYumusatmaValue ? 1 : 0,
            "anaTesisatYumusatmaZamanAyariValue":
                anaTesisatYumusatmaZamanAyariValue ? 1 : 0,
            "anaTesisatYumusatmaSizdirmazlikValue":
                anaTesisatYumusatmaSizdirmazlikValue ? 1 : 0,
            "anaTesisatYumusatmaCikisSuyuValue":
                anaTesisatYumusatmaCikisSuyuValue ? 1 : 0,
            "anaTesisatYumusatmaTuzSeviyesiValue":
                anaTesisatYumusatmaTuzSeviyesiValue ? 1 : 0,
            "anaTesisatYumusatmaRecineValue":
                anaTesisatYumusatmaRecineValue ? 1 : 0,
            "anaTesisatKumValue": anaTesisatKumValue ? 1 : 0,
            "anaTesisatKumZamanAyariValue":
                anaTesisatKumZamanAyariValue ? 1 : 0,
            "anaTesisatKumSizdirmazlikValue":
                anaTesisatKumSizdirmazlikValue ? 1 : 0,
            "anaTesisatKumTersYikamaValue":
                anaTesisatKumTersYikamaValue ? 1 : 0,
            "anaTesisatKumMineralValue": anaTesisatKumMineralValue ? 1 : 0,
            "anaTesisatKarbonValue": anaTesisatKarbonValue ? 1 : 0,
            "anaTesisatKarbonZamanAyariValue":
                anaTesisatKarbonZamanAyariValue ? 1 : 0,
            "anaTesisatKarbonSizdirmazlikValue":
                anaTesisatKarbonSizdirmazlikValue ? 1 : 0,
            "anaTesisatKarbonTersYikamaValue":
                anaTesisatKarbonTersYikamaValue ? 1 : 0,
            "anaTesisatKarbonKarbonMineraliValue":
                anaTesisatKarbonKarbonMineraliValue ? 1 : 0,
            "anaTesisatFiltrelerValue": anaTesisatFiltrelerValue ? 1 : 0,
            "anaTesisatFiltrelerTemizlendiValue":
                anaTesisatFiltrelerTemizlendiValue ? 1 : 0,
            "anaTesisatFiltrelerDegistirildiValue":
                anaTesisatFiltrelerDegistirildiValue ? 1 : 0,
            "anaTesisatFiltrelerGeriYikamaYapildiValue":
                anaTesisatFiltrelerGeriYikamaYapildiValue ? 1 : 0,
          },
        ),
      );
      print(_response.body);
      if (_response.statusCode == 200) {
        for (var i = 0;
            i < _chooseSparePartProvider.choosedSpareParts.length;
            i++) {
          final _sparePartResponse = await PostApi.addServiceReportSpareParts(
            map: {
              "serviceReportId": json.decode(_response.body)["id"],
              "sparePartId": _chooseSparePartProvider.choosedSpareParts[i].id,
              "count": int.parse(_controllers[i].text),
            },
          );
          if (_sparePartResponse is bool) {
            final _putResponse = await PutApi.putSparePart(
              count: _chooseSparePartProvider.choosedSpareParts[i].count -
                  int.parse(_controllers[i].text),
              id: _chooseSparePartProvider.choosedSpareParts[i].id.toString(),
            );
            print("$_putResponse");
          }
        }
        _chooseSparePartProvider.clear();
        BlocProvider.of<ServiceReportBloc>(context)
            .add(ClearServiceReportListEvent());
        BlocProvider.of<SparePartListBloc>(context)
            .add(ClearSparePartListEvent());
        Navigator.pop(context);
        MyFlushbarHelper(context: context).showSuccessFlushbar(
            title: "Başarılı", message: "Servis raporu başarıyla eklendi");
      } else {
        MyFlushbarHelper(context: context).showErrorFlushbar(
            title: "Başarısız",
            message:
                "Servis raporu ekleme başarısız: ${jsonDecode(_response.body)["message"]}");
        return jsonDecode(_response.body)["message"];
      }
    } on Exception catch (e) {
      MyFlushbarHelper(context: context).showErrorFlushbar(
          title: "Başarısız", message: "Servis raporu ekleme başarısız: $e");
      print(e);
      return null;
    } finally {
      EralpHelper.stopProgress();
    }
  }

  void clearValues() {
    _descriptionController.text = "";
    anaTesisatVeyaIcmeSuyuValue = 0;
    kurumsalValue = 0;
    bireyselValue = 0;
    tezgahAltiKasaValue = 0;
    tezgahAltiKapaliKasaValue = 0;
    filtrelerValue = false;
    yumusatmaValue = false;
    karbonValue = false;
    klorlamaValue = false;
    kumValue = false;
    endustriyelROValue = false;
    ultravioleValue = false;
    hizmetCinsiValue = false;
    servisHizmetiValue = false;
    icmeSuyuSistemleriValue = false;
    filtrelerTemizlendiValue = false;
    filtrelerDegistirildiValue = false;
    filtrelerGeriYikamaYapildiValue = false;
    yumusatmaZamanAyariValue = false;
    yumusatmaSizdirmazlikValue = false;
    yumusatmaCikisSuyuValue = false;
    yumusatmaTuzSeviyesiValue = false;
    yumusatmaRecineValue = false;
    karbonZamanAyariValue = false;
    karbonSizdirmazlikValue = false;
    karbonTersYikamaValue = false;
    karbonKarbonMineraliValue = false;
    kumZamanAyariValue = false;
    kumSizdirmazlikValue = false;
    kumTersYikamaValue = false;
    kumMineralValue = false;
    klorCekvalflerValue = false;
    klorOlcumValue = false;
    klorIlaveValue = false;
    klorSizdirmazlikValue = false;
    endustriyelROGuvenlikValue = false;
    endustriyelROMembranValue = false;
    endustriyelROKimyasalValue = false;
    endustriyelROSizdirmazlikValue = false;
    uvLambaKontrolValue = false;
    uvSizdirmazlikValue = false;
    uvVoltajRegulatoruValue = false;
    uvLambaDegistirildiValue = false;
    uvQuvartsKilifValue = false;
    servisYeriServisteValue = false;
    servisYeriYerindeValue = false;
    hizmetCinsiGarantiValue = false;
    hizmetCinsiIlkValue = false;
    hizmetCinsiNormalValue = false;
    setUstuFotoselValue = false;
    setUstuPompaValue = false;
    tezgahAltiFotoselValue = false;
    tezgahAltiPompaValue = false;
    acikKasaValue = false;
    kapaliKasaValue = false;
    kapaliKasaAkilliValue = false;
    kapaliKasaKlasikValue = false;
    aritmaliSebilFotoselValue = false;
    anaTesisatYumusatmaValue = false;
    anaTesisatYumusatmaZamanAyariValue = false;
    anaTesisatYumusatmaSizdirmazlikValue = false;
    anaTesisatYumusatmaCikisSuyuValue = false;
    anaTesisatYumusatmaTuzSeviyesiValue = false;
    anaTesisatYumusatmaRecineValue = false;
    anaTesisatKumValue = false;
    anaTesisatKumZamanAyariValue = false;
    anaTesisatKumSizdirmazlikValue = false;
    anaTesisatKumTersYikamaValue = false;
    anaTesisatKumMineralValue = false;
    anaTesisatKarbonValue = false;
    anaTesisatKarbonZamanAyariValue = false;
    anaTesisatKarbonSizdirmazlikValue = false;
    anaTesisatKarbonTersYikamaValue = false;
    anaTesisatKarbonKarbonMineraliValue = false;
    anaTesisatFiltrelerValue = false;
    anaTesisatFiltrelerTemizlendiValue = false;
    anaTesisatFiltrelerDegistirildiValue = false;
    anaTesisatFiltrelerGeriYikamaYapildiValue = false;

    _serviceReportRepository.anaTesisatVeyaIcmeSuyuValue = 0;
    _serviceReportRepository.kurumsalValue = 0;
    _serviceReportRepository.bireyselValue = 0;
    _serviceReportRepository.tezgahAltiKasaValue = 0;
    _serviceReportRepository.tezgahAltiKapaliKasaValue = 0;
    _serviceReportRepository.filtrelerValue = false;
    _serviceReportRepository.yumusatmaValue = false;
    _serviceReportRepository.karbonValue = false;
    _serviceReportRepository.klorlamaValue = false;
    _serviceReportRepository.kumValue = false;
    _serviceReportRepository.endustriyelROValue = false;
    _serviceReportRepository.ultravioleValue = false;
    _serviceReportRepository.hizmetCinsiValue = false;
    _serviceReportRepository.servisHizmetiValue = false;
    _serviceReportRepository.icmeSuyuSistemleriValue = false;
    _serviceReportRepository.filtrelerTemizlendiValue = false;
    _serviceReportRepository.filtrelerDegistirildiValue = false;
    _serviceReportRepository.filtrelerGeriYikamaYapildiValue = false;
    _serviceReportRepository.yumusatmaZamanAyariValue = false;
    _serviceReportRepository.yumusatmaSizdirmazlikValue = false;
    _serviceReportRepository.yumusatmaCikisSuyuValue = false;
    _serviceReportRepository.yumusatmaTuzSeviyesiValue = false;
    _serviceReportRepository.yumusatmaRecineValue = false;
    _serviceReportRepository.karbonZamanAyariValue = false;
    _serviceReportRepository.karbonSizdirmazlikValue = false;
    _serviceReportRepository.karbonTersYikamaValue = false;
    _serviceReportRepository.karbonKarbonMineraliValue = false;
    _serviceReportRepository.kumZamanAyariValue = false;
    _serviceReportRepository.kumSizdirmazlikValue = false;
    _serviceReportRepository.kumTersYikamaValue = false;
    _serviceReportRepository.kumMineralValue = false;
    _serviceReportRepository.klorCekvalflerValue = false;
    _serviceReportRepository.klorOlcumValue = false;
    _serviceReportRepository.klorIlaveValue = false;
    _serviceReportRepository.klorSizdirmazlikValue = false;
    _serviceReportRepository.endustriyelROGuvenlikValue = false;
    _serviceReportRepository.endustriyelROMembranValue = false;
    _serviceReportRepository.endustriyelROKimyasalValue = false;
    _serviceReportRepository.endustriyelROSizdirmazlikValue = false;
    _serviceReportRepository.uvLambaKontrolValue = false;
    _serviceReportRepository.uvSizdirmazlikValue = false;
    _serviceReportRepository.uvVoltajRegulatoruValue = false;
    _serviceReportRepository.uvLambaDegistirildiValue = false;
    _serviceReportRepository.uvQuvartsKilifValue = false;
    _serviceReportRepository.servisYeriServisteValue = false;
    _serviceReportRepository.servisYeriYerindeValue = false;
    _serviceReportRepository.hizmetCinsiGarantiValue = false;
    _serviceReportRepository.hizmetCinsiIlkValue = false;
    _serviceReportRepository.hizmetCinsiNormalValue = false;
    _serviceReportRepository.setUstuFotoselValue = false;
    _serviceReportRepository.setUstuPompaValue = false;
    _serviceReportRepository.tezgahAltiFotoselValue = false;
    _serviceReportRepository.tezgahAltiPompaValue = false;
    _serviceReportRepository.acikKasaValue = false;
    _serviceReportRepository.kapaliKasaValue = false;
    _serviceReportRepository.kapaliKasaAkilliValue = false;
    _serviceReportRepository.kapaliKasaKlasikValue = false;
    _serviceReportRepository.aritmaliSebilFotoselValue = false;
    _serviceReportRepository.anaTesisatYumusatmaValue = false;
    _serviceReportRepository.anaTesisatYumusatmaZamanAyariValue = false;
    _serviceReportRepository.anaTesisatYumusatmaSizdirmazlikValue = false;
    _serviceReportRepository.anaTesisatYumusatmaCikisSuyuValue = false;
    _serviceReportRepository.anaTesisatYumusatmaTuzSeviyesiValue = false;
    _serviceReportRepository.anaTesisatYumusatmaRecineValue = false;
    _serviceReportRepository.anaTesisatKumValue = false;
    _serviceReportRepository.anaTesisatKumZamanAyariValue = false;
    _serviceReportRepository.anaTesisatKumSizdirmazlikValue = false;
    _serviceReportRepository.anaTesisatKumTersYikamaValue = false;
    _serviceReportRepository.anaTesisatKumMineralValue = false;
    _serviceReportRepository.anaTesisatKarbonValue = false;
    _serviceReportRepository.anaTesisatKarbonZamanAyariValue = false;
    _serviceReportRepository.anaTesisatKarbonSizdirmazlikValue = false;
    _serviceReportRepository.anaTesisatKarbonTersYikamaValue = false;
    _serviceReportRepository.anaTesisatKarbonKarbonMineraliValue = false;
    _serviceReportRepository.anaTesisatFiltrelerValue = false;
    _serviceReportRepository.anaTesisatFiltrelerTemizlendiValue = false;
    _serviceReportRepository.anaTesisatFiltrelerDegistirildiValue = false;
    _serviceReportRepository.anaTesisatFiltrelerGeriYikamaYapildiValue = false;
    _serviceReportRepository.description = "";

    setState(() {});
  }
}
