import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:teknoloji_kimya_servis/models/api_service_report.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

class ServiceReportDetailPage extends StatefulWidget {
  final ApiServiceReportData serviceReport;

  const ServiceReportDetailPage({Key key, @required this.serviceReport})
      : super(key: key);
  @override
  _ServiceReportDetailPageState createState() =>
      _ServiceReportDetailPageState();
}

class _ServiceReportDetailPageState extends State<ServiceReportDetailPage> {
  AuthRepository _authRepository = locator<AuthRepository>();
  bool showPdf = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: showPdf ? Icon(Icons.text_format) : Icon(Icons.picture_as_pdf),
        onPressed: () {
          showPdf = !showPdf;
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: Text('Servis Raporu Detay'),
      ),
      body: showPdf
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.85,
                    width: MediaQuery.of(context).size.width,
                    child: SfPdfViewer.network(widget.serviceReport.pdfUrl),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildRow(
                        text: "M????teri ad??:",
                        value: " ${widget.serviceReport.companyName}",
                      ),
                      Divider(),
                      buildRow(
                        text: "M????teri tipi:",
                        value:
                            " ${widget.serviceReport.raporValue == 0 ? "Kurumsal" : "Bireysel"}",
                      ),
                      Divider(),

                      buildRow(
                        text: "M????teri telefon:",
                        value: " ${widget.serviceReport.companyPhone}",
                      ),
                      Divider(),

                      buildRow(
                        text: "Personel:",
                        value: " ${_authRepository.apiUser.data.fullName}",
                      ),
                      Divider(),

                      // SizedBox(height: 8),
                      // buildRow(
                      //   text: "Adres:",
                      //   value: " .................................................",
                      // ),
                      // SizedBox(height: 8),
                      // buildRow(
                      //   text: "E-mail:",
                      //   value: " ${_authRepository.apiUser.data}",
                      // ),
                      buildRow(
                        text: "Marka:",
                        value: " ${widget.serviceReport.productName}",
                      ),
                      Divider(),

                      buildRow(
                        text: "Model:",
                        value: " ${widget.serviceReport.productModel}",
                      ),
                      Divider(),

                      buildRow(
                        text: "Servis hizmeti:",
                        value:
                            " ${widget.serviceReport.servisYeriServisteValue == 1 && widget.serviceReport.servisYeriYerindeValue == 1 ? "Serviste ve Yerinde" : widget.serviceReport.servisYeriServisteValue == 1 ? "Serviste" : widget.serviceReport.servisYeriYerindeValue == 1 ? "Yerinde" : ""}",
                      ),
                      Divider(),

                      buildRow(
                        text: "Tip: ",
                        value: widget.serviceReport.raporValue == 0
                            ? widget.serviceReport.kurumsalValue == 0
                                ? "End??striyel"
                                : widget.serviceReport.kurumsalValue == 1
                                    ? "Kobi"
                                    : widget.serviceReport.kurumsalValue == 2
                                        ? "Toplu Konut"
                                        : "????me"
                            : widget.serviceReport
                                        .anaTesisatVeyaIcmeSuyuValue ==
                                    0
                                ? "Ana tesisat giri??i"
                                : "????me suyu sistemleri",
                        // " ${widget.serviceReport.servisYeriServisteValue ? "Serviste" : widget.serviceReport.servisYeriYerindeValue ? "Yerinde" : "............"}",
                      ),
                      widget.serviceReport.raporValue == 1 &&
                              widget.serviceReport
                                      .anaTesisatVeyaIcmeSuyuValue ==
                                  1
                          ? buildRow(
                              text: "????me Suyu Sistemleri Tipi: ",
                              value: widget.serviceReport.bireyselValue == 0
                                  ? "Set ??st??"
                                  : widget.serviceReport.bireyselValue == 1
                                      ? "Ar??tmal?? sebil"
                                      : "Tezgah alt??",
                            )
                          : Container(),
                      widget.serviceReport.raporValue == 1 &&
                              widget.serviceReport
                                      .anaTesisatVeyaIcmeSuyuValue ==
                                  1
                          ? SizedBox(height: 8)
                          : Container(),
                      widget.serviceReport.raporValue == 1 &&
                              widget.serviceReport
                                      .anaTesisatVeyaIcmeSuyuValue ==
                                  1 &&
                              widget.serviceReport.bireyselValue == 0
                          ? buildRow(
                              text: "Pompa: ",
                              value: widget.serviceReport.setUstuPompaValue == 1
                                  ? "Var"
                                  : "Yok",
                            )
                          : Container(),
                      widget.serviceReport.raporValue == 1 &&
                              widget.serviceReport
                                      .anaTesisatVeyaIcmeSuyuValue ==
                                  1 &&
                              widget.serviceReport.bireyselValue == 0
                          ? SizedBox(height: 8)
                          : Container(),
                      widget.serviceReport.raporValue == 1 &&
                              widget.serviceReport
                                      .anaTesisatVeyaIcmeSuyuValue ==
                                  1 &&
                              widget.serviceReport.bireyselValue == 1
                          ? buildRow(
                              text: "Ar??tmal?? Sebil: ",
                              value: widget.serviceReport
                                          .aritmaliSebilFotoselValue ==
                                      1
                                  ? "Var"
                                  : "Yok",
                            )
                          : Container(),
                      widget.serviceReport.raporValue == 1 &&
                              widget.serviceReport
                                      .anaTesisatVeyaIcmeSuyuValue ==
                                  1 &&
                              widget.serviceReport.bireyselValue == 1
                          ? SizedBox(height: 8)
                          : Container(),

                      widget.serviceReport.raporValue == 1 &&
                              widget.serviceReport
                                      .anaTesisatVeyaIcmeSuyuValue ==
                                  1 &&
                              widget.serviceReport.bireyselValue == 2
                          ? buildRow(
                              text: "Tezgah Alt?? Kasa Tipi: ",
                              value: widget.serviceReport.tezgahAltiKasaValue ==
                                      0
                                  ? "A????k"
                                  : "Kapal?? (${widget.serviceReport.tezgahAltiKapaliKasaValue == 0 ? "Ak??ll?? kasa" : "Klasik kasa"})",
                            )
                          : Container(),
                      widget.serviceReport.raporValue == 1 &&
                              widget.serviceReport
                                      .anaTesisatVeyaIcmeSuyuValue ==
                                  1 &&
                              widget.serviceReport.bireyselValue == 2
                          ? SizedBox(height: 8)
                          : Container(),
                    ],
                  ),
                  Divider(),
                  widget.serviceReport.filtrelerValue == 1 ||
                          widget.serviceReport.anaTesisatFiltrelerValue == 1
                      ? Column(
                          children: [
                            Text(
                              widget.serviceReport
                                              .anaTesisatVeyaIcmeSuyuValue ==
                                          0 &&
                                      widget.serviceReport.raporValue == 1
                                  ? "Mekanik Filtreler"
                                  : "Filtreler",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.serviceReport.filtrelerTemizlendiValue ==
                                        1 ||
                                    widget.serviceReport
                                            .anaTesisatFiltrelerTemizlendiValue ==
                                        1
                                ? Text("Temizlendi")
                                : Container(),
                            widget.serviceReport.filtrelerDegistirildiValue ==
                                        1 ||
                                    widget.serviceReport
                                            .anaTesisatFiltrelerDegistirildiValue ==
                                        1
                                ? Text("De??i??tirildi")
                                : Container(),
                            widget.serviceReport
                                            .filtrelerGeriYikamaYapildiValue ==
                                        1 ||
                                    widget.serviceReport
                                            .anaTesisatFiltrelerGeriYikamaYapildiValue ==
                                        1
                                ? Text("Geri y??kama yap??ld??")
                                : Container(),
                            Divider(),
                          ],
                        )
                      : Container(),

                  widget.serviceReport.yumusatmaValue == 1 ||
                          widget.serviceReport.anaTesisatYumusatmaValue == 1
                      ? Column(
                          children: [
                            Text(
                              "Su Yumu??atma",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.serviceReport.yumusatmaZamanAyariValue ==
                                        1 ||
                                    widget.serviceReport
                                            .anaTesisatYumusatmaZamanAyariValue ==
                                        1
                                ? Text("Zaman/Debi ayar?? yap??ld??")
                                : Container(),
                            widget.serviceReport.yumusatmaSizdirmazlikValue ==
                                        1 ||
                                    widget.serviceReport
                                            .anaTesisatYumusatmaSizdirmazlikValue ==
                                        1
                                ? Text("S??zd??rmazl??k kontrol?? yap??ld??")
                                : Container(),
                            widget.serviceReport.yumusatmaCikisSuyuValue == 1 ||
                                    widget.serviceReport
                                            .anaTesisatYumusatmaCikisSuyuValue ==
                                        1
                                ? Text("????k???? suyu sertlik kontrol?? yap??ld??")
                                : Container(),
                            widget.serviceReport.yumusatmaTuzSeviyesiValue ==
                                        1 ||
                                    widget.serviceReport
                                            .anaTesisatYumusatmaTuzSeviyesiValue ==
                                        1
                                ? Text("Tuz seviyesi kontrol edildi")
                                : Container(),
                            widget.serviceReport.yumusatmaRecineValue == 1 ||
                                    widget.serviceReport
                                            .anaTesisatYumusatmaRecineValue ==
                                        1
                                ? Text("Re??ine minerali de??i??tirildi")
                                : Container(),
                            Divider(),
                          ],
                        )
                      : Container(),
                  widget.serviceReport.filtrelerValue == 1 ||
                          widget.serviceReport.anaTesisatFiltrelerValue == 1
                      ? Column(
                          children: [
                            Text(
                              widget.serviceReport
                                              .anaTesisatVeyaIcmeSuyuValue ==
                                          0 &&
                                      widget.serviceReport.raporValue == 1
                                  ? "Otomatik Kum Filtresi"
                                  : "Kum Filtresi",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.serviceReport.kumZamanAyariValue == 1 ||
                                    widget.serviceReport
                                            .anaTesisatKumZamanAyariValue ==
                                        1
                                ? Text("Zaman ayar?? yap??ld??")
                                : Container(),
                            widget.serviceReport.kumSizdirmazlikValue == 1 ||
                                    widget.serviceReport
                                            .anaTesisatKumSizdirmazlikValue ==
                                        1
                                ? Text("S??zd??rmazl??k kontrol?? yap??ld??")
                                : Container(),
                            widget.serviceReport.kumTersYikamaValue == 1 ||
                                    widget.serviceReport
                                            .anaTesisatKumTersYikamaValue ==
                                        1
                                ? Text("Ters y??kama yapt??r??ld??")
                                : Container(),
                            widget.serviceReport.kumMineralValue == 1 ||
                                    widget.serviceReport
                                            .anaTesisatKumMineralValue ==
                                        1
                                ? Text("Mineral de??i??tirildi")
                                : Container(),
                            Divider(),
                          ],
                        )
                      : Container(),
                  widget.serviceReport.karbonValue == 1 ||
                          widget.serviceReport.anaTesisatKarbonValue == 1
                      ? Column(
                          children: [
                            Text(
                              widget.serviceReport
                                              .anaTesisatVeyaIcmeSuyuValue ==
                                          0 &&
                                      widget.serviceReport.raporValue == 1
                                  ? "Otomatik Karbon"
                                  : "Aktif Karbon",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.serviceReport.karbonZamanAyariValue == 1 ||
                                    widget.serviceReport
                                            .anaTesisatKarbonZamanAyariValue ==
                                        1
                                ? Text("Zaman ayar?? yap??ld??")
                                : Container(),
                            widget.serviceReport.karbonSizdirmazlikValue == 1 ||
                                    widget.serviceReport
                                            .anaTesisatKarbonSizdirmazlikValue ==
                                        1
                                ? Text("S??zd??rmazl??k kontrol?? yap??ld??")
                                : Container(),
                            widget.serviceReport.karbonTersYikamaValue == 1 ||
                                    widget.serviceReport
                                            .anaTesisatKarbonTersYikamaValue ==
                                        1
                                ? Text("Ters y??kama yapt??r??ld??")
                                : Container(),
                            widget.serviceReport.karbonKarbonMineraliValue ==
                                        1 ||
                                    widget.serviceReport
                                            .anaTesisatKarbonKarbonMineraliValue ==
                                        1
                                ? Text("Mineral de??i??tirildi")
                                : Container(),
                            Divider(),
                          ],
                        )
                      : Container(),
                  widget.serviceReport.klorlamaValue == 1
                      ? Column(
                          children: [
                            Text(
                              "Aktif Karbon",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.serviceReport.klorCekvalflerValue == 1
                                ? Text("??ekvalfler temizlendi")
                                : Container(),
                            widget.serviceReport.klorOlcumValue == 1
                                ? Text("Klor ??l????m?? yap??ld??")
                                : Container(),
                            widget.serviceReport.klorIlaveValue == 1
                                ? Text("Klor ilave edildi")
                                : Container(),
                            widget.serviceReport.klorSizdirmazlikValue == 1
                                ? Text("S??zd??rmazl??k kontrol?? yap??ld??")
                                : Container(),
                            Divider(),
                          ],
                        )
                      : Container(),
                  widget.serviceReport.endustriyelRoValue == 1
                      ? Column(
                          children: [
                            Text(
                              "End??striyel RO",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.serviceReport.endustriyelRoGuvenlikValue == 1
                                ? Text("??ng??venlik filtreleri de??i??tirildi")
                                : Container(),
                            widget.serviceReport.endustriyelRoMembranValue == 1
                                ? Text("Membran de??i??tirildi")
                                : Container(),
                            widget.serviceReport.endustriyelRoKimyasalValue == 1
                                ? Text("Kimyasal y??kama yap??ld??")
                                : Container(),
                            widget.serviceReport
                                        .endustriyelRoSizdirmazlikValue ==
                                    1
                                ? Text("S??zd??rmazl??k kontrol?? yap??ld??")
                                : Container(),
                            Divider(),
                          ],
                        )
                      : Container(),
                  widget.serviceReport.ultravioleValue == 1
                      ? Column(
                          children: [
                            Text(
                              "Ultraviole",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.serviceReport.uvLambaKontrolValue == 1
                                ? Text("UV lamba kontrol edildi")
                                : Container(),
                            widget.serviceReport.uvSizdirmazlikValue == 1
                                ? Text("S??zd??rmazl??k kontrol?? yap??ld??")
                                : Container(),
                            widget.serviceReport.uvVoltajRegulatoruValue == 1
                                ? Text("Voltaj reg??lat??r?? var")
                                : Container(),
                            widget.serviceReport.uvLambaDegistirildiValue == 1
                                ? Text("UV lamba de??i??tirildi")
                                : Container(),
                            widget.serviceReport.uvQuvartsKilifValue == 1
                                ? Text("UV quvarts k??l??f de??i??tirildi")
                                : Container(),
                            Divider(),
                          ],
                        )
                      : Container(),
                  widget.serviceReport.hizmetCinsiValue == 1
                      ? Column(
                          children: [
                            Text(
                              "Hizmet Cinsi",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            widget.serviceReport.hizmetCinsiGarantiValue == 1
                                ? Text("Garanti")
                                : Container(),
                            widget.serviceReport.hizmetCinsiIlkValue == 1
                                ? Text("??lk ??al????t??rma")
                                : Container(),
                            widget.serviceReport.hizmetCinsiNormalValue == 1
                                ? Text("Normal")
                                : Container(),
                            Divider(),
                          ],
                        )
                      : Container(),
                  widget.serviceReport.description == null
                      ? Container()
                      : Column(
                          children: [
                            Text(
                              "A????klama",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${widget.serviceReport.description}"),
                          ],
                        ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         getText(
                  //           text: widget.serviceReport
                  //                           .anaTesisatVeyaIcmeSuyuValue ==
                  //                       0 &&
                  //                   widget.serviceReport.raporValue == 1
                  //               ? "Mekanik Filtreler"
                  //               : "Filtreler",
                  //           isBold: true,
                  //           // textDecoration: TextDecoration.underline,
                  //         ),
                  //         Divider(),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         getCheckbox(
                  //             "Temizlendi",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatFiltrelerTemizlendiValue
                  //                 : widget
                  //                     .serviceReport.filtrelerTemizlendiValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "De??i??tirildi",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatFiltrelerDegistirildiValue
                  //                 : widget
                  //                     .serviceReport.filtrelerDegistirildiValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Geri y??kama yap??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatFiltrelerGeriYikamaYapildiValue
                  //                 : widget.serviceReport
                  //                     .filtrelerGeriYikamaYapildiValue),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         getText(
                  //           text: "Su Yumu??atma",
                  //           isBold: true,
                  //           // textDecoration: TextDecoration.underline,
                  //         ),
                  //         Divider(),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         getCheckbox(
                  //             "Zaman/Debi ayar?? yap??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatYumusatmaZamanAyariValue
                  //                 : widget
                  //                     .serviceReport.yumusatmaZamanAyariValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "S??zd??rmazl??k kontrol?? yap??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatYumusatmaSizdirmazlikValue
                  //                 : widget
                  //                     .serviceReport.yumusatmaSizdirmazlikValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "????k???? suyu sertlik kontrol?? yap??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatYumusatmaCikisSuyuValue
                  //                 : widget.serviceReport.yumusatmaCikisSuyuValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Tuz seviyesi kontrol edildi",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatYumusatmaTuzSeviyesiValue
                  //                 : widget
                  //                     .serviceReport.yumusatmaTuzSeviyesiValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Re??ine minerali de??i??tirildi",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatYumusatmaRecineValue
                  //                 : widget.serviceReport.yumusatmaRecineValue),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         getText(
                  //           text: widget.serviceReport
                  //                       .anaTesisatVeyaIcmeSuyuValue ==
                  //                   0
                  //               ? "Otomatik Karbon"
                  //               : "Aktif Karbon",
                  //           isBold: true,
                  //           // textDecoration: TextDecoration.underline,
                  //         ),
                  //         Divider(),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         getCheckbox(
                  //             "Zaman ayar?? yap??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatKarbonZamanAyariValue
                  //                 : widget.serviceReport.karbonZamanAyariValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "S??zd??rmazl??k kontrol?? yap??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatKarbonSizdirmazlikValue
                  //                 : widget.serviceReport.karbonSizdirmazlikValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Ters y??kama yapt??r??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatKarbonTersYikamaValue
                  //                 : widget.serviceReport.karbonTersYikamaValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Aktif karbon minerali de??i??tirildi",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatKarbonKarbonMineraliValue
                  //                 : widget
                  //                     .serviceReport.karbonKarbonMineraliValue),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         getText(
                  //           text: widget.serviceReport
                  //                           .anaTesisatVeyaIcmeSuyuValue ==
                  //                       0 &&
                  //                   widget.serviceReport.raporValue == 1
                  //               ? "Otomatik Kum Filtresi"
                  //               : "Kum Filtresi",
                  //           isBold: true,
                  //           // textDecoration: TextDecoration.underline,
                  //         ),
                  //         Divider(),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         getCheckbox(
                  //             "Zaman ayar?? yap??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget
                  //                     .serviceReport.anaTesisatKumZamanAyariValue
                  //                 : widget.serviceReport.kumZamanAyariValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "S??zd??rmazl??k kontrol?? yap??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport
                  //                     .anaTesisatKumSizdirmazlikValue
                  //                 : widget.serviceReport.kumSizdirmazlikValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Ters y??kama yapt??r??ld??",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget
                  //                     .serviceReport.anaTesisatKumTersYikamaValue
                  //                 : widget.serviceReport.kumTersYikamaValue),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Mineral de??i??tirildi",
                  //             widget.serviceReport.anaTesisatVeyaIcmeSuyuValue ==
                  //                         0 &&
                  //                     widget.serviceReport.raporValue == 1
                  //                 ? widget.serviceReport.anaTesisatKumMineralValue
                  //                 : widget.serviceReport.kumMineralValue),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 32),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         getText(
                  //           text: "Klorlama",
                  //           isBold: true,
                  //           // textDecoration: TextDecoration.underline,
                  //         ),
                  //         Divider(),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         getCheckbox(
                  //             "??ekvalfler temizlendi",
                  //             widget.serviceReport.klorCekvalflerValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Klor ??l????m?? yap??ld??",
                  //             widget.serviceReport.klorOlcumValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Klor ilave edildi",
                  //             widget.serviceReport.klorIlaveValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "S??zd??rmazl??k kontrol?? yap??ld??",
                  //             widget.serviceReport.klorSizdirmazlikValue == 1
                  //                 ? true
                  //                 : false),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         getText(
                  //           text: "End??striyel RO",
                  //           isBold: true,
                  //           // textDecoration: TextDecoration.underline,
                  //         ),
                  //         Divider(),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         getCheckbox(
                  //             "??ng??venlik filtreleri de??i??tirildi",
                  //             widget.serviceReport.endustriyelRoGuvenlikValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Membran de??i??tirildi",
                  //             widget.serviceReport.endustriyelRoMembranValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Kimyasal y??kama yap??ld??",
                  //             widget.serviceReport.endustriyelRoKimyasalValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "S??zd??rmazl??k kontrol?? yap??ld??",
                  //             widget.serviceReport
                  //                         .endustriyelRoSizdirmazlikValue ==
                  //                     1
                  //                 ? true
                  //                 : false),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         getText(
                  //           text: "Ultraviole",
                  //           isBold: true,
                  //           // textDecoration: TextDecoration.underline,
                  //         ),
                  //         Divider(),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         getCheckbox(
                  //             "UV lamba kontrol edildi",
                  //             widget.serviceReport.uvLambaKontrolValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "S??zd??rmazl??k kontrol?? yap??ld??",
                  //             widget.serviceReport.uvSizdirmazlikValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Voltaj reg??lat??r?? var",
                  //             widget.serviceReport.uvVoltajRegulatoruValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "UV lamba de??i??tirildi",
                  //             widget.serviceReport.uvLambaDegistirildiValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "UV quvarts k??l??f de??i??tirildi",
                  //             widget.serviceReport.uvQuvartsKilifValue == 1
                  //                 ? true
                  //                 : false),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         getText(
                  //           text: "Hizmet Cinsi",
                  //           isBold: true,
                  //         ),
                  //         Divider(),
                  //         SizedBox(
                  //           height: 8,
                  //         ),
                  //         getCheckbox(
                  //             "Garanti",
                  //             widget.serviceReport.hizmetCinsiGarantiValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "??lk ??al????t??rma",
                  //             widget.serviceReport.hizmetCinsiIlkValue == 1
                  //                 ? true
                  //                 : false),
                  //         SizedBox(height: 8),
                  //         getCheckbox(
                  //             "Normal",
                  //             widget.serviceReport.hizmetCinsiNormalValue == 1
                  //                 ? true
                  //                 : false),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Padding buildRow({String text, String value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$text",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("$value"),
        ],
      ),
    );
  }
}
