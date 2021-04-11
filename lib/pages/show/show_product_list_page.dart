import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:teknoloji_kimya_servis/blocs/product_list/product_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/eralp_helper.dart';
import 'package:teknoloji_kimya_servis/repositories/product_list/product_list_repository.dart';
import 'package:teknoloji_kimya_servis/utils/debouncer.dart';
import 'package:teknoloji_kimya_servis/utils/locator.dart';
import 'package:teknoloji_kimya_servis/views/general/my_text_field.dart';

ProductListRepository _productListRepository = locator<ProductListRepository>();

class ShowProductListPage extends StatefulWidget {
  ShowProductListPage({Key key}) : super(key: key);

  @override
  _ShowProductListPageState createState() => _ShowProductListPageState();
}

class _ShowProductListPageState extends State<ShowProductListPage> {
  ProductListBloc _productListBloc;
  final Debouncer _debouncer = Debouncer();
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  bool _isFirstOpening = true;

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    _productListBloc = BlocProvider.of<ProductListBloc>(context);
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
        cubit: _productListBloc,
        builder: (context, state) {
          if (state is ProductListInitialState) {
            _productListBloc.add(GetProductListEvent());
          }
          if (state is ProductListLoadedState) {
            if (state.productList.count == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ürün yok"),
                    SizedBox(height: 8),
                    RaisedButton(
                      onPressed: () {
                        _productListBloc.add(ClearProductListEvent());
                      },
                      child: Text("Yeniden dene"),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                _productListBloc.add(ClearProductListEvent());
                return Future.delayed(
                  Duration(milliseconds: 300),
                );
              },
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: state.productList.count,
                itemBuilder: (context, index) {
                  final _product = state.productList.body[index];
                  return FadeIn(
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      secondaryActions: [
                        Container(
                          color: Colors.red,
                          child: IconButton(
                            onPressed: () async {
                              try {
                                EralpHelper.startProgress();
                                // await _productListRepository.deleteProduct(
                                //   _product.id,
                                //   context,
                                // );
                              } finally {
                                EralpHelper.stopProgress();
                              }
                              BlocProvider.of<ProductListBloc>(context).add(
                                ClearProductListEvent(),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
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
                              title: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${_product.name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                  Flexible(
                                    child: Text(
                                      "${_product.model}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              subtitle: Text(
                                  "Oluşturulma tarihi: ${DateHelper.getStringDateHourTR(_product.createdAt)}"),
                              // "Ürün ismi: ${_product.productName}\n\nÜrün modeli: ${_product.productModel}\n\nOluşturulma tarihi: ${DateHelper.getStringDateHourTR(_product.createdAt)}"
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          if (state is ProductListErrorState) {
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
                      _productListBloc.add(ClearProductListEvent());
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
          Navigator.pushNamed(context, "/addItemPage");
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
          hintText: "Ürün ismi",
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _isFirstOpening = false;
              _isSearching = false;
              _searchController.text = "";
              _productListBloc.add(
                ClearProductListEvent(),
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

  AppBar _animatedAppBar(BuildContext context) {
    return AppBar(
      title: ElasticInLeft(child: Text("Ürünler")),
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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text("Ürünler"),
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
      BlocProvider.of<ProductListBloc>(context).add(
        SearchProductListEvent(search: value),
      );
    });
  }
}
