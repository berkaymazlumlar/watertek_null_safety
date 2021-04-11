import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/periodic_maintenance_list/periodic_maintenance_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_company.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/models/company.dart';
import 'package:teknoloji_kimya_servis/models/periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/pages/company/choose_company_page.dart';
import 'package:teknoloji_kimya_servis/pages/users_page/choose_user_page.dart';
import 'package:teknoloji_kimya_servis/providers/periodic_maintenance_provider.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class CreatePeriodicMaintenance extends StatefulWidget {
  @override
  _CreatePeriodicMaintenanceState createState() =>
      _CreatePeriodicMaintenanceState();
}

class _CreatePeriodicMaintenanceState extends State<CreatePeriodicMaintenance> {
  DateTime _taskDate;
  TextEditingController _periodController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PeriodicMaintenanceProvider>(context, listen: false)
          .selectedCompany = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(
                Icons.check,
              ),
              onPressed: () async {
                try {
                  EralpHelper.startProgress();
                  final _response = await PostApi.addPeriodicMaintenance(
                      companyId: Provider.of<PeriodicMaintenanceProvider>(
                              context,
                              listen: false)
                          .selectedCompany
                          .id
                          .toString(),
                      period: int.parse(_periodController.text),
                      firstPeriodDate: _taskDate);

                  if (_response is bool) {
                    Navigator.pop(context);

                    FlushbarHelper.createSuccess(
                      message: "Periyodik bakım oluşturuldu",
                      title: "Başarılı",
                    )..show(context);
                    print(_response.toString());
                    BlocProvider.of<PeriodicMaintenanceBloc>(context)
                        .add(ClearPeriodicMaintenanceListEvent());
                  } else {
                    print(_response);
                    FlushbarHelper.createError(
                      title: "Hata",
                      message: "$_response",
                    )..show(context);
                  }
                } catch (e) {
                  FlushbarHelper.createError(
                    title: "Hata",
                    message: "$e",
                  )..show(context);
                } finally {
                  EralpHelper.stopProgress();
                }
              })
        ],
        title: Text("Periyodik Bakım Oluştur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: () {
                    NavigatorHelper(context).goTo(
                      ChooseUserPage(
                        onCompanyChoosed: (ApiUsersData company) {
                          Provider.of<PeriodicMaintenanceProvider>(context,
                                  listen: false)
                              .selectedCompany = company;
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  leading: Icon(Icons.work),
                  title: Row(
                    children: [
                      Consumer<PeriodicMaintenanceProvider>(
                        builder: (BuildContext context, value, Widget child) {
                          if (value.selectedCompany == null) {
                            return Text(
                              "Müşteri seç",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            );
                          }
                          return Text("${value.selectedCompany.fullName}");
                        },
                      ),
                    ],
                  ),
                  subtitle: Consumer<PeriodicMaintenanceProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      if (value.selectedCompany == null) {
                        return Text(" ");
                      }
                      return Text("${value.selectedCompany.phone}");
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  leading: Icon(Icons.calendar_today),
                  title: _taskDate == null
                      ? Text(
                          "Lütfen ilk bakım tarihi seçin",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Text(
                          "İlk bakım tarihi: ${DateHelper.getStringDateTR(_taskDate)}"),
                  onTap: () async {
                    await _chooseDate(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                  prefixIcon: Icon(
                    Icons.repeat_one_outlined,
                    color: Colors.grey,
                  ),
                  controller: _periodController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.phone,
                  hintText: "Bakım kaç günde bir olacak?",
                  labelText: "Bakım kaç günde bir olacak?"),
            ),
            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Icon(
            //           Icons.repeat_one_outlined,
            //           color: Colors.grey,
            //         ),
            //         SizedBox(
            //           width: 32,
            //         ),
            //         Expanded(
            //           child: TextField(
            //             controller: _periodController,
            //             inputFormatters: [
            //               FilteringTextInputFormatter.digitsOnly
            //             ],
            //             keyboardType: TextInputType.phone,
            //             decoration: InputDecoration(
            //                 border: InputBorder.none,
            //                 hintText: "Bakım kaç günde bir olacak?",
            //                 labelText: "Bakım kaç günde bir olacak?"),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
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
        Duration(days: 365),
      ),
      lastDate: DateTime.now().add(
        Duration(days: 10000),
      ),
    );
    if (_pickedDate != null) {
      _taskDate = _pickedDate;
      setState(() {});
    }
  }
}
