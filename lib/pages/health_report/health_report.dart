import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/health_report/bloc/health_report_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'create_health_report.dart';

class HealthReportPage extends StatefulWidget {
  @override
  _HealthReportPageState createState() => _HealthReportPageState();
}

class _HealthReportPageState extends State<HealthReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          NavigatorHelper(context).goTo(
            CreateHealthReport(),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Sağlık Raporları'),
      ),
      body: BlocBuilder<HealthReportBloc, HealthReportState>(
        builder: (BuildContext context, state) {
          if (state is HealthReportLoadedState) {
            return ListView.builder(
                itemCount: state.apiHealthReport.body.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(15),
                          border: Border(
                            left: BorderSide(
                              width: 8.0,
                              color: index % 3 == 0
                                  ? Colors.blue
                                  : index % 3 == 1
                                      ? Colors.orange
                                      : Colors.green,
                            ),
                          ),
                        ),
                        child: ExpansionTile(
                          title: Text(
                              "${state.apiHealthReport.body[index].workerName}"),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  _buildContainer(
                                    color: Colors.grey[200],
                                    key: "Başlangıç tarihi",
                                    value:
                                        "${DateHelper.getStringDateTR(state.apiHealthReport.body[index].startDate)}",
                                  ),
                                  _buildContainer(
                                    key: "Bitiş tarihi",
                                    value:
                                        "${DateHelper.getStringDateTR(state.apiHealthReport.body[index].expirationDate)}",
                                  ),
                                  _buildContainer(
                                    color: Colors.grey[200],
                                    key: "Personel Telefonu",
                                    value:
                                        "${state.apiHealthReport.body[index].workerPhone}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          if (state is HealthReportInitialState) {
            BlocProvider.of<HealthReportBloc>(context).add(
              GetHealthReportEvent(),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Container _buildContainer({String key, String value, Color color}) {
    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$key",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("$value"),
        ],
      ),
    );
  }
}
