import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:teknoloji_kimya_servis/blocs/sale/sale_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/add/add_sale_page.dart';
import 'package:teknoloji_kimya_servis/pages/show/show_product_detail_page.dart';
import 'package:teknoloji_kimya_servis/repositories/sale/sale_repository.dart';
import 'package:teknoloji_kimya_servis/utils/debouncer.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

SaleListRepository _saleRepository = locator<SaleListRepository>();

class ShowSaleListPage extends StatefulWidget {
  ShowSaleListPage({Key key}) : super(key: key);

  @override
  _ShowSaleListPageState createState() => _ShowSaleListPageState();
}

class _ShowSaleListPageState extends State<ShowSaleListPage> {
  SaleBloc _saleBloc;
  final Debouncer _debouncer = Debouncer();
  bool _isFirstOpening = true;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _saleBloc = BlocProvider.of<SaleBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _isSearching
          ? _searchAppBar(context)
          : _isFirstOpening
              ? _appBar(context)
              : _animatedAppBar(context),
      body: BlocBuilder(
        cubit: _saleBloc,
        builder: (context, state) {
          if (state is SaleInitialState) {
            _saleBloc.add(GetSaleEvent());
          }
          if (state is SaleLoadedState) {
            if (state.sale.data.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Satış bilgisi yok"),
                    SizedBox(height: 8),
                    RaisedButton(
                      onPressed: () {
                        _saleBloc.add(ClearSaleEvent());
                      },
                      child: Text("Yeniden dene"),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                _saleBloc.add(ClearSaleEvent());
                return Future.delayed(
                  Duration(milliseconds: 300),
                );
              },
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: state.sale.data.length,
                itemBuilder: (context, index) {
                  final _sale = state.sale.data[index];
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: [
                      Container(
                        color: Colors.red,
                        child: IconButton(
                          onPressed: () async {
                            try {
                              EralpHelper.startProgress();
                              await _saleRepository.deleteSale(
                                _sale.id.toString(),
                                context,
                              );
                            } finally {
                              EralpHelper.stopProgress();
                            }
                            BlocProvider.of<SaleBloc>(context).add(
                              ClearSaleEvent(),
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: _size.height * 0.0375,
                          ),
                        ),
                      ),
                    ],
                    child: Card(
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
                          child: ListTile(
                            onTap: () {
                              NavigatorHelper(context).goTo(ShowSaleDetailPage(
                                sale: _sale,
                              ));
                            },
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${_sale.productName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 12),
                                    CircleAvatar(
                                      radius: 4,
                                      // backgroundColor: Theme.of(context).primaryColor,
                                      backgroundColor: index % 3 == 0
                                          ? Colors.blue
                                          : index % 3 == 1
                                              ? Colors.orange
                                              : Colors.green,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "${_sale.productModel}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Müşteri Adı: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${_sale.companyName}"),
                                  ],
                                )
                              ],
                            ),
                            subtitle: Text(
                                "Oluşturulma tarihi: ${DateHelper.getStringDateHourTR(_sale.createdAt)}"),
                            // title: Text(
                            //     "Ürün ismi: ${_sale.productName}\n\nÜrün modeli: ${_sale.productModel}\n\nFirma:${_sale.companyName}\n\nOluşturulma tarihi: ${DateHelper.getStringDateHourTR(_sale.createdAt)}"),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          if (state is SaleFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Veri bulunamadı"),
                  SizedBox(height: 8),
                  Text(
                    "${state.error}",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  RaisedButton(
                    onPressed: () {
                      _saleBloc.add(ClearSaleEvent());
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigatorHelper(context).goTo(AddSalePage());
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
              _saleBloc.add(
                ClearSaleEvent(),
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
      title: Text("Satışlar"),
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
      title: ElasticInLeft(child: Text("Satışlar")),
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
      BlocProvider.of<SaleBloc>(context).add(
        SearchSaleEvent(search: value),
      );
    });
  }
}
