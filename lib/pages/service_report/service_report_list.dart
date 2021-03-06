import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/blocs/service_report/service_report_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/service_report/create_service_report.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:teknoloji_kimya_servis/pages/service_report/draw_worker_page.dart';
import 'package:teknoloji_kimya_servis/pages/service_report/service_report_detail_page.dart';
import 'package:teknoloji_kimya_servis/pages/service_report/show_pdf_page.dart';
import 'package:teknoloji_kimya_servis/providers/sign_provider.dart';

class ServiceReportListPage extends StatefulWidget {
  @override
  _ServiceReportListPageState createState() => _ServiceReportListPageState();
}

class _ServiceReportListPageState extends State<ServiceReportListPage> {
  var myFont;
  var myExtraBoldFont;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final fontData = await rootBundle.load("assets/mont.ttf");
      Uint8List audioUint8List = fontData.buffer
          .asUint8List(fontData.offsetInBytes, fontData.lengthInBytes);
      myFont = pw.Font.ttf(audioUint8List.buffer.asByteData());
      final extraBoldFontData =
          await rootBundle.load("assets/montextrabold.ttf");
      Uint8List extraBoldFont = extraBoldFontData.buffer.asUint8List(
          extraBoldFontData.offsetInBytes, extraBoldFontData.lengthInBytes);
      myExtraBoldFont = pw.Font.ttf(extraBoldFont.buffer.asByteData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       NavigatorHelper(context).goTo(
        //         DrawWorkerPage(),
        //       );
        //     },
        //     icon: Icon(Icons.keyboard_arrow_right),
        //   )
        // ],
        title: Text("Servis Raporlar??"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          NavigatorHelper(context).goTo(CreateServiceReport());
        },
      ),
      body: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<ServiceReportBloc>(context).add(
            GetServiceReportListEvent(),
          );
          return Future.delayed(Duration(milliseconds: 300));
        },
        child: BlocBuilder<ServiceReportBloc, ServiceReportState>(
          builder: (BuildContext context, ServiceReportState state) {
            if (state is ServiceReportListLoadedState) {
              return ListView.builder(
                itemCount: state.serviceReportList.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(15),
                    ),
                    elevation: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(15),
                          border: Border(
                            left: BorderSide(
                              width: 8.0,
                              color: index % 3 == 0
                                  ? Colors.blue
                                  : index % 3 == 1
                                      ? Colors.orange
                                      : Colors.green,
                            ),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            NavigatorHelper(context).goTo(
                              ServiceReportDetailPage(
                                serviceReport:
                                    state.serviceReportList.data[index],
                              ),
                            );
                          },
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.serviceReportList.data[index].companyName}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "${state.serviceReportList.data[index].productName} - ${state.serviceReportList.data[index].productName}"),
                            ],
                          ),
                          subtitle: Text(
                              "Olu??turulma tarihi: ${DateHelper.getStringDateTR(state.serviceReportList.data[index].createdAt)}"),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (state is ServiceReportListInitialState) {
              BlocProvider.of<ServiceReportBloc>(context).add(
                GetServiceReportListEvent(),
              );
            }
            if (state is ServiceReportListErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Servis raporu bulunamad??"),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ServiceReportBloc>(context)
                            .add(ClearServiceReportListEvent());
                      },
                      child: Text("Yeniden Dene"),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future _savePdf(BuildContext context) async {
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

    final customerSign = pw.MemoryImage(
      Provider.of<SignProvider>(context, listen: false).customerSign,
    );
    final workerSign = pw.MemoryImage(
      Provider.of<SignProvider>(context, listen: false).workerSign,
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
                  pw.Image(image, width: 150, height: 75),
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
                  text: "SERV??S RAPORU",
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
                          text: "M????teri ad??:",
                          value: " Berkay Mazlumlar",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "M????teri tipi:",
                          value: " Berkay Mazlumlar",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "M????teri telefon:",
                          value: " Berkay Mazlumlar",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Personel:",
                          value: " Berkay Mazlumlar",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Adres:",
                          value: " Berkay Mazlumlar",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "E-mail:",
                          value: " Berkay Mazlumlar",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Marka:",
                          value: " Berkay Mazlumlar",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Model:",
                          value: " Berkay Mazlumlar",
                        ),
                        pw.SizedBox(height: 8),
                        getRowedText(
                          text: "Servis hizmeti:",
                          value: " Berkay Mazlumlar",
                        ),
                        pw.SizedBox(height: 8),
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
                        text: "Filtreler",
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
                      getCheckbox("Temizlendi", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("De??i??tirildi", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Geri y??kama yap??ld??", true),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: "Su Yumu??atma",
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
                      getCheckbox("Zaman/Debi ayar?? yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("S??zd??rmazl??k kontrol?? yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("????k???? suyu sertlik kontrol?? yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Tuz seviyesi kontrol edildi", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Re??ine minerali de??i??tirildi", true),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: "Aktif Karbon",
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
                      getCheckbox("Zaman ayar?? yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("S??zd??rmazl??k kontrol?? yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Ters y??kama yapt??r??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Aktif karbon minerali de??i??tirildi", true),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: "Kum Filtresi",
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
                      getCheckbox("Zaman ayar?? yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("S??zd??rmazl??k kontrol?? yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Ters y??kama yapt??r??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Mineral de??i??tirildi", true),
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
                      getCheckbox("??ekvalfler temizlendi", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Klor ??l????m?? yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Klor ilave edildi", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("S??zd??rmazl??k kontrol?? yap??ld??", true),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: "End??striyel RO",
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
                      getCheckbox("??ng??venlik filtreleri de??i??tirildi", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Membran de??i??tirildi", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Kimyasal y??kama yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("S??zd??rmazl??k kontrol?? yap??ld??", true),
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
                      getCheckbox("UV lamba kontrol edildi", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("S??zd??rmazl??k kontrol?? yap??ld??", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Voltaj reg??lat??r?? var", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("UV lamba de??i??tirildi", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("UV quvarts k??l??f de??i??tirildi", true),
                    ],
                  ),
                  pw.Column(
                    children: [
                      getText(
                        text: "Hizmet Cinsi",
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
                      getCheckbox("Garanti", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("??lk ??al????t??rma", true),
                      pw.SizedBox(height: 8),
                      getCheckbox("Normal", true),
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
                        value: " Berkay Mazlumlar",
                      ),
                      getRowedSignText(
                        text: "??mza: ",
                        value: pw.Image(
                          workerSign,
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
                        text: "M????teri:",
                        value: " John Doe",
                      ),
                      getRowedSignText(
                        text: "??mza: ",
                        value: pw.Image(
                          customerSign,
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

    File _myPdf = await file.writeAsBytes(await pdf.save());
    // OpenFile.open(_myPdf.path);

    NavigatorHelper(context).goTo(
      ShowPdfPage(pdf: _myPdf),
    );
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
        value,
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
    List<String> items = [
      "deneme1",
      "deneme2",
      "deneme3",
    ];
    List<int> counts = [5, 1521, 10];
    for (var i = 0; i < items.length; i++) {
      _myWidgets.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.SizedBox(height: 8),
            pw.Container(
              child: getRowedRightText(
                text: "Yedek par??a:",
                value: " ${items[i]} - ${counts[i]} adet",
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
