import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/health_report/bloc/health_report_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_list/work_order_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/context_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/pages/users_page/choose_user_page.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/choose_worker_page.dart';
import 'package:teknoloji_kimya_servis/providers/health_report_provider.dart';
import 'package:teknoloji_kimya_servis/providers/work_order_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CreateHealthReport extends StatefulWidget {
  CreateHealthReport({Key key}) : super(key: key);

  @override
  _CreateHealthReportState createState() => _CreateHealthReportState();
}

class _CreateHealthReportState extends State<CreateHealthReport> {
  DateTime _startDate;
  DateTime _expirationDate;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HealthReportProvider>(context, listen: false)
          .selectedCompany = null;
      Provider.of<HealthReportProvider>(context, listen: false).myUser = null;
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
          title: Text('Sağlık Raporu Ekle'),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                if (Provider.of<HealthReportProvider>(context, listen: false)
                        .myUser ==
                    null) {
                  MyFlushbarHelper(context: context).showInfoFlushbar(
                      title: "Hata",
                      message: "Çalışan seçmeden ilerleyemezsiniz.");
                  return;
                }
                if (_startDate == null || _expirationDate == null) {
                  MyFlushbarHelper(context: context).showInfoFlushbar(
                      title: "Hata",
                      message: "Tarih seçmeden ilerleyemezsiniz.");
                  return;
                }
                setState(() {});
                await Future.delayed(
                  Duration(milliseconds: 500),
                );
                try {
                  EralpHelper.startProgress();

                  _pushToDatabase(
                    worker: Provider.of<HealthReportProvider>(context,
                            listen: false)
                        .myUser,
                    startDate: _startDate,
                    expirationDate: _expirationDate,
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
        body: _flutterScaffold(context),
      ),
      // child: _flutterScaffold(context),
    );
  }

  Padding _flutterScaffold(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          _buildWorker(context),
          _buildStartDate(context),
          _buildexpirationDate(context),
        ],
      ),
    );
  }

  Card _buildStartDate(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: _startDate == null
            ? Text(
                "Rapor başlangıç tarihi seçin",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Row(
                children: [
                  Text(
                    "Başlangıç: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${DateHelper.getStringDateTR(_startDate)}"),
                ],
              ),
        onTap: () async {
          await _chooseStartDate(context);
        },
      ),
    );
  }

  Card _buildexpirationDate(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: _expirationDate == null
            ? Text(
                "Rapor bitiş tarihi seçin",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Row(
                children: [
                  Text(
                    "Bitiş: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${DateHelper.getStringDateTR(_expirationDate)}"),
                ],
              ),
        onTap: () async {
          await _chooseexpirationDate(context);
        },
      ),
    );
  }

  Future _chooseStartDate(BuildContext context) async {
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
      _startDate = _dateTime;
      setState(() {});
    }
  }

  Future _chooseexpirationDate(BuildContext context) async {
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
      _expirationDate = _dateTime;
      setState(() {});
    }
  }

  Card _buildWorker(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          NavigatorHelper(context).goTo(
            ChooseWorkerPage(
              myFunction: (ApiUsersData myUser) {
                Provider.of<HealthReportProvider>(context, listen: false)
                    .myUser = myUser;
                Navigator.pop(context);
              },
            ),
          );
        },
        leading: Icon(Icons.person),
        title: Consumer<HealthReportProvider>(
          builder: (BuildContext context, value, Widget child) {
            if (value.myUser == null) {
              return Text("Bir çalışan seçin");
            }
            return Text("${value.myUser.fullName}");
          },
        ),
        subtitle: Consumer<HealthReportProvider>(
          builder: (BuildContext context, value, Widget child) {
            if (value.myUser == null) {
              return Text("");
            }
            return Text("${value.myUser.phone}");
          },
        ),
      ),
    );
  }

  Future<void> _pushToDatabase({
    @required ApiUsersData worker,
    @required DateTime startDate,
    @required DateTime expirationDate,
  }) async {
    try {
      EralpHelper.startProgress();
      final _response = await PostApi.addHealthReport(
        userId: worker.id.toString(),
        phone: worker.phone,
        fullName: worker.fullName,
        startDate: startDate,
        expirationDate: expirationDate,
      );

      if (_response is bool) {
        BlocProvider.of<HealthReportBloc>(ContextHelper().context)
            .add(ClearHealthReportEvent());
        MyFlushbarHelper(context: ContextHelper().context).showSuccessFlushbar(
            title: "Başarılı", message: "Sağlık raporu ekleme başarılı");
      } else {
        MyFlushbarHelper(context: ContextHelper().context)
            .showErrorFlushbar(title: "Hata", message: "$_response");
      }
    } on Exception catch (e, trace) {
      print("error: $e, trace: $trace");
      MyFlushbarHelper(context: context).showErrorFlushbar(
          title: "Hata", message: "Sağlık raporu ekleme başarısız");
    } finally {
      EralpHelper.stopProgress();
    }
  }
}
