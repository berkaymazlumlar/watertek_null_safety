import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/exploration/exploration_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/exploration_report/add_exploration_report_page.dart';
import 'package:teknoloji_kimya_servis/pages/exploration_report/exploration_report_detail_page.dart';

class ExplorationReportPage extends StatefulWidget {
  ExplorationReportPage({Key key}) : super(key: key);

  @override
  _ExplorationReportPageState createState() => _ExplorationReportPageState();
}

class _ExplorationReportPageState extends State<ExplorationReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keşif Raporları'),
      ),
      body: BlocBuilder<ExplorationBloc, ExplorationState>(
        builder: (context, state) {
          if (state is ExplorationInitialState) {
            BlocProvider.of<ExplorationBloc>(context).add(
              GetExplorationEvent(),
            );
          }
          if (state is ExplorationLoadedState) {
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<ExplorationBloc>(context).add(
                  ClearExplorationEvent(),
                );
                return Future.delayed(
                  Duration(milliseconds: 500),
                );
              },
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: state.apiExploration.body.length,
                itemBuilder: (context, index) {
                  final _exploration = state.apiExploration.body[index];
                  return ListTile(
                    onTap: () {
                      NavigatorHelper(context).goTo(
                        ExplorationReportDetailPage(
                          apiExplorationData: _exploration,
                        ),
                      );
                    },
                    leading: Icon(Icons.search),
                    title: Text("${_exploration.companyName}"),
                    subtitle: Text(
                        "${DateHelper.getStringDateHourTR(_exploration.date)}"),
                  );
                },
              ),
            );
          }
          if (state is ExplorationErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Keşif Raporu bulunamadı"),
                  RaisedButton(
                    onPressed: () {
                      BlocProvider.of<ExplorationBloc>(context).add(
                        ClearExplorationEvent(),
                      );
                    },
                    child: Text("Yeniden dene"),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigatorHelper(context).goTo(
            AddExplorationReportPage(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
