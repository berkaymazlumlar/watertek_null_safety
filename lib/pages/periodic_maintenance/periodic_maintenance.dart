import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/periodic_maintenance_list/periodic_maintenance_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/periodic_maintenance/create_periodic_maintenance.dart';
import 'package:teknoloji_kimya_servis/utils/debouncer.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class PeriodicMaintenance extends StatefulWidget {
  @override
  _PeriodicMaintenanceState createState() => _PeriodicMaintenanceState();
}

class _PeriodicMaintenanceState extends State<PeriodicMaintenance> {
  final Debouncer _debouncer = Debouncer();
  bool _isSearching = false;
  bool _isFirstOpening = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching
          ? _searchAppBar(context)
          : _isFirstOpening
              ? _appBar(context)
              : _animatedAppBar(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          NavigatorHelper(context).goTo(CreatePeriodicMaintenance());
        },
      ),
      body: BlocBuilder<PeriodicMaintenanceBloc, PeriodicMaintenanceState>(
          builder: (context, state) {
        if (state is PeriodicMaintenanceListInitialState) {
          BlocProvider.of<PeriodicMaintenanceBloc>(context)
              .add(GetPeriodicMaintenanceListEvent());
        }
        if (state is PeriodicMaintenanceListLoadedState) {
          return RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<PeriodicMaintenanceBloc>(context)
                  .add(ClearPeriodicMaintenanceListEvent());
              return Future.delayed(
                Duration(milliseconds: 300),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: state.periodicMaintenanceList.body.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
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
                          title: Text(state
                              .periodicMaintenanceList.body[index].companyName),
                          children: [
                            Container(
                              child: buildContainer("Müşteri İsmi:",
                                  "${state.periodicMaintenanceList.body[index].companyName}"),
                            ),
                            Container(
                                color: Colors.grey[200],
                                child: buildContainer("Müşteri Numarası:",
                                    "${state.periodicMaintenanceList.body[index].companyPhone}")),
                            Container(
                                child: buildContainer("Oluşturulma Tarihi:",
                                    "${DateHelper.getStringDateTR(state.periodicMaintenanceList.body[index].createdAt)}")),
                            Container(
                                color: Colors.grey[200],
                                child: buildContainer("İlk Bakım Tarihi:",
                                    "${DateHelper.getStringDateTR(state.periodicMaintenanceList.body[index].firstPeriodDate)}")),
                            Container(
                                child: buildContainer("Bakım Periyodu:",
                                    "${state.periodicMaintenanceList.body[index].period}")),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        if (state is PeriodicMaintenanceListErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Periyodik bakım bulunamadı ${state.error}"),
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<PeriodicMaintenanceBloc>(context).add(
                      ClearPeriodicMaintenanceListEvent(),
                    );
                  },
                  child: Text("Yeniden dene"),
                ),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget buildContainer(String key, String value) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              key,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(value),
          ],
        ),
      ),
    );
  }

  AppBar _searchAppBar(BuildContext context) {
    return AppBar(
      title: Container(
        height: 40,
        child: MyTextField(
          textAlignVertical: TextAlignVertical.bottom,
          hintText: "Müşteri ismi",
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _isSearching = false;

              _searchController.text = "";
              BlocProvider.of<PeriodicMaintenanceBloc>(context).add(
                ClearPeriodicMaintenanceListEvent(),
              );
              FocusScope.of(context).unfocus();
              setState(() {});
            },
          ),
          autoFocus: true,
          controller: _searchController,
          onChanged: _onChanged,
        ),
      ),
      actions: [],
      // title: Text('İş emirleri'),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text("Periyodik Bakımlar"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _isFirstOpening = false;
            _isSearching = true;
            setState(() {});
          },
        ),
      ],
      // title: Text('İş emirleri'),
    );
  }

  AppBar _animatedAppBar(BuildContext context) {
    return AppBar(
      title: ElasticInLeft(child: Text("Periyodik Bakımlar")),
      actions: [
        ElasticInLeft(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _isSearching = true;
              setState(() {});
            },
          ),
        ),
      ],
      // title: Text('İş emirleri'),
    );
  }

  void _onChanged(String value) {
    _debouncer.debounce(() {
      BlocProvider.of<PeriodicMaintenanceBloc>(context).add(
        SearchPeriodicMaintenanceListEvent(search: value),
      );
    });
  }
}
