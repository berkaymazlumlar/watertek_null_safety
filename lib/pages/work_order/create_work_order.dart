import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_list/work_order_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/context_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/pages/users_page/choose_user_page.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/choose_worker_page.dart';
import 'package:teknoloji_kimya_servis/providers/work_order_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CreateWorkOrder extends StatefulWidget {
  CreateWorkOrder({Key key}) : super(key: key);

  @override
  _CreateWorkOrderState createState() => _CreateWorkOrderState();
}

class _CreateWorkOrderState extends State<CreateWorkOrder> {
  final _taskController = TextEditingController();
  DateTime _taskDate;
  bool _isPdf = false;
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _isPdf = false;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WorkOrderProvider>(context, listen: false).selectedCompany =
          null;
      Provider.of<WorkOrderProvider>(context, listen: false).myUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('İş emri oluştur'),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                if (Provider.of<WorkOrderProvider>(context, listen: false)
                        .selectedCompany ==
                    null) {
                  MyFlushbarHelper(context: context).showInfoFlushbar(
                      title: "Hata",
                      message: "Müşteri seçmeden ilerleyemezsiniz.");
                  return;
                }
                if (Provider.of<WorkOrderProvider>(context, listen: false)
                        .myUser ==
                    null) {
                  MyFlushbarHelper(context: context).showInfoFlushbar(
                      title: "Hata",
                      message: "Çalışan seçmeden ilerleyemezsiniz.");
                  return;
                }
                if (_taskDate == null) {
                  MyFlushbarHelper(context: context).showInfoFlushbar(
                      title: "Hata",
                      message: "Tarih seçmeden ilerleyemezsiniz.");
                  return;
                }
                _isPdf = true;
                setState(() {});
                await Future.delayed(
                  Duration(milliseconds: 500),
                );
                try {
                  EralpHelper.startProgress();

                  _uploadPdf(
                    company:
                        Provider.of<WorkOrderProvider>(context, listen: false)
                            .selectedCompany,
                    worker:
                        Provider.of<WorkOrderProvider>(context, listen: false)
                            .myUser,
                    taskDescription: _taskController.text,
                    taskDate: _taskDate,
                  );
                  Navigator.pop(context);
                } catch (e, trace) {
                  print("there is an error: $e, trace: $trace");
                } finally {
                  EralpHelper.stopProgress();
                }
              },
            ),
          ],
        ),
        body: !_isPdf ? _flutterScaffold(context) : _pdfScaffold(context),
      ),
      // child: _flutterScaffold(context),
    );
  }

  ListView _flutterScaffold(BuildContext context) {
    return ListView(
      children: [
        _buildWorker(context),
        _buildWorkOrder(context),
        _buildTaskDescription(),
        _buildTaskDate(context),
      ],
    );
  }

  Widget _pdfScaffold(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RepaintBoundary(
      key: _printKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.075,
            ),
          ),
          Card(
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Çalışan ismi: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Consumer<WorkOrderProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      if (value.myUser == null) {
                        return Text("Çalışan seç");
                      }
                      return Text("${value.myUser.fullName}");
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Çalışan numarası: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Consumer<WorkOrderProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      if (value.myUser == null) {
                        return Text("Çalışan seç");
                      }
                      return Text("${value.myUser.phone}");
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Firma ismi: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Consumer<WorkOrderProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      if (value.selectedCompany == null) {
                        return Text("Çalışan seç");
                      }
                      return Text("${value.selectedCompany.fullName}");
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Firma numarası: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Consumer<WorkOrderProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      if (value.myUser == null) {
                        return Text("Çalışan seç");
                      }
                      return Text("${value.selectedCompany.phone}");
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Görev tarihi: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                      child:
                          Text("${DateHelper.getStringDateHourTR(_taskDate)}"))
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Görev: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Flexible(child: Text("${_taskController.text}"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildTaskDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: _taskDate == null
            ? Text(
                "Lütfen görev tarihi seçin",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Text(
                "Görev tarihi: ${DateHelper.getStringDateHourTR(_taskDate)}"),
        onTap: () async {
          await _chooseDate(context);
        },
      ),
    );
  }

  Future _chooseDate(BuildContext context) async {
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
    TimeOfDay _timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_pickedDate != null && _timeOfDay != null) {
      DateTime _dateTime = DateTime(
        _pickedDate.year,
        _pickedDate.month,
        _pickedDate.day,
        _timeOfDay.hour,
        _timeOfDay.minute,
      );
      _taskDate = _dateTime;
      setState(() {});
    }
  }

  Padding _buildTaskDescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: _taskController,
        maxLines: 4,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: "Görev",
          labelText: "Görev",
          prefixIcon: Icon(Icons.mode_outlined),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Padding _buildWorker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          onTap: () {
            NavigatorHelper(context).goTo(
              ChooseWorkerPage(
                myFunction: (ApiUsersData myUser) {
                  Provider.of<WorkOrderProvider>(context, listen: false)
                      .myUser = myUser;
                  Navigator.pop(context);
                },
              ),
            );
          },
          title: Consumer<WorkOrderProvider>(
            builder: (BuildContext context, value, Widget child) {
              if (value.myUser == null) {
                return Text("Çalışan seç");
              }
              return Text("${value.myUser.fullName}");
            },
          ),
          subtitle: Consumer<WorkOrderProvider>(
            builder: (BuildContext context, value, Widget child) {
              if (value.myUser == null) {
                return Text("");
              }
              return Text("${value.myUser.phone}");
            },
          ),
        ),
      ),
    );
  }

  Padding _buildWorkOrder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          onTap: () {
            NavigatorHelper(context).goTo(
              ChooseUserPage(
                onCompanyChoosed: (ApiUsersData company) {
                  Provider.of<WorkOrderProvider>(context, listen: false)
                      .selectedCompany = company;
                  Navigator.pop(context);
                },
              ),
            );
          },
          title: Consumer<WorkOrderProvider>(
            builder: (BuildContext context, value, Widget child) {
              if (value.selectedCompany == null) {
                return Text("Müşteri seç");
              }
              return Text("${value.selectedCompany.fullName}");
            },
          ),
          subtitle: Consumer<WorkOrderProvider>(
            builder: (BuildContext context, value, Widget child) {
              if (value.selectedCompany == null) {
                return Text("");
              }
              return Text("${value.selectedCompany.phone}");
            },
          ),
        ),
      ),
    );
  }

  Future<void> _uploadPdf({
    @required ApiUsersData worker,
    @required ApiUsersData company,
    @required DateTime taskDate,
    @required String taskDescription,
  }) async {
    final doc = pw.Document();

    final image = await wrapWidget(
      doc.document,
      key: _printKey,
      pixelRatio: 2.0,
    );

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a3,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Expanded(
              child: pw.Image(
                pw.ImageProxy(image),
              ),
            ),
          );
        },
      ),
    );
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${DateTime.now()}.pdf');
    file.writeAsBytesSync(
      await doc.save(),
    );
    print("file created successfully, path is ${file.path}");

    final reference =
        FirebaseStorage.instance.ref().child("${DateTime.now()}.pdf");
    final uploadTask = reference.putData(file.readAsBytesSync());
    String url = await (await uploadTask.whenComplete(() {
      print("completed");
    }))
        .ref
        .getDownloadURL();
    print("url: $url");

    try {
      EralpHelper.startProgress();
      final _response = await PostApi.addWorkOrder(
        companyId: company.id.toString(),
        userId: worker.id.toString(),
        taskDescription: taskDescription,
        pdfUrl: url,
        taskDate: taskDate,
      );

      if (_response is bool) {
        BlocProvider.of<WorkOrderListBloc>(ContextHelper().context)
            .add(ClearWorkOrderListEvent());
        MyFlushbarHelper(context: ContextHelper().context).showSuccessFlushbar(
            title: "Başarılı", message: "İş emri ekleme başarılı");
      } else {
        MyFlushbarHelper(context: ContextHelper().context)
            .showErrorFlushbar(title: "Hata", message: "$_response");
      }
    } on Exception catch (e, trace) {
      print("error: $e, trace: $trace");
      MyFlushbarHelper(context: context).showErrorFlushbar(
          title: "Hata", message: "İş emri ekleme başarısız");
    } finally {
      EralpHelper.stopProgress();
    }

    return doc.save();
  }

  Future<PdfImage> wrapWidget(
    PdfDocument document, {
    @required GlobalKey key,
    int width,
    int height,
    double pixelRatio = 1.0,
  }) async {
    assert(key != null);
    assert(pixelRatio != null && pixelRatio > 0);

    final RenderRepaintBoundary wrappedWidget =
        key.currentContext.findRenderObject();
    final image = await wrappedWidget.toImage(pixelRatio: pixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final imageData = byteData.buffer.asUint8List();
    return PdfImage(document,
        image: imageData, width: image.width, height: image.height);
  }
}
