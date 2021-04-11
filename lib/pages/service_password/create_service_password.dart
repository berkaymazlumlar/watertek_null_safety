import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teknoloji_kimya_servis/views/general/my_raised_button.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class CreateServicePassword extends StatefulWidget {
  @override
  _CreateServicePasswordState createState() => _CreateServicePasswordState();
}

class _CreateServicePasswordState extends State<CreateServicePassword> {
  TextEditingController _x1Controller = TextEditingController();
  TextEditingController _x2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int sonuc1;
  int sonuc2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servis Şifresi Oluştur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  validator: (value) {
                    if (value.length == 0) {
                      return "X\u2081 boş bırakılamaz";
                    }
                    if (value == null) {
                      return "X\u2081 boş bırakılamaz";
                    }
                    return null;
                  },
                  controller: _x1Controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "X\u2081",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  validator: (value) {
                    if (value.length == 0) {
                      return "X\u2082 boş bırakılamaz";
                    }
                    if (value == null) {
                      return "X\u2082 boş bırakılamaz";
                    }
                    return null;
                  },
                  controller: _x2Controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "X\u2082",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyRaisedButton(
                  buttonText: "Oluştur",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      int x1 = int.parse(_x1Controller.text);
                      int x2 = int.parse(_x2Controller.text);
                      int a = (x1 - x2).abs();
                      int a1 = (a / 10).toInt();
                      int a2 = (a % 10).toInt();
                      int x3 = (a1 + a2) * 2;
                      int x4 = (a1 + a2) * 5;
                      sonuc1 = x3;
                      sonuc2 = x4;
                      setState(() {});
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    sonuc1 != null
                        ? Expanded(
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                leading: Text(
                                  "X\u2083",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                title: sonuc1 == null
                                    ? Text("")
                                    : Text(
                                        sonuc1.toString(),
                                      ),
                              ),
                            ),
                          )
                        : Container(),
                    sonuc2 != null
                        ? Expanded(
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                leading: Text(
                                  "X\u2084",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                title: sonuc2 == null
                                    ? Text("")
                                    : Text(
                                        sonuc2.toString(),
                                      ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
