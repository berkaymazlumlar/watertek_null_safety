
import 'package:animate_do/animate_do.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:teknoloji_kimya_servis/blocs/periodic_maintenance_list/periodic_maintenance_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/context_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/pages/periodic_maintenance/periodic_maintenance_detail_page.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

AuthRepository _authRepository = locator<AuthRepository>();

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController = CalendarController();
  final Map<DateTime, List> _events = {};
  List _selectedEvents = [];
  var parser = EmojiParser();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PeriodicMaintenanceBloc>(context)
        .add(ClearPeriodicMaintenanceListEvent());
    BlocProvider.of<PeriodicMaintenanceBloc>(context).add(
      GetPeriodicMaintenanceListEvent(
        customerId: _authRepository.apiUser.data.isCustomer == 1
            ? _authRepository.apiUser.data.id
            : null,
      ),
    );
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PeriodicMaintenanceBloc, PeriodicMaintenanceState>(
      listener: (context, state) {
        if (state is PeriodicMaintenanceListLoadedState) {
          var newMap = groupBy(
            state.periodicMaintenanceList.body,
            (ApiPeriodicMaintenanceData obj) =>
                obj.firstPeriodDate.toString().substring(0, 10),
          );
          DateTime _addingDateTime;
          final List<String> _addingStrings = [];
          for (var i = 0; i < newMap.keys.length; i++) {
            _addingDateTime = DateTime.parse(newMap.keys.toList()[i]);
            for (var j = 0; j < newMap.values.toList()[i].length; j++) {
              final _periodicMaintenance = newMap.values.toList()[i][j];
              _addingDateTime = _getNextDateTime(
                _addingDateTime,
                _periodicMaintenance.period,
              );
              print("adding date time: $_addingDateTime");
              _addingStrings.add(
                  "${_periodicMaintenance.id},🔄  Periyodik bakım\n🏢  ${_periodicMaintenance.companyName}\n${parser.get(":telephone_receiver:").code}  ${_periodicMaintenance.companyPhone}");
            }
            if (_addingDateTime != null) {
              _events.addAll(
                {
                  _addingDateTime: _addingStrings.toSet().toList(),
                },
              );
            }

            _addingStrings.clear();
          }

          setState(() {});
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            // RaisedButton(
            //   onPressed: () {
            //     Get.snackbar(
            //       "title",
            //       "message",
            //       backgroundColor: Colors.blue.shade700.withOpacity(.3),
            //       snackPosition: SnackPosition.TOP,
            //       // colorText: Colors.white,
            //       icon: Icon(Icons.check),
            //       shouldIconPulse: true,
            //       margin: EdgeInsets.all(16),
            //       animationDuration: Duration(milliseconds: 1250),
            //       duration: Duration(milliseconds: 1500),
            //     );
            //     // Get.showSnackbar(
            //     //   GetBar(
            //     //     title: "title",
            //     //     message: "message",
            //     //   ),
            //     // );
            //     // var androidPlatformChannelSpecifics =
            //     //     AndroidNotificationDetails(
            //     //   '${DateTime.now().add(Duration(milliseconds: 505)).millisecondsSinceEpoch}',
            //     //   'weekly channel name example',
            //     //   'weekly channel desc example',
            //     // );
            //     // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
            //     // var platformChannelSpecifics = NotificationDetails(
            //     //   android: androidPlatformChannelSpecifics,
            //     //   iOS: iOSPlatformChannelSpecifics,
            //     // );

            //     // _localNotification.localNotificationsPlugin.show(
            //     //   19071905,
            //     //   "title",
            //     //   " body",
            //     //   platformChannelSpecifics,
            //     // );
            //   },
            //   child: Text("bildirim cikart"),
            // ),
            FadeIn(
              duration: Duration(milliseconds: 500),
              child: TableCalendar(
                headerStyle: HeaderStyle(
                    centerHeaderTitle: true, formatButtonVisible: false),
                onDaySelected: _onDaySelected,
                events: _events ?? null,
                locale: "tr_TR",
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarController: _calendarController,
                builders: CalendarBuilders(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(child: _buildEventList()),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map(
            (event) => InkWell(
              onTap: () {
                if (event.toString().contains("Periyodik")) {
                  final _id = event.toString().split(",").first;
                  Navigator.push(
                    ContextHelper().context,
                    MaterialPageRoute(
                      builder: (_) => PeriodicMaintenanceDetailPage(
                        id: _id,
                      ),
                    ),
                  );
                }
              },
              child: BounceInLeft(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.black26),
                      bottom: BorderSide(width: 0.5, color: Colors.black26),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "${_calendarController.selectedDay.day}\n${DateHelper.getStringMonth(_calendarController.selectedDay)}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            event.toString().substring(
                                  event.toString().indexOf(",") + 1,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  DateTime _getNextDateTime(DateTime _firstPeriodDate, int period) {
    print("first periodDate: $_firstPeriodDate");
    print("period: $period");

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
