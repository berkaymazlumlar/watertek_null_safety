import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_order_list/work_order_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_work_order.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/create_work_order.dart';
import 'package:teknoloji_kimya_servis/pages/work_order/show_work_order_detail.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/work_order_repository/work_order_repository.dart';
import 'package:teknoloji_kimya_servis/utils/debouncer.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class WorkerWorkOrderListPage extends StatefulWidget {
  WorkerWorkOrderListPage({Key key}) : super(key: key);

  @override
  _WorkerWorkOrderListPageState createState() =>
      _WorkerWorkOrderListPageState();
}

class _WorkerWorkOrderListPageState extends State<WorkerWorkOrderListPage> {
  WorkOrderListBloc _workOrderListBloc;
  WorkOrderRepository _workOrderRepository = locator<WorkOrderRepository>();
  AuthRepository _authRepository = locator<AuthRepository>();

  final Debouncer _debouncer = Debouncer();
  bool _isFirstOpening = true;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _workOrderListBloc = BlocProvider.of<WorkOrderListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching
          ? _searchAppBar(context)
          : _isFirstOpening
              ? _appBar(context)
              : _animatedAppBar(context),
      body: BlocBuilder(
        cubit: _workOrderListBloc,
        builder: (BuildContext context, state) {
          if (state is WorkOrderListInitialState) {
            print("WorkOrderInitialState girdim");
            _workOrderListBloc.add(
              GetWorkOrderListEvent(),
            );
          }
          if (state is WorkOrderListLoadedState) {
            print(state.workOrderList.data.length);
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<WorkOrderListBloc>(context)
                    .add(ClearWorkOrderListEvent());
                return Future.delayed(
                  Duration(milliseconds: 300),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: !isWorkOrderEmpty(state.workOrderList.data)
                    ? Center(
                        child: Text(
                          "Adınıza oluşturulmuş bir iş emri bulunmamakta.",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.workOrderList.data.length,
                        itemBuilder: (context, index) {
                          if (state.workOrderList.data[index].userId !=
                              _authRepository.apiUser.data.id) {
                            return Container();
                          }
                          return Card(
                            elevation: 2,
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
                                child: ListTile(
                                  onTap: () {
                                    _workOrderRepository.apiWorkOrderData =
                                        state.workOrderList.data[index];
                                    NavigatorHelper(context).goTo(
                                      ShowWorkOrderDetail(),
                                    );
                                  },
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Müşteri Adı: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "${state.workOrderList.data[index].companyName}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    DateHelper.getStringDateHourTR(state
                                        .workOrderList.data[index].taskDate),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            );
          }
          if (state is WorkOrderListErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("İş emri bulunamadı"),
                  RaisedButton(
                    child: Text("Yeniden dene"),
                    onPressed: () {
                      _workOrderListBloc.add(
                        ClearWorkOrderListEvent(),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigatorHelper(context).goTo(
            CreateWorkOrder(),
          );
        },
        child: Icon(Icons.add),
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
              _workOrderListBloc.add(
                ClearWorkOrderListEvent(),
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
      title: Text("İş emirleri"),
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
      title: ElasticInLeft(child: Text("İş emirleri")),
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
      BlocProvider.of<WorkOrderListBloc>(context).add(
        SearchWorkOrderListEvent(search: value),
      );
    });
  }

  bool isWorkOrderEmpty(List<ApiWorkOrderData> items) {
    final _item = items.firstWhere(
      (element) => element.userId == _authRepository.apiUser.data.id,
      orElse: () => null,
    );
    return _item is ApiWorkOrderData;
  }
}
