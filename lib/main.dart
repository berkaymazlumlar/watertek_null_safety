import 'package:equatable/equatable.dart';
import 'package:eralpsoftware/eralpsoftware.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/blocs/auth/auth_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/choose_user/choose_user_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/company_list/company_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/customer_list/customer_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/customer_request_list/bloc/customer_request_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/exploration/exploration_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/health_report/bloc/health_report_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/material_list/bloc/material_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/periodic_maintenance_detail/periodic_maintenance_detail_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/periodic_maintenance_list/periodic_maintenance_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/product_list/product_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/sale/sale_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/service_report/service_report_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/user_list/user_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/user_location_list/user_location_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_images/work_order_images_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_list/work_order_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_updates/work_order_status_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/worker_list/worker_list_bloc.dart';
import 'package:teknoloji_kimya_servis/pages/health_report/health_report.dart';
import 'package:teknoloji_kimya_servis/pages/periodic_maintenance/periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/providers/choose_spare_part_provider.dart';
import 'package:teknoloji_kimya_servis/providers/company_provider.dart';
import 'package:teknoloji_kimya_servis/providers/exploration%20report.dart';
import 'package:teknoloji_kimya_servis/providers/health_report_provider.dart';
import 'package:teknoloji_kimya_servis/providers/material_provider.dart';
import 'package:teknoloji_kimya_servis/providers/periodic_maintenance_provider.dart';
import 'package:teknoloji_kimya_servis/providers/settings_provider.dart';
import 'package:teknoloji_kimya_servis/providers/sign_provider.dart';
import 'package:teknoloji_kimya_servis/providers/theme_provider.dart';
import 'package:teknoloji_kimya_servis/providers/work_code_provider.dart';
import 'package:teknoloji_kimya_servis/providers/work_order_provider.dart';
import 'package:teknoloji_kimya_servis/routes/generate_route.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

import 'blocs/spare_part_list/bloc/spare_part_list_bloc.dart';
import 'blocs/work_code/bloc/work_code_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MyLocator.setupLocator();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => CompanyListBloc(),
        ),
        BlocProvider(
          create: (context) => ProductListBloc(),
        ),
        BlocProvider(
          create: (context) => UserListBloc(),
        ),
        BlocProvider(
          create: (context) => WorkOrderListBloc(),
        ),
        BlocProvider(
          create: (context) => PeriodicMaintenanceBloc(),
        ),
        BlocProvider(
          create: (context) => ServiceReportBloc(),
        ),
        BlocProvider(
          create: (context) => WorkOrderImagesBloc(),
        ),
        BlocProvider(
          create: (context) => WorkOrderStatusBloc(),
        ),
        BlocProvider(
          create: (context) => SaleBloc(),
        ),
        BlocProvider(
          create: (context) => SparePartListBloc(),
        ),
        BlocProvider(
          create: (context) => PeriodicMaintenanceDetailBloc(),
        ),
        BlocProvider(
          create: (context) => CustomerRequestListBloc(),
        ),
        BlocProvider(
          create: (context) => ExplorationBloc(),
        ),
        BlocProvider(
          create: (context) => ChooseUserBloc(),
        ),
        BlocProvider(
          create: (context) => WorkerListBloc(),
        ),
        BlocProvider(
          create: (context) => CustomerListBloc(),
        ),
        BlocProvider(
          create: (context) => UserLocationListBloc(),
        ),
        BlocProvider(
          create: (context) => HealthReportBloc(),
        ),
        BlocProvider(
          create: (context) => WorkCodeBloc(),
        ),
        BlocProvider(
          create: (context) => MaterialListBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CompanyProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => WorkOrderProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PeriodicMaintenanceProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ExplorationReportProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SettingsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChooseSparePartProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SignProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => HealthReportProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => WorkCodeProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChooseMaterialProvider(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Eralp.builder(
      context: context,
      child: MaterialApp(
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: child,
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Watertek: Teknik Servis',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('tr', 'TR'),
        ],
        theme: Provider.of<ThemeProvider>(context).theme,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: "/",
      ),
    );
  }
}
