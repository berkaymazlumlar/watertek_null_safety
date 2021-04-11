import 'package:animate_do/animate_do.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/exploration_report/exploration_report_page.dart';
import 'package:teknoloji_kimya_servis/pages/location/user_location_list_page.dart';
import 'package:teknoloji_kimya_servis/pages/periodic_maintenance/periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/pages/request_page/request_list_page.dart';
import 'package:teknoloji_kimya_servis/pages/service_password/create_service_password.dart';
import 'package:teknoloji_kimya_servis/pages/service_report/service_report_list.dart';
import 'package:teknoloji_kimya_servis/pages/show/show_product_detail_page.dart';
import 'package:teknoloji_kimya_servis/pages/show/show_sale_list_page.dart';
import 'package:teknoloji_kimya_servis/pages/spare_part/spare_part_list_page.dart';
import 'package:teknoloji_kimya_servis/pages/users_page/users_page.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/worker_work_order_list_page.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/company_repository/company_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

AuthRepository _authRepository = locator<AuthRepository>();

final CompanyListRepository _companyListRepository =
    locator<CompanyListRepository>();

class WorkerUserOperations extends StatelessWidget {
  const WorkerUserOperations({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        _companyListRepository.getCompanyList();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: FadeIn(
            duration: Duration(milliseconds: 500),
            child: Center(
              child: Text(
                'Kullanıcı İşlemleri',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1.color,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _authRepository.apiUser.data.isCustomer == 1
                    ? Container()
                    : Container(
                        height: _size.height * 0.20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: InkWell(
                                child: _buildElement(
                                    Icons.repeat, "Periyodik Bakım", context),
                                onTap: () {
                                  NavigatorHelper(context)
                                      .goTo(PeriodicMaintenance());
                                },
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: _buildElement(
                                    Icons.assignment, "Servis Raporu", context),
                                onTap: () {
                                  NavigatorHelper(context)
                                      .goTo(ServiceReportListPage());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                Container(
                  height: _size.height * 0.20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: InkWell(
                          child: _buildElement(
                              Icons.qr_code, "QR Tarayıcı", context),
                          onTap: () async {
                            await _onBarcodeTapped(context);
                          },
                        ),
                      ),
                      _authRepository.apiUser.data.isCustomer == 1
                          ? Container()
                          : Expanded(
                              child: InkWell(
                                child: _buildElement(
                                    Icons.bar_chart, "İş Emirleri", context),
                                onTap: () {
                                  NavigatorHelper(context).goTo(
                                    WorkerWorkOrderListPage(),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
                _authRepository.apiUser.data.isCustomer == 1
                    ? Container()
                    : Container(
                        height: _size.height * 0.20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: InkWell(
                                child: _buildElement(
                                    Icons.search, "Keşif Raporu", context),
                                onTap: () async {
                                  NavigatorHelper(context)
                                      .goTo(ExplorationReportPage());
                                },
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: _buildElement(Icons.home_repair_service,
                                    "Yedek Parçalar", context),
                                onTap: () {
                                  NavigatorHelper(context)
                                      .goTo(SparePartListPage());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                _authRepository.apiUser.data.isCustomer == 1
                    ? Container()
                    : Container(
                        height: _size.height * 0.20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: InkWell(
                                child: _buildElement(
                                    Icons.request_page, "Talepler", context),
                                onTap: () {
                                  NavigatorHelper(context)
                                      .goTo(RequestListPage());
                                },
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: _buildElement(Icons.vpn_key,
                                    "Servis Şifre Oluşturucu", context),
                                onTap: () async {
                                  NavigatorHelper(context)
                                      .goTo(CreateServicePassword());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _onBarcodeTapped(BuildContext context) async {
    String qrCode = await _openBarcodeScreen();
    if (qrCode.length > 2) {
      EralpHelper.startProgress();
      try {
        final _response =
            await PostApi.getSaleWithBarcode(barcodeNumber: "123");
        print("response length: ${_response.data.length}");
        if (_response.data.length == 1) {
          final sale = _response.data.first;
          NavigatorHelper(context).goTo(
            ShowSaleDetailPage(
              sale: sale,
            ),
          );
        } else if (_response.data.length == 0) {
          FlushbarHelper.createError(title: "Hata", message: "Ürün bulunamadı")
              .show(context);
        } else {
          FlushbarHelper.createError(
                  title: "Hata",
                  message: "Aynı barkoda ait birden fazla ürün bulundu")
              .show(context);
        }
      } on Exception catch (e) {
        FlushbarHelper.createError(title: "Hata", message: e.toString())
            .show(context);
      } finally {
        EralpHelper.stopProgress();
      }
    }
  }

  Widget _buildElement(IconData icon, String text, BuildContext context,
      {String iconText}) {
    return FadeIn(
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                iconText != null
                    ? Text(
                        "$iconText",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 35,
                        ),
                      )
                    : Icon(
                        icon,
                        size: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                Text(
                  "$text",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _openBarcodeScreen() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );

    if (barcodeScanRes == "-1") {
      print("okumadim eksi bir dondum");
      return "-1";
    } else {
      print(barcodeScanRes);
      return barcodeScanRes;
    }
  }
}
