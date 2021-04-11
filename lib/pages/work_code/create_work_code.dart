import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/work_code/bloc/work_code_bloc.dart';

import 'package:teknoloji_kimya_servis/helpers/context_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/pages/users_page/choose_user_page.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/choose_worker_page.dart';
import 'package:teknoloji_kimya_servis/providers/work_code_provider.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class CreateWorkCode extends StatefulWidget {
  CreateWorkCode({Key key}) : super(key: key);

  @override
  _CreateWorkCodeState createState() => _CreateWorkCodeState();
}

class _CreateWorkCodeState extends State<CreateWorkCode> {
  final _codeController = TextEditingController();
  final _departmentController = TextEditingController();
  DateTime _startDate;
  DateTime _expirationDate;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WorkCodeProvider>(context, listen: false).selectedCompany =
          null;
      Provider.of<WorkCodeProvider>(context, listen: false).myUser = null;
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
                if (Provider.of<WorkCodeProvider>(context, listen: false)
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
                    worker:
                        Provider.of<WorkCodeProvider>(context, listen: false)
                            .myUser,
                    startDate: _startDate,
                    expirationDate: _expirationDate,
                    customer:
                        Provider.of<WorkCodeProvider>(context, listen: false)
                            .selectedCompany,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildWorker(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCustomer(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              prefixIcon: Icon(Icons.format_color_text),
              hintText: "Departman girin",
              labelText: "Departman",
              controller: _departmentController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              prefixIcon: Icon(Icons.code),
              hintText: "Çalışma kodu girin",
              labelText: "Çalışma Kodu",
              controller: _codeController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildStartDate(context),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildExpirationDate(context),
          ),
        ],
      ),
    );
  }

  Card _buildStartDate(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(0),
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

  Card _buildExpirationDate(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 4,
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
          await _chooseExpirationDate(context);
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
    // TimeOfDay _timeOfDay = await showTimePicker(
    //   context: context,
    //   initialTime: TimeOfDay.now(),
    // );
    // if (_pickedDate != null && _timeOfDay != null) {
    //   DateTime _dateTime = DateTime(
    //     _pickedDate.year,
    //     _pickedDate.month,
    //     _pickedDate.day,
    //     _timeOfDay.hour,
    //     _timeOfDay.minute,
    //   );
    _startDate = _pickedDate;
    setState(() {});
  }

  Future _chooseExpirationDate(BuildContext context) async {
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
    // TimeOfDay _timeOfDay = await showTimePicker(
    //   context: context,
    //   initialTime: TimeOfDay.now(),
    // );
    // if (_pickedDate != null && _timeOfDay != null) {
    //   DateTime _dateTime = DateTime(
    //     _pickedDate.year,
    //     _pickedDate.month,
    //     _pickedDate.day,
    //     _timeOfDay.hour,
    //     _timeOfDay.minute,
    //   );
    _expirationDate = _pickedDate;
    setState(() {});
  }

  Card _buildWorker(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          NavigatorHelper(context).goTo(
            ChooseWorkerPage(
              myFunction: (ApiUsersData myUser) {
                Provider.of<WorkCodeProvider>(context, listen: false).myUser =
                    myUser;
                Navigator.pop(context);
              },
            ),
          );
        },
        leading: Icon(Icons.person),
        title: Consumer<WorkCodeProvider>(
          builder: (BuildContext context, value, Widget child) {
            if (value.myUser == null) {
              return Text("Bir çalışan seçin");
            }
            return Text("${value.myUser.fullName}");
          },
        ),
        subtitle: Consumer<WorkCodeProvider>(
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

  Card _buildCustomer(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          NavigatorHelper(context).goTo(
            ChooseUserPage(
              onCompanyChoosed: (ApiUsersData company) {
                Provider.of<WorkCodeProvider>(context, listen: false)
                    .selectedCompany = company;
                Navigator.pop(context);
              },
            ),
          );
        },
        leading: Icon(Icons.home_repair_service),
        title: Consumer<WorkCodeProvider>(
          builder: (BuildContext context, value, Widget child) {
            if (value.selectedCompany == null) {
              return Text("Bir müşteri seçin");
            }
            return Text("${value.selectedCompany.fullName}");
          },
        ),
        subtitle: Consumer<WorkCodeProvider>(
          builder: (BuildContext context, value, Widget child) {
            if (value.selectedCompany == null) {
              return Text("");
            }
            return Text("${value.selectedCompany.phone}");
          },
        ),
      ),
    );
  }
  // ChooseUserPage(
  //                           onCompanyChoosed: (ApiUsersData company) {
  //                             Provider.of<CompanyProvider>(context,
  //                                     listen: false)
  //                                 .selectedCompany = company;
  //                             Navigator.pop(context);
  //                           },
  //                         ),

  Future<void> _pushToDatabase({
    @required ApiUsersData worker,
    @required ApiUsersData customer,
    @required DateTime startDate,
    @required DateTime expirationDate,
  }) async {
    try {
      EralpHelper.startProgress();
      final _response = await PostApi.addWorkCode(
        userId: worker.id.toString(),
        customerId: customer.id.toString(),
        phone: worker.phone,
        workCode: _codeController.text,
        department: _departmentController.text,
        fullName: worker.fullName,
        startDate: startDate,
        expirationDate: expirationDate,
      );

      if (_response is bool) {
        BlocProvider.of<WorkCodeBloc>(ContextHelper().context)
            .add(ClearWorkCodeEvent());
        MyFlushbarHelper(context: ContextHelper().context).showSuccessFlushbar(
            title: "Başarılı", message: "Çalışma kodu ekleme başarılı");
      } else {
        MyFlushbarHelper(context: ContextHelper().context)
            .showErrorFlushbar(title: "Hata", message: "$_response");
      }
    } on Exception catch (e, trace) {
      print("error: $e, trace: $trace");
      MyFlushbarHelper(context: context).showErrorFlushbar(
          title: "Hata", message: "Çalışma kodu ekleme başarısız");
    } finally {
      EralpHelper.stopProgress();
    }
  }
}
