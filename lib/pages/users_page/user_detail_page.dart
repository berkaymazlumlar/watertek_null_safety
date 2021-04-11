import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/put_apis.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';

class UserDetailPage extends StatefulWidget {
  final ApiUsersData user;

  const UserDetailPage({Key key, @required this.user}) : super(key: key);
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  bool adminSwitch;
  bool customerSwitch;
  bool workerSwitch;
  int groupValue;

  @override
  void initState() {
    super.initState();
    adminSwitch = widget.user.isAdmin == 1;
    customerSwitch = widget.user.isCustomer == 1;
    workerSwitch = widget.user.isWorker == 1;
    widget.user.isAdmin == 1
        ? groupValue = 0
        : widget.user.isCustomer == 1
            ? groupValue = 1
            : groupValue = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcı Detay Sayfası'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              try {
                EralpHelper.startProgress();
                final _response = await PutApi.putUser(
                    id: widget.user.id.toString(),
                    isAdmin: groupValue == 0 ? 1 : 0,
                    isCustomer: groupValue == 1 ? 1 : 0,
                    isWorker: groupValue == 2 ? 1 : 0);
                if (_response is bool) {
                  MyFlushbarHelper(context: context).showSuccessFlushbar(
                    title: "Başarılı",
                    message: "Kullanıcı düzenleme başarılı",
                  );
                } else {
                  MyFlushbarHelper(context: context).showErrorFlushbar(
                    title: "Hata",
                    message: "Kullanıcı düzenleme başarısız",
                  );
                }
              } on Exception catch (e) {
                MyFlushbarHelper(context: context).showErrorFlushbar(
                  title: "Hata",
                  message: "$e",
                );
              } finally {
                EralpHelper.stopProgress();
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          buildPadding(
              key: "Ad Soyad",
              value: "${widget.user.fullName}",
              color: Colors.grey.shade200),
          buildPadding(
            key: "Mail:",
            value: "${widget.user.username}",
          ),
          buildPadding(
              key: "Telefon:",
              value: "${widget.user.phone}",
              color: Colors.grey.shade200),
          buildPadding(
            key: "Kayıt Tarihi:",
            value: "${DateHelper.getStringDateTR(widget.user.createdAt)}",
          ),
          buildPadding(
              key: "Kullanıcı tipi: ", value: "", color: Colors.grey.shade200),
          Transform.rotate(
            angle: pi,
            child: RadioListTile(
                title: Transform.rotate(angle: pi, child: Text("Admin")),
                value: 0,
                groupValue: groupValue,
                onChanged: (value) {
                  groupValue = value;
                  setState(() {});
                }),
          ),
          Transform.rotate(
            angle: pi,
            child: RadioListTile(
                title: Transform.rotate(angle: pi, child: Text("Personel")),
                value: 2,
                groupValue: groupValue,
                onChanged: (value) {
                  groupValue = value;
                  setState(() {});
                }),
          ),
          Transform.rotate(
            angle: pi,
            child: RadioListTile(
                title: Transform.rotate(angle: pi, child: Text("Müşteri")),
                value: 1,
                groupValue: groupValue,
                onChanged: (value) {
                  groupValue = value;
                  setState(() {});
                }),
          ),
          // SwitchListTile(
          //   title: (Text("Admin")),
          //   value: adminSwitch,
          //   onChanged: (value) {
          //     print(value);
          //     adminSwitch = value;
          //     if (adminSwitch) {
          //       workerSwitch = false;
          //       customerSwitch = false;
          //     }
          //     setState(() {});
          //   },
          // ),
          // SwitchListTile(
          //   title: (Text("Personel")),
          //   value: workerSwitch,
          //   onChanged: (value) {
          //     workerSwitch = value;
          //     if (workerSwitch) {
          //       adminSwitch = false;
          //       customerSwitch = false;
          //     }
          //     setState(() {});
          //   },
          // ),
          // SwitchListTile(
          //   title: (Text("Müşteri")),
          //   value: customerSwitch,
          //   onChanged: (value) {
          //     customerSwitch = value;
          //     if (customerSwitch) {
          //       adminSwitch = false;
          //       workerSwitch = false;
          //     }
          //     setState(() {});
          //   },
          // ),
        ],
      ),
    );
  }

  Container buildPadding({String key, String value, Color color}) {
    return Container(
      height: 50,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$key",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$value"),
          ),
        ],
      ),
    );
  }
}
