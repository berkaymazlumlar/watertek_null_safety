import 'package:get_it/get_it.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/company_repository/company_list_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/customer_request/customer_request_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/firebase.dart';
import 'package:teknoloji_kimya_servis/repositories/health_report_repository/health_report.dart';
import 'package:teknoloji_kimya_servis/repositories/material_repository/material_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/periodic_maintenance/periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/repositories/product_list/product_list_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/sale/sale_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/service_report/service_report_data_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/service_report_repository/service_report_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/spare_part_list_repository/spare_part_list_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/user_repository/user_list_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/work_code/work_code_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/work_order_repository/work_order_repository.dart';

GetIt locator = GetIt.instance;

class MyLocator {
  static void setupLocator() {
    locator.registerLazySingleton(() => AuthRepository());
    locator.registerLazySingleton(() => CompanyListRepository());
    locator.registerLazySingleton(() => ProductListRepository());
    locator.registerLazySingleton(() => UserListRepository());
    locator.registerLazySingleton(() => WorkOrderRepository());
    locator.registerLazySingleton(() => PeriodicMaintenanceRepository());
    locator.registerLazySingleton(() => ServiceReportRepository());
    locator.registerLazySingleton(() => SaleListRepository());
    locator.registerLazySingleton(() => SparePartListRepository());
    locator.registerLazySingleton(() => CustomerRequestRepository());
    locator.registerLazySingleton(() => MyFirebase());
    locator.registerLazySingleton(() => ServiceReportDataRepository());
    locator.registerLazySingleton(() => HealthReportRepository());
    locator.registerLazySingleton(() => WorkCodeRepository());
    locator.registerLazySingleton(() => MaterialRepository());
  }
}
