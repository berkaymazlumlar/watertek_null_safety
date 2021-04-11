import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/choose_user/choose_user_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/number_helper.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/utils/numeric_input_formatter.dart';

class ChooseUserPage extends StatefulWidget {
  final Function(ApiUsersData apiCompanyData) onCompanyChoosed;
  ChooseUserPage({Key key, @required this.onCompanyChoosed}) : super(key: key);

  @override
  _ChooseUserPageState createState() => _ChooseUserPageState();
}

class _ChooseUserPageState extends State<ChooseUserPage> {
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Müşteri seç'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<ChooseUserBloc>(context).add(
            GetChooseUserEvent(),
          );
          return Future.delayed(Duration(milliseconds: 300));
        },
        child: BlocBuilder<ChooseUserBloc, ChooseUserState>(
          builder: (context, state) {
            if (state is ChooseUserInitialState) {
              BlocProvider.of<ChooseUserBloc>(context).add(
                GetChooseUserEvent(),
              );
            }
            if (state is ChooseUserLoadedState) {
              if (state.userList.body.length == 0) {
                return Center(
                  child: Text(
                    "Firma bulunamadı, lütfen firma ekleyin",
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: state.userList.body.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      widget.onCompanyChoosed(
                        state.userList.body[index],
                      );
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
            if (state is ChooseUserErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${state.error}"),
                    RaisedButton(
                      onPressed: () {
                        BlocProvider.of<ChooseUserBloc>(context).add(
                          ClearChooseUserEvent(),
                        );
                      },
                      child: Text("Yeniden dene"),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future _showDialog() {
    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _companyNameController,
                    decoration: InputDecoration(
                      hintText: "Firma adı",
                      labelText: "Firma adı",
                      prefixIcon: Icon(Icons.shopping_bag_outlined),
                      // border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _phoneController,
                    inputFormatters: [NumericTextFormatter()],
                    decoration: InputDecoration(
                      hintText: "0 (___) ___ __ __",
                      labelText: "Telefon numarası",
                      prefixIcon: Icon(Icons.phone),
                      // border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                FlatButton(
                  onPressed: () async {
                    final _isSuccess = await PostApi.addCompany(
                      name: _companyNameController.text,
                      phone: NumberHelper.getStringNumberFromString(
                          _phoneController.text),
                    );
                    if (_isSuccess is bool) {
                      Navigator.pop(ctx);
                      BlocProvider.of<ChooseUserBloc>(context).add(
                        ClearChooseUserEvent(),
                      );
                      _companyNameController.text = "";
                      MyFlushbarHelper(context: context).showSuccessFlushbar(
                          message: "Firma başarıyla eklendi",
                          title: "Başarılı");
                    } else {
                      MyFlushbarHelper(context: context).showErrorFlushbar(
                          message: "Firma eklenemedi", title: "Hata");
                    }
                  },
                  child: Text("Ekle"),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
