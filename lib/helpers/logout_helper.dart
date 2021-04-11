import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teknoloji_kimya_servis/blocs/auth/auth_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/choose_user/choose_user_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/company_list/company_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/customer_list/customer_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/customer_request_list/bloc/customer_request_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/exploration/exploration_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/periodic_maintenance_detail/periodic_maintenance_detail_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/periodic_maintenance_list/periodic_maintenance_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/product_list/product_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/sale/sale_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/service_report/service_report_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/spare_part_list/bloc/spare_part_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/user_list/user_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_images/work_order_images_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_list/work_order_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_updates/work_order_status_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/worker_list/worker_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/models/service_report.dart';

class LogoutHelper {
  final BuildContext context;
  LogoutHelper({@required this.context});

  Future clearAllBlocsAndSignOut() async {
    EralpHelper.startProgress();
    await Future.delayed(Duration(milliseconds: 500));
    BlocProvider.of<AuthBloc>(context).add(
      SignOutEvent(),
    );
    BlocProvider.of<ChooseUserBloc>(context).add(
      ClearChooseUserEvent(),
    );
    BlocProvider.of<CompanyListBloc>(context).add(
      ClearCompanyListEvent(),
    );
    BlocProvider.of<CustomerListBloc>(context).add(
      ClearCustomerListEvent(),
    );
    BlocProvider.of<CustomerRequestListBloc>(context).add(
      ClearCustomerRequestListEvent(),
    );
    BlocProvider.of<ExplorationBloc>(context).add(
      ClearExplorationEvent(),
    );
    BlocProvider.of<PeriodicMaintenanceBloc>(context).add(
      ClearPeriodicMaintenanceListEvent(),
    );
    BlocProvider.of<PeriodicMaintenanceDetailBloc>(context).add(
      ClearPeriodicMaintenanceDetailEvent(),
    );
    BlocProvider.of<ProductListBloc>(context).add(
      ClearProductListEvent(),
    );
    BlocProvider.of<SaleBloc>(context).add(
      ClearSaleEvent(),
    );
    BlocProvider.of<ServiceReportBloc>(context).add(
      ClearServiceReportListEvent(),
    );
    BlocProvider.of<SparePartListBloc>(context).add(
      ClearSparePartListEvent(),
    );
    BlocProvider.of<UserListBloc>(context).add(
      ClearUserListEvent(),
    );
    BlocProvider.of<WorkOrderImagesBloc>(context).add(
      ClearWorkOrderImagesEvent(),
    );
    BlocProvider.of<WorkOrderListBloc>(context).add(
      ClearWorkOrderListEvent(),
    );
    BlocProvider.of<WorkOrderStatusBloc>(context).add(
      ClearWorkOrderStatusEvent(),
    );
    BlocProvider.of<WorkerListBloc>(context).add(
      ClearWorkerListEvent(),
    );
    final _serpireferensis = await SharedPreferences.getInstance();
    _serpireferensis.remove("username");
    _serpireferensis.remove("password");

    Navigator.popUntil(context, (route) => route.isFirst);
    EralpHelper.stopProgress();
  }
}
