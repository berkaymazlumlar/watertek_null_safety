import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/api_urls.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/api/put_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/service_report/service_report_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/spare_part_list/bloc/spare_part_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/create_service_report_pdf_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/pages/service_report/draw_customer_page.dart';
import 'package:teknoloji_kimya_servis/pages/service_report/draw_worker_page.dart';
import 'package:teknoloji_kimya_servis/providers/choose_spare_part_provider.dart';
import 'package:teknoloji_kimya_servis/providers/sign_provider.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/service_report/service_report_data_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/views/general/my_raised_button.dart';
import 'package:http/http.dart' as http;

AuthRepository _authRepository = locator<AuthRepository>();
ServiceReportDataRepository _serviceReportDataRepository =
    locator<ServiceReportDataRepository>();

class ShowPdfPage extends StatefulWidget {
  final File pdf;
  ShowPdfPage({Key key, @required this.pdf}) : super(key: key);

  @override
  _ShowPdfPageState createState() => _ShowPdfPageState();
}

class _ShowPdfPageState extends State<ShowPdfPage> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Provider.of<SignProvider>(context, listen: false).workerSign = null;
            Provider.of<SignProvider>(context, listen: false).customerSign =
                null;
          },
          child: Text('PDF'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              if (Provider.of<SignProvider>(context, listen: false)
                      .workerSign ==
                  null) {
                MyFlushbarHelper(context: context).showInfoFlushbar(
                  title: "Personel imzası eksik",
                  message:
                      "Devam edebilmeniz için personelin imza atması gerekmekte.",
                );
                return;
              }
              if (Provider.of<SignProvider>(context, listen: false)
                      .customerSign ==
                  null) {
                MyFlushbarHelper(context: context).showInfoFlushbar(
                  title: "Müşteri imzası eksik",
                  message:
                      "Devam edebilmeniz için müşterinin imza atması gerekmekte.",
                );
                return;
              }

              try {
                EralpHelper.startProgress();
                final _response = await http.post(
                  ApiUrls.serviceReport,
                  headers: {
                    'Content-Type': 'application/json',
                    "token": _authRepository.apiUser.token,
                  },
                  body: jsonEncode(
                    {
                      "pdfUrl": "",
                      "description":
                          "${_serviceReportDataRepository.description}",
                      "saleId": _serviceReportDataRepository.sale.id,
                      "raporValue": _serviceReportDataRepository.raporValue,
                      "anaTesisatVeyaIcmeSuyuValue":
                          _serviceReportDataRepository
                              .anaTesisatVeyaIcmeSuyuValue,
                      "kurumsalValue":
                          _serviceReportDataRepository.kurumsalValue,
                      "bireyselValue":
                          _serviceReportDataRepository.bireyselValue,
                      "tezgahAltiKasaValue":
                          _serviceReportDataRepository.tezgahAltiKasaValue,
                      "tezgahAltiKapaliKasaValue": _serviceReportDataRepository
                          .tezgahAltiKapaliKasaValue,
                      "filtrelerValue":
                          _serviceReportDataRepository.filtrelerValue ? 1 : 0,
                      "yumusatmaValue":
                          _serviceReportDataRepository.yumusatmaValue ? 1 : 0,
                      "karbonValue":
                          _serviceReportDataRepository.karbonValue ? 1 : 0,
                      "klorlamaValue":
                          _serviceReportDataRepository.klorlamaValue ? 1 : 0,
                      "kumValue": _serviceReportDataRepository.kumValue ? 1 : 0,
                      "endustriyelROValue":
                          _serviceReportDataRepository.endustriyelROValue
                              ? 1
                              : 0,
                      "ultravioleValue":
                          _serviceReportDataRepository.ultravioleValue ? 1 : 0,
                      "hizmetCinsiValue":
                          _serviceReportDataRepository.hizmetCinsiValue ? 1 : 0,
                      "servisHizmetiValue":
                          _serviceReportDataRepository.servisHizmetiValue
                              ? 1
                              : 0,
                      "icmeSuyuSistemleriValue":
                          _serviceReportDataRepository.icmeSuyuSistemleriValue
                              ? 1
                              : 0,
                      "filtrelerTemizlendiValue":
                          _serviceReportDataRepository.filtrelerTemizlendiValue
                              ? 1
                              : 0,
                      "filtrelerDegistirildiValue": _serviceReportDataRepository
                              .filtrelerDegistirildiValue
                          ? 1
                          : 0,
                      "filtrelerGeriYikamaYapildiValue":
                          _serviceReportDataRepository
                                  .filtrelerGeriYikamaYapildiValue
                              ? 1
                              : 0,
                      "yumusatmaZamanAyariValue":
                          _serviceReportDataRepository.yumusatmaZamanAyariValue
                              ? 1
                              : 0,
                      "yumusatmaSizdirmazlikValue": _serviceReportDataRepository
                              .yumusatmaSizdirmazlikValue
                          ? 1
                          : 0,
                      "yumusatmaCikisSuyuValue":
                          _serviceReportDataRepository.yumusatmaCikisSuyuValue
                              ? 1
                              : 0,
                      "yumusatmaTuzSeviyesiValue":
                          _serviceReportDataRepository.yumusatmaTuzSeviyesiValue
                              ? 1
                              : 0,
                      "yumusatmaRecineValue":
                          _serviceReportDataRepository.yumusatmaRecineValue
                              ? 1
                              : 0,
                      "karbonZamanAyariValue":
                          _serviceReportDataRepository.karbonZamanAyariValue
                              ? 1
                              : 0,
                      "karbonSizdirmazlikValue":
                          _serviceReportDataRepository.karbonSizdirmazlikValue
                              ? 1
                              : 0,
                      "karbonTersYikamaValue":
                          _serviceReportDataRepository.karbonTersYikamaValue
                              ? 1
                              : 0,
                      "karbonKarbonMineraliValue":
                          _serviceReportDataRepository.karbonKarbonMineraliValue
                              ? 1
                              : 0,
                      "kumZamanAyariValue":
                          _serviceReportDataRepository.kumZamanAyariValue
                              ? 1
                              : 0,
                      "kumSizdirmazlikValue":
                          _serviceReportDataRepository.kumSizdirmazlikValue
                              ? 1
                              : 0,
                      "kumTersYikamaValue":
                          _serviceReportDataRepository.kumTersYikamaValue
                              ? 1
                              : 0,
                      "kumMineralValue":
                          _serviceReportDataRepository.kumMineralValue ? 1 : 0,
                      "klorCekvalflerValue":
                          _serviceReportDataRepository.klorCekvalflerValue
                              ? 1
                              : 0,
                      "klorOlcumValue":
                          _serviceReportDataRepository.klorOlcumValue ? 1 : 0,
                      "klorIlaveValue":
                          _serviceReportDataRepository.klorIlaveValue ? 1 : 0,
                      "klorSizdirmazlikValue":
                          _serviceReportDataRepository.klorSizdirmazlikValue
                              ? 1
                              : 0,
                      "endustriyelROGuvenlikValue": _serviceReportDataRepository
                              .endustriyelROGuvenlikValue
                          ? 1
                          : 0,
                      "endustriyelROMembranValue":
                          _serviceReportDataRepository.endustriyelROMembranValue
                              ? 1
                              : 0,
                      "endustriyelROKimyasalValue": _serviceReportDataRepository
                              .endustriyelROKimyasalValue
                          ? 1
                          : 0,
                      "endustriyelROSizdirmazlikValue":
                          _serviceReportDataRepository
                                  .endustriyelROSizdirmazlikValue
                              ? 1
                              : 0,
                      "uvLambaKontrolValue":
                          _serviceReportDataRepository.uvLambaKontrolValue
                              ? 1
                              : 0,
                      "uvSizdirmazlikValue":
                          _serviceReportDataRepository.uvSizdirmazlikValue
                              ? 1
                              : 0,
                      "uvVoltajRegulatoruValue":
                          _serviceReportDataRepository.uvVoltajRegulatoruValue
                              ? 1
                              : 0,
                      "uvLambaDegistirildiValue":
                          _serviceReportDataRepository.uvLambaDegistirildiValue
                              ? 1
                              : 0,
                      "uvQuvartsKilifValue":
                          _serviceReportDataRepository.uvQuvartsKilifValue
                              ? 1
                              : 0,
                      "servisYeriServisteValue":
                          _serviceReportDataRepository.servisYeriServisteValue
                              ? 1
                              : 0,
                      "servisYeriYerindeValue":
                          _serviceReportDataRepository.servisYeriYerindeValue
                              ? 1
                              : 0,
                      "hizmetCinsiGarantiValue":
                          _serviceReportDataRepository.hizmetCinsiGarantiValue
                              ? 1
                              : 0,
                      "hizmetCinsiIlkValue":
                          _serviceReportDataRepository.hizmetCinsiIlkValue
                              ? 1
                              : 0,
                      "hizmetCinsiNormalValue":
                          _serviceReportDataRepository.hizmetCinsiNormalValue
                              ? 1
                              : 0,
                      "setUstuFotoselValue":
                          _serviceReportDataRepository.setUstuFotoselValue
                              ? 1
                              : 0,
                      "setUstuPompaValue":
                          _serviceReportDataRepository.setUstuPompaValue
                              ? 1
                              : 0,
                      "tezgahAltiFotoselValue":
                          _serviceReportDataRepository.tezgahAltiFotoselValue
                              ? 1
                              : 0,
                      "tezgahAltiPompaValue":
                          _serviceReportDataRepository.tezgahAltiPompaValue
                              ? 1
                              : 0,
                      "acikKasaValue":
                          _serviceReportDataRepository.acikKasaValue ? 1 : 0,
                      "kapaliKasaValue":
                          _serviceReportDataRepository.kapaliKasaValue ? 1 : 0,
                      "kapaliKasaAkilliValue":
                          _serviceReportDataRepository.kapaliKasaAkilliValue
                              ? 1
                              : 0,
                      "kapaliKasaKlasikValue":
                          _serviceReportDataRepository.kapaliKasaKlasikValue
                              ? 1
                              : 0,
                      "aritmaliSebilFotoselValue":
                          _serviceReportDataRepository.aritmaliSebilFotoselValue
                              ? 1
                              : 0,
                      "anaTesisatYumusatmaZamanAyariValue":
                          _serviceReportDataRepository
                                  .anaTesisatYumusatmaZamanAyariValue
                              ? 1
                              : 0,
                      "anaTesisatYumusatmaSizdirmazlikValue":
                          _serviceReportDataRepository
                                  .anaTesisatYumusatmaSizdirmazlikValue
                              ? 1
                              : 0,
                      "anaTesisatYumusatmaCikisSuyuValue":
                          _serviceReportDataRepository
                                  .anaTesisatYumusatmaCikisSuyuValue
                              ? 1
                              : 0,
                      "anaTesisatYumusatmaTuzSeviyesiValue":
                          _serviceReportDataRepository
                                  .anaTesisatYumusatmaTuzSeviyesiValue
                              ? 1
                              : 0,
                      "anaTesisatYumusatmaRecineValue":
                          _serviceReportDataRepository
                                  .anaTesisatYumusatmaRecineValue
                              ? 1
                              : 0,
                      "anaTesisatKumValue":
                          _serviceReportDataRepository.anaTesisatKumValue
                              ? 1
                              : 0,
                      "anaTesisatKumZamanAyariValue":
                          _serviceReportDataRepository
                                  .anaTesisatKumZamanAyariValue
                              ? 1
                              : 0,
                      "anaTesisatKumSizdirmazlikValue":
                          _serviceReportDataRepository
                                  .anaTesisatKumSizdirmazlikValue
                              ? 1
                              : 0,
                      "anaTesisatKumTersYikamaValue":
                          _serviceReportDataRepository
                                  .anaTesisatKumTersYikamaValue
                              ? 1
                              : 0,
                      "anaTesisatKumMineralValue":
                          _serviceReportDataRepository.anaTesisatKumMineralValue
                              ? 1
                              : 0,
                      "anaTesisatKarbonValue":
                          _serviceReportDataRepository.anaTesisatKarbonValue
                              ? 1
                              : 0,
                      "anaTesisatKarbonZamanAyariValue":
                          _serviceReportDataRepository
                                  .anaTesisatKarbonZamanAyariValue
                              ? 1
                              : 0,
                      "anaTesisatKarbonSizdirmazlikValue":
                          _serviceReportDataRepository
                                  .anaTesisatKarbonSizdirmazlikValue
                              ? 1
                              : 0,
                      "anaTesisatKarbonTersYikamaValue":
                          _serviceReportDataRepository
                                  .anaTesisatKarbonTersYikamaValue
                              ? 1
                              : 0,
                      "anaTesisatKarbonKarbonMineraliValue":
                          _serviceReportDataRepository
                                  .anaTesisatKarbonKarbonMineraliValue
                              ? 1
                              : 0,
                      "anaTesisatFiltrelerValue":
                          _serviceReportDataRepository.anaTesisatFiltrelerValue
                              ? 1
                              : 0,
                      "anaTesisatFiltrelerTemizlendiValue":
                          _serviceReportDataRepository
                                  .anaTesisatFiltrelerTemizlendiValue
                              ? 1
                              : 0,
                      "anaTesisatFiltrelerDegistirildiValue":
                          _serviceReportDataRepository
                                  .anaTesisatFiltrelerDegistirildiValue
                              ? 1
                              : 0,
                      "anaTesisatFiltrelerGeriYikamaYapildiValue":
                          _serviceReportDataRepository
                                  .anaTesisatFiltrelerGeriYikamaYapildiValue
                              ? 1
                              : 0,
                    },
                  ),
                );
                print(_response.body);
                if (_response.statusCode == 200) {
                  for (var i = 0;
                      i < _serviceReportDataRepository.spareParts.length;
                      i++) {
                    final _sparePartResponse =
                        await PostApi.addServiceReportSpareParts(
                      map: {
                        "serviceReportId": json.decode(_response.body)["id"],
                        "sparePartId":
                            _serviceReportDataRepository.spareParts[i].id,
                        "count": int.parse(
                            _serviceReportDataRepository.counts[i].text),
                      },
                    );
                    if (_sparePartResponse is bool) {
                      final _putResponse = await PutApi.putSparePart(
                        count: _serviceReportDataRepository
                                .spareParts[i].count -
                            int.parse(
                                _serviceReportDataRepository.counts[i].text),
                        id: _serviceReportDataRepository.spareParts[i].id
                            .toString(),
                      );
                      print("$_putResponse");
                    }
                  }

                  final reference = FirebaseStorage.instance
                      .ref()
                      .child("${DateTime.now()}.pdf");
                  final uploadTask =
                      reference.putData(widget.pdf.readAsBytesSync());
                  String url = await (await uploadTask.whenComplete(
                    () {
                      print("completed");
                    },
                  ))
                      .ref
                      .getDownloadURL();
                  print("url: $url");

                  final _responsePutService = await PutApi.putServiceReport(
                    pdfUrl: url,
                    id: json.decode(_response.body)["id"].toString(),
                  );
                  if (_responsePutService is bool && _responsePutService) {
                    print("_responsePutService: $_responsePutService");
                  } else {
                    print("_responsePutService: $_responsePutService");
                  }

                  Provider.of<SignProvider>(context, listen: false)
                      .customerSign = null;
                  Provider.of<SignProvider>(context, listen: false).workerSign =
                      null;
                  Provider.of<ChooseSparePartProvider>(context, listen: false)
                      .clear();
                  BlocProvider.of<ServiceReportBloc>(context)
                      .add(ClearServiceReportListEvent());
                  BlocProvider.of<SparePartListBloc>(context)
                      .add(ClearSparePartListEvent());
                  Navigator.pop(context);
                  MyFlushbarHelper(context: context).showSuccessFlushbar(
                      title: "Başarılı",
                      message: "Servis raporu başarıyla eklendi");
                } else {
                  MyFlushbarHelper(context: context).showErrorFlushbar(
                      title: "Başarısız",
                      message:
                          "Servis raporu ekleme başarısız: ${jsonDecode(_response.body)["message"]}");
                  return jsonDecode(_response.body)["message"];
                }
              } on Exception catch (e) {
                MyFlushbarHelper(context: context).showErrorFlushbar(
                    title: "Başarısız",
                    message: "Servis raporu ekleme başarısız: $e");
                print(e);
                return null;
              } finally {
                EralpHelper.stopProgress();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PDF.file(
              widget.pdf,
              placeHolder: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyRaisedButton(
                  onPressed: () async {
                    final bool _isPush = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrawWorkerPage(),
                      ),
                    );
                    if (_isPush is bool && _isPush) {
                      CreateServiceReportPdfHelper
                          _creatServiceReportPdfHelper =
                          CreateServiceReportPdfHelper();
                      final _myPdf = await _creatServiceReportPdfHelper.getPdf(
                        context: context,
                        customerSign:
                            Provider.of<SignProvider>(context, listen: false)
                                .customerSign,
                        workerSign:
                            Provider.of<SignProvider>(context, listen: false)
                                .workerSign,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowPdfPage(pdf: _myPdf),
                        ),
                      );
                    }
                  },
                  buttonText:
                      Provider.of<SignProvider>(context).workerSign != null
                          ? "Personel\n imza değiştir"
                          : "Personel imzala",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyRaisedButton(
                  onPressed: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => DrawWorkerPage(),
                    //   ),
                    // );
                    final bool _isPush = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrawCustomerPage(),
                      ),
                    );
                    if (_isPush is bool && _isPush) {
                      CreateServiceReportPdfHelper
                          _creatServiceReportPdfHelper =
                          CreateServiceReportPdfHelper();
                      final _myPdf = await _creatServiceReportPdfHelper.getPdf(
                        context: context,
                        customerSign:
                            Provider.of<SignProvider>(context, listen: false)
                                .customerSign,
                        workerSign:
                            Provider.of<SignProvider>(context, listen: false)
                                .workerSign,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowPdfPage(pdf: _myPdf),
                        ),
                      );
                    }
                  },
                  buttonText:
                      Provider.of<SignProvider>(context).customerSign != null
                          ? "Müşteri\n imza değiştir"
                          : "Müşteri imzala",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
