import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teknoloji_kimya_servis/blocs/user_list/user_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/worker_list/worker_list_bloc.dart';
import 'package:teknoloji_kimya_servis/models/api_company.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/providers/health_report_provider.dart';
import 'package:teknoloji_kimya_servis/providers/work_order_provider.dart';

class ChooseWorkerPage extends StatefulWidget {
  final Function(ApiUsersData myUser) myFunction;
  ChooseWorkerPage({Key key, this.myFunction}) : super(key: key);

  @override
  _ChooseWorkerPageState createState() => _ChooseWorkerPageState();
}

class _ChooseWorkerPageState extends State<ChooseWorkerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Çalışanlarım'),
      ),
      body: BlocBuilder<WorkerListBloc, WorkerListState>(
        builder: (context, state) {
          if (state is WorkerListInitialState) {
            BlocProvider.of<WorkerListBloc>(context).add(GetWorkerListEvent());
          }
          if (state is WorkerListLoadedState) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: state.userList.body.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    return widget.myFunction(state.userList.body[index]);
                    // if (widget.isHealthReport == false) {
                    //   Provider.of<WorkOrderProvider>(context, listen: false)
                    //       .myUser = state.userList.body[index];
                    //   Navigator.pop(context);
                    // } else {
                    //   Provider.of<HealthReportProvider>(context, listen: false)
                    //       .myUser = state.userList.body[index];
                    //   Navigator.pop(context);
                    // }
                  },
                  leading: CircleAvatar(
                    child: Text(
                      "${state.userList.body[index].fullName.toUpperCase().substring(0, 1)}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: index % 3 == 0
                        ? Colors.blue
                        : index % 3 == 1
                            ? Colors.green
                            : Colors.orange,
                  ),
                  title: Text("${state.userList.body[index].fullName}"),
                  subtitle: Text("${state.userList.body[index].phone}"),
                );
              },
            );
          }
          if (state is WorkerListErrorState) {
            return Center(
              child: Column(
                children: [
                  Text("${state.error}"),
                  SizedBox(height: 8),
                  RaisedButton(
                    onPressed: () {
                      BlocProvider.of<WorkerListBloc>(context)
                          .add(ClearWorkerListEvent());
                    },
                    child: Text("yeniden dene"),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
