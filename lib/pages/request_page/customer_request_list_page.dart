import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/customer_request_list/bloc/customer_request_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/request_page/create_request_page.dart';
import 'package:teknoloji_kimya_servis/pages/request_page/request_detail_page.dart';
import 'package:teknoloji_kimya_servis/repositories/auth/auth_repository.dart';
import 'package:teknoloji_kimya_servis/repositories/user_repository/user_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';

UserListRepository userListRepository = locator<UserListRepository>();
AuthRepository _authRepository = locator<AuthRepository>();

class CustomerRequestListPage extends StatefulWidget {
  @override
  _CustomerRequestListPageState createState() =>
      _CustomerRequestListPageState();
}

class _CustomerRequestListPageState extends State<CustomerRequestListPage> {
  CustomerRequestListBloc _customerRequestListBloc;

  @override
  void initState() {
    super.initState();
    _customerRequestListBloc =
        BlocProvider.of<CustomerRequestListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taleplerim'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigatorHelper(context).goTo(
            CreateRequestPage(),
          );
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder(
        cubit: _customerRequestListBloc,
        builder: (context, state) {
          if (state is CustomerRequestListLoadedState) {
            if (state.apiCustomerRequestList == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Kayıtlı talebiniz bulunmamaktadır."),
                    SizedBox(),
                    ElevatedButton(
                      child: Text("Tekrar Dene"),
                      onPressed: () {
                        _customerRequestListBloc.add(
                          ClearCustomerRequestListEvent(),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                _customerRequestListBloc.add(ClearCustomerRequestListEvent());
                return Future.delayed(
                  Duration(milliseconds: 1000),
                );
              },
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: state.apiCustomerRequestList.body.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      NavigatorHelper(context).goTo(
                        RequestDetailPage(
                          apiCustomerRequestData:
                              state.apiCustomerRequestList.body[index],
                        ),
                      );
                    },
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Başlık: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${state.apiCustomerRequestList.body[index].title}",
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "Talep tarihi: ${DateHelper.getStringDateTR(state.apiCustomerRequestList.body[index].createdAt)}",
                    ),
                  );
                },
              ),
            );
          }
          if (state is CustomerRequestListErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Talep bulunamadı"),
                  ElevatedButton(
                    child: Text("Tekrar Dene"),
                    onPressed: () {
                      _customerRequestListBloc.add(
                        ClearCustomerRequestListEvent(),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          if (state is CustomerRequestListInitialState) {
            print("CustomerRequestInitialState girdim");
            _customerRequestListBloc.add(
              GetCustomerRequestListEvent(
                customerId: _authRepository.apiUser.data.id,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
