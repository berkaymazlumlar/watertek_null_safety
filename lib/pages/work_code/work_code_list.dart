import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/health_report/bloc/health_report_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_code/bloc/work_code_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';

import 'create_work_code.dart';

class WorkCodeListPage extends StatefulWidget {
  @override
  _WorkCodeListPageState createState() => _WorkCodeListPageState();
}

class _WorkCodeListPageState extends State<WorkCodeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          NavigatorHelper(context).goTo(
            CreateWorkCode(),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Çalışma Kodları'),
      ),
      body: BlocBuilder<WorkCodeBloc, WorkCodeState>(
        builder: (BuildContext context, state) {
          if (state is WorkCodeLoadedState) {
            return ListView.builder(
                itemCount: state.apiWorkCode.data.length,
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
                              "${state.apiWorkCode.data[index].companyName}"),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  _buildContainer(
                                    color: Colors.grey[200],
                                    key: "Çalışan İsmi",
                                    value:
                                        "${state.apiWorkCode.data[index].userFullName}",
                                  ),
                                  _buildContainer(
                                    key: "Departman",
                                    value:
                                        "${state.apiWorkCode.data[index].department}",
                                  ),
                                  _buildContainer(
                                    color: Colors.grey[200],
                                    key: "Çalışma Kodu",
                                    value:
                                        "${state.apiWorkCode.data[index].workCode}",
                                  ),
                                  _buildContainer(
                                    key: "Başlangıç tarihi",
                                    value:
                                        "${DateHelper.getStringDateTR(state.apiWorkCode.data[index].startDate)}",
                                  ),
                                  _buildContainer(
                                    color: Colors.grey[200],
                                    key: "Bitiş tarihi",
                                    value:
                                        "${DateHelper.getStringDateTR(state.apiWorkCode.data[index].expirationDate)}",
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
          if (state is WorkCodeInitialState) {
            BlocProvider.of<WorkCodeBloc>(context).add(
              GetWorkCodeEvent(),
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
