import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/auth/auth_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/number_helper.dart';
import 'package:teknoloji_kimya_servis/utils/numeric_input_formatter.dart';
import 'package:teknoloji_kimya_servis/views/general/my_raised_button.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MyFlushbarHelper _flushbarHelper = MyFlushbarHelper(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Kayıt"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  controller: _nameController,
                  hintText: "İsim",
                  labelText: "İsim",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  controller: _emailController,
                  hintText: "Kullanıcı adı",
                  labelText: "Kullanıcı adı",
                  prefixIcon: Icon(Icons.verified_user_rounded),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  controller: _passwordController,
                  hintText: "Şifre",
                  labelText: "Şifre",
                  prefixIcon: Icon(Icons.vpn_key),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                  hintText: "0 (___) ___ __ __",
                  labelText: "Telefon numarası",
                  prefixIcon: Icon(Icons.phone),
                  controller: _phoneController,
                  inputFormatters: [
                    NumericTextFormatter(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: MyRaisedButton(
                  buttonText: "Kayıt Ol",
                  onPressed: () async {
                    try {
                      EralpHelper.startProgress();
                      final _response = await PostApi.signUp(
                        username: _emailController.text,
                        password: _passwordController.text,
                        fullName: _nameController.text,
                        phone: NumberHelper.getStringNumberFromString(
                            _phoneController.text),
                      );

                      if (_response is bool) {
                        BlocProvider.of<AuthBloc>(context).add(
                          GetAuthEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                        Navigator.popUntil(context, (route) {
                          if (route.isFirst) {
                            return true;
                          }
                          return false;
                        });
                        _flushbarHelper.showSuccessFlushbar(
                          title: "Başarılı",
                          message: "Hesabınız oluşturuldu",
                        );
                      } else {
                        _flushbarHelper.showErrorFlushbar(
                          title: "Bir hata oluştu",
                          message: "$_response",
                        );
                      }
                    } catch (e) {
                      EralpHelper.stopProgress();

                      print(e);
                    } finally {
                      EralpHelper.stopProgress();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
