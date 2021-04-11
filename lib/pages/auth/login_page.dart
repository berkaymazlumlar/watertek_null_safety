import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teknoloji_kimya_servis/blocs/auth/auth_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/context_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/pages/home/home_page.dart';
import 'package:teknoloji_kimya_servis/pages/home/home_page_customer.dart';
import 'package:teknoloji_kimya_servis/pages/home/home_page_worker.dart';
import 'package:teknoloji_kimya_servis/pages/home/worker_location_page.dart';
import 'package:teknoloji_kimya_servis/pages/home/inner_home_page.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  Icon visibilityIcon = Icon(Icons.visibility);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _emailController.text = "berkaymazlumlar";
    // _passwordController.text = "123456";
    _autoLogin();
  }

  _autoLogin() async {
    final _serpireferensis = await SharedPreferences.getInstance();
    final _username = _serpireferensis.getString("username");
    final _password = _serpireferensis.getString("password");
    if (_username != null &&
        _username.length > 0 &&
        _password != null &&
        _password.length > 0) {
      BlocProvider.of<AuthBloc>(context).add(
        GetAuthEvent(
          email: _username,
          password: _password,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ContextHelper().context = context;
    MyFlushbarHelper _flushbarHelper = MyFlushbarHelper(context: context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailureState) {
          _flushbarHelper.showErrorFlushbar(
            title: "Hata",
            message: "${state.error}",
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return Container(
            child: Container(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (state is AuthSuccessState) {
          if (state.apiUser.data.isCustomer == 1) {
            return InnerHomePage(child: HomePageCustomer());
          }
          if (state.apiUser.data.isWorker == 1) {
            return InnerHomePage(child: HomePageWorker());
          }
          return InnerHomePage(child: HomePage());
        }
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElasticInRight(
                    child: Center(
                      child: Container(
                        height: 90,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  ElasticInRight(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                      child: MyTextField(
                        controller: _emailController,
                        hintText: "Kullanıcı adı",
                        prefixIcon: Icon(Icons.verified_user),
                      ),
                    ),
                  ),
                  ElasticInRight(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                      child: MyTextField(
                        controller: _passwordController,
                        hintText: "Şifre",
                        prefixIcon: Icon(Icons.vpn_key),
                        suffixIcon: IconButton(
                          icon: visibilityIcon,
                          onPressed: () {
                            if (_obscureText) {
                              _obscureText = false;

                              visibilityIcon = Icon(Icons.visibility);
                            } else {
                              _obscureText = true;
                              visibilityIcon = Icon(Icons.visibility_off);
                            }
                            setState(() {});
                          },
                        ),
                        obscureText: _obscureText,
                      ),
                    ),
                  ),
                  ElasticInRight(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                      child: ButtonTheme(
                        height: 50,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            BlocProvider.of<AuthBloc>(context).add(
                              GetAuthEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          child: Text(
                            "Giriş",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  //   child: FlatButton(
                  //     onPressed: () async {
                  //       Navigator.pushNamed(context, "/signUpPage");
                  //     },
                  //     child: Text(
                  //       "Kayıt ol",
                  //     ),
                  //   ),
                  // ),
                  ElasticInRight(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            onPressed: () async {
                              Navigator.pushNamed(context, "/signUpPage");
                            },
                            child: Text(
                              "Kayıt ol",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          // FlatButton(
                          //   onPressed: () async {
                          //     // return Navigator.pushNamed(
                          //     //     context, "/forgotPasswordPage");
                          //   },
                          //   child: Text(
                          //     "Şifremi unuttum",
                          //     style: TextStyle(fontSize: 13),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
