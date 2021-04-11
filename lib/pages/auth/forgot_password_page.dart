import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:eralpsoftware/eralpsoftware.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/auth/auth_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MyFlushbarHelper _flushbarHelper = MyFlushbarHelper(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifremi unuttum"),
      ),
      body: Dialog(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "Mail"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () async {
                      try {
                        EralpHelper.startProgress();
                      

                        _flushbarHelper.showSuccessFlushbar(
                          title: "Başarılı",
                          message: "E-mail adresinize sıfırlama mail'i yollandı",
                        );
                      } catch (e) {
                        _flushbarHelper.showErrorFlushbar(
                          title: "Hata",
                          message:
                              "Beklenmedik bir hata oluştu. Mail adresinizi ve internet bağlantınızı kontrol ediniz",
                        );
                        EralpHelper.stopProgress();

                        print(e);
                      } finally {
                        EralpHelper.stopProgress();
                      }
                    },
                    child: Text("Kayit ol"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
