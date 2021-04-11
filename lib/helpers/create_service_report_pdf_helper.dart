import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets/font.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/service_report/service_report_data_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

ServiceReportDataRepository _serviceReportDataRepository =
    locator<ServiceReportDataRepository>();
AuthRepository _authRepository = locator<AuthRepository>();

class CreateServiceReportPdfHelper {
  Font myFont;
  Font myExtraBoldFont;

  Future<File> getPdf({
    @required BuildContext context,
    Uint8List customerSign,
    Uint8List workerSign,
  }) async {
    final fontDataMyFont = await rootBundle.load("assets/mont.ttf");
    Uint8List myFontUint8List = fontDataMyFont.buffer.asUint8List(
        fontDataMyFont.offsetInBytes, fontDataMyFont.lengthInBytes);
    myFont = pw.Font.ttf(myFontUint8List.buffer.asByteData());
    final extraBoldFontData = await rootBundle.load("assets/montextrabold.ttf");
    Uint8List extraBoldFont = extraBoldFontData.buffer.asUint8List(
        extraBoldFontData.offsetInBytes, extraBoldFontData.lengthInBytes);
    myExtraBoldFont = pw.Font.ttf(extraBoldFont.buffer.asByteData());

    final fontData = await rootBundle.load("assets/mont.ttf");
    Uint8List audioUint8List = fontData.buffer
        .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
    final ttf = pw.Font.ttf(audioUint8List.buffer.asByteData());

    final pdf = pw.Document();

    final byteData = await rootBundle.load('assets/images/logo.png');

    Uint8List imageUint8List = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

    final image = pw.MemoryImage(
      imageUint8List,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image.provider(image, width: 150, height: 75),
                  pw.Text(
                    "${DateHelper.getStringDateTR(DateTime.now())}",
                    style: pw.TextStyle(
                      font: ttf,
                    ),
                  ),
                ],
              ),
              pw.Center(
                child: getText(
                  text: "SERVİS RAPORU",
                  isBold: true,
                  // wordSpacing: 1.5,
                  // letterSpacing: 1,
                  wordSpacing: 7,
                  letterSpacing: 4,
                ),
              ),
              pw.Divider(),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Müşteri adı:",
                          value:
                              " ${_serviceReportDataRepository.sale.companyName}",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Müşteri tipi:",
                          value:
                              " ${_serviceReportDataRepository.raporValue == 0 ? "Kurumsal" : "Bireysel"}",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Müşteri telefon:",
                          value:
                              " ${_serviceReportDataRepository.sale.companyPhone}",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Personel:",
                          value: " ${_authRepository.apiUser.data.fullName}",
                        ),
                        // pw.SizedBox(height: 8),
                        // getRowedText(
                        //   text: "Adres:",
                        //   value: " .................................................",
                        // ),
                        // pw.SizedBox(height: 8),
                        // getRowedText(
                        //   text: "E-mail:",
                        //   value: " ${_authRepository.apiUser.data}",
                        // ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Marka:",
                          value:
                              " ${_serviceReportDataRepository.sale.productName}",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Model:",
                          value:
                              " ${_serviceReportDataRepository.sale.productModel}",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Servis hizmeti:",
                          value:
                              " ${_serviceReportDataRepository.servisYeriServisteValue && _serviceReportDataRepository.servisYeriYerindeValue ? "Serviste ve Yerinde" : _serviceReportDataRepository.servisYeriServisteValue ? "Serviste" : _serviceReportDataRepository.servisYeriYerindeValue ? "Yerinde" : ""}",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Tip: ",
                          value: _serviceReportDataRepository.raporValue == 0
                              ? _serviceReportDataRepository.kurumsalValue == 0
                                  ? "Endüstriyel"
                                  : _serviceReportDataRepository
                                              .kurumsalValue ==
                                          1
                                      ? "Kobi"
                                      : "Toplu Konut"
                              : _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0
                                  ? "Ana tesisat girişi"
                                  : "İçme suyu sistemleri",
                          // " ${_serviceReportDataRepository.servisYeriServisteValue ? "Serviste" : _serviceReportDataRepository.servisYeriYerindeValue ? "Yerinde" : "............"}",
                        ),
                        pw.SizedBox(height: 8),
                        _serviceReportDataRepository.raporValue == 1 &&
                                _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    1
                            ? getRowedText(
                                text: "İçme Suyu Sistemleri Tipi: ",
                                value: _serviceReportDataRepository
                                            .bireyselValue ==
                                        0
                                    ? "Set üstü"
                                    : _serviceReportDataRepository
                                                .bireyselValue ==
                                            1
                                        ? "Arıtmalı sebil"
                                        : "Tezgah altı",
                              )
                            : pw.Container(),
                        _serviceReportDataRepository.raporValue == 1 &&
                                _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    1
                            ? pw.SizedBox(height: 8)
                            : pw.Container(),
                        _serviceReportDataRepository.raporValue == 1 &&
                                _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    1 &&
                                _serviceReportDataRepository.bireyselValue == 0
                            ? getRowedText(
                                text: "Pompa: ",
                                value: _serviceReportDataRepository
                                        .setUstuPompaValue
                                    ? "Var"
                                    : "Yok",
                              )
                            : pw.Container(),
                        _serviceReportDataRepository.raporValue == 1 &&
                                _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    1 &&
                                _serviceReportDataRepository.bireyselValue == 0
                            ? pw.SizedBox(height: 8)
                            : pw.Container(),
                        _serviceReportDataRepository.raporValue == 1 &&
                                _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    1 &&
                                _serviceReportDataRepository.bireyselValue == 1
                            ? getRowedText(
                                text: "Arıtmalı Sebil: ",
                                value: _serviceReportDataRepository
                                        .aritmaliSebilFotoselValue
                                    ? "Var"
                                    : "Yok",
                              )
                            : pw.Container(),
                        _serviceReportDataRepository.raporValue == 1 &&
                                _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    1 &&
                                _serviceReportDataRepository.bireyselValue == 1
                            ? pw.SizedBox(height: 8)
                            : pw.Container(),

                        _serviceReportDataRepository.raporValue == 1 &&
                                _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    1 &&
                                _serviceReportDataRepository.bireyselValue == 2
                            ? getRowedText(
                                text: "Tezgah Altı Kasa Tipi: ",
                                value: _serviceReportDataRepository
                                            .tezgahAltiKasaValue ==
                                        0
                                    ? "Açık"
                                    : "Kapalı (${_serviceReportDataRepository.tezgahAltiKapaliKasaValue == 0 ? "Akıllı kasa" : "Klasik kasa"})",
                              )
                            : pw.Container(),
                        _serviceReportDataRepository.raporValue == 1 &&
                                _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    1 &&
                                _serviceReportDataRepository.bireyselValue == 2
                            ? pw.SizedBox(height: 8)
                            : pw.Container(),
                      ],
                    ),
                  ),
                  // pw.SizedBox(width: 24),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: getListViewItems(),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 16),
              pw.Divider(),
              pw.SizedBox(height: 16),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      getText(
                        text: _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    0 &&
                                _serviceReportDataRepository.raporValue == 1
                            ? "Mekanik Filtreler"
                            : "Filtreler",
                        isBold: true,
                        // textDecoration: pw.TextDecoration.underline,
                      ),
                      pw.Container(
                        width: 110,
                        height: 1,
                        color: PdfColors.grey,
                      ),
                      pw.SizedBox(
                        height: 8,
                      ),
                      getCheckbox(
                          "Temizlendi",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatFiltrelerTemizlendiValue
                              : _serviceReportDataRepository
                                  .filtrelerTemizlendiValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Değiştirildi",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatFiltrelerDegistirildiValue
                              : _serviceReportDataRepository
                                  .filtrelerDegistirildiValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Geri yıkama yapıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatFiltrelerGeriYikamaYapildiValue
                              : _serviceReportDataRepository
                                  .filtrelerGeriYikamaYapildiValue),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: "Su Yumuşatma",
                        isBold: true,
                        // textDecoration: pw.TextDecoration.underline,
                      ),
                      pw.Container(
                        width: 110,
                        height: 1,
                        color: PdfColors.grey,
                      ),
                      pw.SizedBox(
                        height: 8,
                      ),
                      getCheckbox(
                          "Zaman/Debi ayarı yapıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatYumusatmaZamanAyariValue
                              : _serviceReportDataRepository
                                  .yumusatmaZamanAyariValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Sızdırmazlık kontrolü yapıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatYumusatmaSizdirmazlikValue
                              : _serviceReportDataRepository
                                  .yumusatmaSizdirmazlikValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Çıkış suyu sertlik kontrolü yapıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatYumusatmaCikisSuyuValue
                              : _serviceReportDataRepository
                                  .yumusatmaCikisSuyuValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Tuz seviyesi kontrol edildi",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatYumusatmaTuzSeviyesiValue
                              : _serviceReportDataRepository
                                  .yumusatmaTuzSeviyesiValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Reçine minerali değiştirildi",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatYumusatmaRecineValue
                              : _serviceReportDataRepository
                                  .yumusatmaRecineValue),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    0 &&
                                _serviceReportDataRepository.raporValue == 1
                            ? "Otomatik Karbon"
                            : "Aktif Karbon",
                        isBold: true,
                        // textDecoration: pw.TextDecoration.underline,
                      ),
                      pw.Container(
                        width: 110,
                        height: 1,
                        color: PdfColors.grey,
                      ),
                      pw.SizedBox(
                        height: 8,
                      ),
                      getCheckbox(
                          "Zaman ayarı yapıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatKarbonZamanAyariValue
                              : _serviceReportDataRepository
                                  .karbonZamanAyariValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Sızdırmazlık kontrolü yapıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatKarbonSizdirmazlikValue
                              : _serviceReportDataRepository
                                  .karbonSizdirmazlikValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Ters yıkama yaptırıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatKarbonTersYikamaValue
                              : _serviceReportDataRepository
                                  .karbonTersYikamaValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Aktif karbon minerali değiştirildi",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatKarbonKarbonMineraliValue
                              : _serviceReportDataRepository
                                  .karbonKarbonMineraliValue),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: _serviceReportDataRepository
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    0 &&
                                _serviceReportDataRepository.raporValue == 1
                            ? "Otomatik Kum Filtresi"
                            : "Kum Filtresi",
                        isBold: true,
                        // textDecoration: pw.TextDecoration.underline,
                      ),
                      pw.Container(
                        width: 110,
                        height: 1,
                        color: PdfColors.grey,
                      ),
                      pw.SizedBox(
                        height: 8,
                      ),
                      getCheckbox(
                          "Zaman ayarı yapıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatKumZamanAyariValue
                              : _serviceReportDataRepository
                                  .kumZamanAyariValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Sızdırmazlık kontrolü yapıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatKumSizdirmazlikValue
                              : _serviceReportDataRepository
                                  .kumSizdirmazlikValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Ters yıkama yaptırıldı",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatKumTersYikamaValue
                              : _serviceReportDataRepository
                                  .kumTersYikamaValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Mineral değiştirildi",
                          _serviceReportDataRepository
                                          .anaTesisatVeyaIcmeSuyuValue ==
                                      0 &&
                                  _serviceReportDataRepository.raporValue == 1
                              ? _serviceReportDataRepository
                                  .anaTesisatKumMineralValue
                              : _serviceReportDataRepository.kumMineralValue),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 32),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      getText(
                        text: "Klorlama",
                        isBold: true,
                        // textDecoration: pw.TextDecoration.underline,
                      ),
                      pw.Container(
                        width: 110,
                        height: 1,
                        color: PdfColors.grey,
                      ),
                      pw.SizedBox(
                        height: 8,
                      ),
                      getCheckbox("Çekvalfler temizlendi",
                          _serviceReportDataRepository.klorCekvalflerValue),
                      pw.SizedBox(height: 8),
                      getCheckbox("Klor ölçümü yapıldı",
                          _serviceReportDataRepository.klorOlcumValue),
                      pw.SizedBox(height: 8),
                      getCheckbox("Klor ilave edildi",
                          _serviceReportDataRepository.klorIlaveValue),
                      pw.SizedBox(height: 8),
                      getCheckbox("Sızdırmazlık kontrolü yapıldı",
                          _serviceReportDataRepository.klorSizdirmazlikValue),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: "Endüstriyel RO",
                        isBold: true,
                        // textDecoration: pw.TextDecoration.underline,
                      ),
                      pw.Container(
                        width: 110,
                        height: 1,
                        color: PdfColors.grey,
                      ),
                      pw.SizedBox(
                        height: 8,
                      ),
                      getCheckbox(
                          "Öngüvenlik filtreleri değiştirildi",
                          _serviceReportDataRepository
                              .endustriyelROGuvenlikValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Membran değiştirildi",
                          _serviceReportDataRepository
                              .endustriyelROMembranValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Kimyasal yıkama yapıldı",
                          _serviceReportDataRepository
                              .endustriyelROKimyasalValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "Sızdırmazlık kontrolü yapıldı",
                          _serviceReportDataRepository
                              .endustriyelROSizdirmazlikValue),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: "Ultraviole",
                        isBold: true,
                        // textDecoration: pw.TextDecoration.underline,
                      ),
                      pw.Container(
                        width: 110,
                        height: 1,
                        color: PdfColors.grey,
                      ),
                      pw.SizedBox(
                        height: 8,
                      ),
                      getCheckbox("UV lamba kontrol edildi",
                          _serviceReportDataRepository.uvLambaKontrolValue),
                      pw.SizedBox(height: 8),
                      getCheckbox("Sızdırmazlık kontrolü yapıldı",
                          _serviceReportDataRepository.uvSizdirmazlikValue),
                      pw.SizedBox(height: 8),
                      getCheckbox("Voltaj regülatörü var",
                          _serviceReportDataRepository.uvVoltajRegulatoruValue),
                      pw.SizedBox(height: 8),
                      getCheckbox(
                          "UV lamba değiştirildi",
                          _serviceReportDataRepository
                              .uvLambaDegistirildiValue),
                      pw.SizedBox(height: 8),
                      getCheckbox("UV quvarts kılıf değiştirildi",
                          _serviceReportDataRepository.uvQuvartsKilifValue),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: "Hizmet Cinsi",
                        isBold: true,
                      ),
                      pw.Container(
                        width: 110,
                        height: 1,
                        color: PdfColors.grey,
                      ),
                      pw.SizedBox(
                        height: 8,
                      ),
                      getCheckbox("Garanti",
                          _serviceReportDataRepository.hizmetCinsiGarantiValue),
                      pw.SizedBox(height: 8),
                      getCheckbox("İlk çalıştırma",
                          _serviceReportDataRepository.hizmetCinsiIlkValue),
                      pw.SizedBox(height: 8),
                      getCheckbox("Normal",
                          _serviceReportDataRepository.hizmetCinsiNormalValue),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 32),
              pw.Divider(),
              pw.SizedBox(height: 32),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      getRowedText(
                        text: "Servis yetkilisi:",
                        value: " ${_authRepository.apiUser.data.fullName}",
                      ),
                      getRowedSignText(
                        text: "İmza: ",
                        value: workerSign == null
                            ? null
                            : pw.Image.provider(
                                pw.MemoryImage(workerSign),
                                width: 50,
                                height: 50,
                              ),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      getRowedText(
                        text: "Müşteri:",
                        value:
                            " ${_serviceReportDataRepository.sale.companyName}",
                      ),
                      getRowedSignText(
                        text: "İmza: ",
                        value: customerSign == null
                            ? null
                            : pw.Image.provider(
                                pw.MemoryImage(customerSign),
                                width: 50,
                                height: 50,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ); // Center
        },
      ),
    );
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${DateTime.now()}.pdf');

    File _myPdf = await file.writeAsBytes(pdf.save());
    // OpenFile.open(_myPdf.path);
    return _myPdf;
    // NavigatorHelper(context).goTo(
    //   ShowPdfPage(pdf: _myPdf),
    // );
  }

  pw.Text getText({
    String text,
    bool isBold,
    double letterSpacing = 0,
    double wordSpacing = 1,
    pw.TextDecoration textDecoration = pw.TextDecoration.none,
    double fontSize = 10,
    pw.TextAlign textAlign = pw.TextAlign.center,
  }) {
    return pw.Text(
      "$text",
      style: pw.TextStyle(
        font: myFont,
        fontWeight: isBold != null ? pw.FontWeight.bold : pw.FontWeight.normal,
        fontBold: myExtraBoldFont,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: textDecoration,
        fontSize: fontSize,
      ),
    );
  }

  pw.Row getRowedText({
    String text,
    String value,
    bool isBold,
    double letterSpacing = 0,
    double wordSpacing = 1,
    pw.TextDecoration textDecoration = pw.TextDecoration.none,
    double fontSize = 10,
    pw.TextAlign textAlign = pw.TextAlign.center,
  }) {
    return pw.Row(
      children: [
        pw.Text(
          "$text",
          style: pw.TextStyle(
            font: myFont,
            fontWeight: pw.FontWeight.bold,
            fontBold: myExtraBoldFont,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            decoration: textDecoration,
            fontSize: fontSize,
          ),
        ),
        pw.Text(
          "$value",
          style: pw.TextStyle(
            font: myFont,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            decoration: textDecoration,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  pw.Row getRowedSignText({
    String text,
    pw.Image value,
    bool isBold,
    double letterSpacing = 0,
    double wordSpacing = 1,
    pw.TextDecoration textDecoration = pw.TextDecoration.none,
    double fontSize = 10,
    pw.TextAlign textAlign = pw.TextAlign.center,
  }) {
    return pw.Row(
      children: [
        pw.Text(
          "$text",
          style: pw.TextStyle(
            font: myFont,
            fontWeight: pw.FontWeight.bold,
            fontBold: myExtraBoldFont,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            decoration: textDecoration,
            fontSize: fontSize,
          ),
        ),
        value == null ? pw.Text("") : value,
      ],
    );
  }

  pw.Row getRowedRightText({
    String text,
    String value,
    bool isBold,
    double letterSpacing = 0,
    double wordSpacing = 1,
    pw.TextDecoration textDecoration = pw.TextDecoration.none,
    double fontSize = 10,
    pw.TextAlign textAlign = pw.TextAlign.center,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Text(
          "$text",
          style: pw.TextStyle(
            font: myFont,
            fontWeight: pw.FontWeight.bold,
            fontBold: myExtraBoldFont,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            decoration: textDecoration,
            fontSize: fontSize,
          ),
        ),
        pw.Text(
          "$value",
          style: pw.TextStyle(
            font: myFont,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            decoration: textDecoration,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  List<pw.Column> getListViewItems() {
    final List<pw.Column> _myWidgets = [];

    for (var i = 0; i < _serviceReportDataRepository.spareParts.length; i++) {
      _myWidgets.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.SizedBox(height: 8),
            pw.Container(
              child: getRowedRightText(
                text: "Yedek parça:",
                value:
                    " ${_serviceReportDataRepository.spareParts[i].name} - ${_serviceReportDataRepository.counts[i].text} adet",
              ),
            ),
          ],
        ),
      );
    }
    return _myWidgets;
  }

  pw.Container getCheckbox(String key, bool value) {
    return pw.Container(
      width: 110,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          getText(text: "$key", fontSize: 6),
          pw.Container(
            child: pwCheckBox(value),
          ),
        ],
      ),
    );
  }

  pw.CustomPaint pwCheckBox(bool checked) {
    if (!checked) {
      return pw.CustomPaint(
        size: const PdfPoint(10, 10),
        painter: (PdfGraphics canvas, PdfPoint size) {
          canvas
            ..moveTo(0, 0)
            ..lineTo(0, size.y)
            ..lineTo(size.x, size.y)
            ..lineTo(size.x, 0)
            ..lineTo(0, 0)
            ..setColor(PdfColors.black)
            ..setLineWidth(1)
            ..strokePath();
        },
      );
    }
    return pw.CustomPaint(
      size: const PdfPoint(10, 10),
      painter: (PdfGraphics canvas, PdfPoint size) {
        canvas
          ..moveTo(0, 0)
          ..lineTo(0, size.y)
          ..lineTo(size.x, size.y)
          ..lineTo(size.x, 0)
          ..lineTo(0, 0)
          ..moveTo(size.x / 5, size.y / 2)
          ..lineTo(size.x / 3, size.y / 5)
          ..lineTo(size.x - size.x / 6, size.y - size.y / 6)
          ..setColor(PdfColors.black)
          ..setLineWidth(1)
          ..strokePath();
      },
    );
  }
}
