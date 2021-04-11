import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:teknoloji_kimya_servis/api/post_apis.dart';
import 'package:teknoloji_kimya_servis/blocs/customer_list/customer_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/flushbar_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/number_helper.dart';
import 'package:teknoloji_kimya_servis/utils/numeric_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyListPage extends StatefulWidget {
  CompanyListPage({Key key}) : super(key: key);

  @override
  _CompanyListPageState createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool isTapped = false;
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FadeIn(
          duration: Duration(milliseconds: 500),
          child: Center(
            child: Text(
              'Müşteriler',
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline1.color),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<CustomerListBloc>(context).add(
            ClearCustomerListEvent(),
          );
          return Future.delayed(Duration(milliseconds: 300));
        },
        child: BlocBuilder<CustomerListBloc, CustomerListState>(
          builder: (context, state) {
            if (state is CustomerListInitialState) {
              BlocProvider.of<CustomerListBloc>(context).add(
                GetCustomerListEvent(),
              );
            }
            if (state is CustomerListLoadedState) {
              if (state.userList.body.length == 0) {
                return Center(
                  child: Text(
                    "Müşteri bulunamadı, lütfen ekleyin",
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return FadeIn(
                duration: Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: state.userList.body.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Slidable(
                          actionPane: SlidableScrollActionPane(),
                          actionExtentRatio: 0.15,
                          secondaryActions: [
                            IconButton(
                              icon: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                final url =
                                    "tel://+90${NumberHelper.getStringNumberFromString(state.userList.body[index].phone)}";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                          ],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
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
                              title: Text(
                                  "${state.userList.body[index].fullName}"),
                              subtitle:
                                  Text("${state.userList.body[index].phone}"),
                              trailing: Icon(Icons.arrow_left),
                              // trailing: isVisible
                              //     ? Row(
                              //         mainAxisSize: MainAxisSize.min,
                              //         children: [
                              //           IconButton(
                              //             icon: CircleAvatar(
                              //               backgroundColor: Colors.green,
                              //               child: Icon(
                              //                 Icons.phone,
                              //                 color: Colors.white,
                              //               ),
                              //             ),
                              //             onPressed: () async {
                              //               final url =
                              //                   "tel://+9${NumberHelper.getStringNumberFromString(state.companyList.body[index].phone)}";
                              //               if (await canLaunch(url)) {
                              //                 await launch(url);
                              //               } else {
                              //                 throw 'Could not launch $url';
                              //               }
                              //             },
                              //           ),
                              //           IconButton(
                              //             icon: CircleAvatar(
                              //               backgroundColor: Colors.red,
                              //               child: Icon(
                              //                 Icons.delete,
                              //                 color: Colors.white,
                              //               ),
                              //             ),
                              //             onPressed: () async {
                              //               await _companyListRepository
                              //                   .deleteCompany(
                              //                       state.companyList.body[index].id
                              //                           .toString(),
                              //                       context);
                              //               BlocProvider.of<CompanyListBloc>(context)
                              //                   .add(
                              //                 ClearCompanyListEvent(),
                              //               );
                              //             },
                              //           ),
                              //         ],
                              //       )
                              //     : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            if (state is CustomerListErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${state.error}"),
                    RaisedButton(
                      onPressed: () {
                        BlocProvider.of<CustomerListBloc>(context).add(
                          ClearCustomerListEvent(),
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
      // floatingActionButton: FadeIn(
      //   duration: Duration(milliseconds: 500),
      //   child: Padding(
      //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
      //     child: FloatingActionButton(
      //       onPressed: () {
      //         _showDialog();
      //       },
      //       child: Icon(Icons.add),
      //     ),
      //   ),
      // ),
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
                      hintText: "Müşteri adı",
                      labelText: "Müşteri adı",
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
                      BlocProvider.of<CustomerListBloc>(context).add(
                        ClearCustomerListEvent(),
                      );
                      _companyNameController.text = "";
                      MyFlushbarHelper(context: context).showSuccessFlushbar(
                          message: "Müşteri başarıyla eklendi",
                          title: "Başarılı");
                    } else {
                      MyFlushbarHelper(context: context).showErrorFlushbar(
                          message: "Müşteri eklenemedi", title: "Hata");
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
