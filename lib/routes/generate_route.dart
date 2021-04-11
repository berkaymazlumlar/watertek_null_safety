import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/pages/auth/forgot_password_page.dart';
import 'package:teknoloji_kimya_servis/pages/auth/login_page.dart';
import 'package:teknoloji_kimya_servis/pages/auth/sign_up_page.dart';
import 'package:teknoloji_kimya_servis/pages/company/choose_company_page.dart';
import 'package:teknoloji_kimya_servis/pages/error/error_page.dart';
import 'package:teknoloji_kimya_servis/pages/add/add_product_page.dart';
import 'package:teknoloji_kimya_servis/pages/show/show_product_list_page.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/work_order_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        );
      case "/signUpPage":
        return MaterialPageRoute(
          builder: (BuildContext context) => SignUpPage(),
        );
      case "/forgotPasswordPage":
        return MaterialPageRoute(
          builder: (BuildContext context) => ForgotPasswordPage(),
        );

      case "/addItemPage":
        return MaterialPageRoute(
          builder: (BuildContext context) => AddItemPage(),
        );
      case "/showProductListPage":
        return MaterialPageRoute(
          builder: (BuildContext context) => ShowProductListPage(),
        );
      case "/workOrderListPage":
        return MaterialPageRoute(
          builder: (BuildContext context) => WorkOrderListPage(),
        );

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => ErrorPage());
    }
  }
}
