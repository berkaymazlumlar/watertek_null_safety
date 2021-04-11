import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/periodic_maintenance_detail/periodic_maintenance_detail_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';

class PeriodicMaintenanceDetailPage extends StatefulWidget {
  final String id;
  PeriodicMaintenanceDetailPage({Key key, @required this.id}) : super(key: key);

  @override
  _PeriodicMaintenanceDetailPageState createState() =>
      _PeriodicMaintenanceDetailPageState();
}

class _PeriodicMaintenanceDetailPageState
    extends State<PeriodicMaintenanceDetailPage> {
  @override
  void initState() {
    super.initState();
    print("id: ${widget.id}");
    BlocProvider.of<PeriodicMaintenanceDetailBloc>(context)
        .add(ClearPeriodicMaintenanceDetailEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Periyodik Bakım'),
      ),
      body: BlocBuilder<PeriodicMaintenanceDetailBloc,
          PeriodicMaintenanceDetailState>(
        builder: (context, state) {
          if (state is PeriodicMaintenanceDetailInitial) {
            BlocProvider.of<PeriodicMaintenanceDetailBloc>(context).add(
              GetPeriodicMaintenanceDetailEvent(
                id: widget.id,
              ),
            );
          }
          if (state is PeriodicMaintenanceDetailLoaded) {
            return Card(
              child: ListView(
                children: [
                  Container(
                    child: buildContainer("Müşteri İsmi:",
                        "${state.apiPeriodicMaintenance.body[0].companyName}"),
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: buildContainer("Müşteri Numarası:",
                        "${state.apiPeriodicMaintenance.body[0].companyPhone}"),
                  ),
                  Container(
                    child: buildContainer("Oluşturulma Tarihi:",
                        "${DateHelper.getStringDateTR(state.apiPeriodicMaintenance.body[0].createdAt)}"),
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: buildContainer("İlk Bakım Tarihi:",
                        "${DateHelper.getStringDateTR(state.apiPeriodicMaintenance.body[0].firstPeriodDate)}"),
                  ),
                  Container(
                    child: buildContainer("Bakım Periyodu:",
                        "${state.apiPeriodicMaintenance.body[0].period}"),
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: buildContainer("Şimdiki bakım tarihi:",
                        "${DateHelper.getStringDateTR(_getNextDateTime(state.apiPeriodicMaintenance.body[0].firstPeriodDate, state.apiPeriodicMaintenance.body[0].period))}"),
                  ),
                  Container(
                    child: buildContainer("Gelecek bakım tarihi:",
                        "${DateHelper.getStringDateTR(_getNextDateTime(state.apiPeriodicMaintenance.body[0].firstPeriodDate, state.apiPeriodicMaintenance.body[0].period).add(Duration(days: state.apiPeriodicMaintenance.body[0].period)))}"),
                  ),
                ],
              ),
            );
          }
          if (state is PeriodicMaintenanceDetailError) {
            return Center(
              child: Text("Hata"),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildContainer(String key, String value) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElasticInRight(
              child: Text(
                key,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElasticInLeft(child: Text(value)),
          ],
        ),
      ),
    );
  }

  DateTime _getNextDateTime(DateTime _firstPeriodDate, int period) {
    if (_firstPeriodDate.millisecondsSinceEpoch >=
        DateTime.now().millisecondsSinceEpoch) {
      return _firstPeriodDate;
    } else {
      return _getNextDateTime(
          _firstPeriodDate.add(
            Duration(days: period),
          ),
          period);
    }
  }
}
