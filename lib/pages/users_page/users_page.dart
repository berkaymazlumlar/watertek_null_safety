import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/user_list/user_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/user.dart';
import 'package:teknoloji_kimya_servis/pages/users_page/user_detail_page.dart';
import 'package:teknoloji_kimya_servis/repositories/user_repository/user_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/debouncer.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  UserListRepository _userListRepository = locator<UserListRepository>();
  final Debouncer _debouncer = Debouncer();
  bool _isSearching = false;
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
      appBar: _isSearching ? _searchAppBar(context) : _appBar(context),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListLoadedState) {
            if (state.userList.body.length == 0) {
              return Center(
                child: Text("Kullanıcı bulunamadı."),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<UserListBloc>(context)
                    .add(ClearUserListEvent());
                return Future.delayed(
                  Duration(milliseconds: 300),
                );
              },
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: state.userList.body.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        NavigatorHelper(context).goTo(
                          UserDetailPage(
                            user: state.userList.body[index],
                          ),
                        );
                      },
                      leading: state.userList.body[index].isAdmin == 1
                          ? Icon(
                              Icons.admin_panel_settings,
                              color: Theme.of(context).primaryColor,
                            )
                          : state.userList.body[index].isWorker == 1
                              ? Icon(
                                  Icons.handyman,
                                  color: Colors.blue.shade500,
                                )
                              : Icon(
                                  Icons.person,
                                  color: Colors.blue.shade300,
                                ),
                      title: Text("${state.userList.body[index].fullName}"),
                      subtitle: Text("${state.userList.body[index].phone}"),
                    ),
                  );
                },
              ),
            );
          }
          if (state is UserListErrorState) {
            return Column(
              children: [
                Text("Hata ${state.error}"),
                RaisedButton(onPressed: () {
                  BlocProvider.of<UserListBloc>(context)
                      .add(ClearUserListEvent());
                }),
              ],
            );
          }
          if (state is UserListInitialState) {
            BlocProvider.of<UserListBloc>(context).add(
              GetUserListEvent(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildLeading({bool isAdmin, bool isWorker, bool isCustomer}) {
    if (isAdmin == true) {
      return Icon(Icons.admin_panel_settings);
    }
    if (isWorker == true) {
      return Icon(Icons.handyman);
    }
    if (isCustomer == true) {
      return Icon(Icons.person);
    }
    return Icon(Icons.ac_unit);
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
              BlocProvider.of<UserListBloc>(context).add(
                ClearUserListEvent(),
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
      title: Text("Kullanıcılar"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _isSearching = true;
            setState(() {});
          },
        ),
      ],
      // title: Text('İş emirleri'),
    );
  }

  void _onChanged(String value) {
    _debouncer.debounce(() {
      BlocProvider.of<UserListBloc>(context).add(
        SearchUserListEvent(search: value),
      );
    });
  }
}
