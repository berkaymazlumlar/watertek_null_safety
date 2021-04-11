import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/spare_part_list/bloc/spare_part_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/models/spare_part.dart';
import 'package:teknoloji_kimya_servis/pages/spare_part/create_spare_part_page.dart';

class SparePartListPage extends StatefulWidget {
  @override
  _SparePartListPageState createState() => _SparePartListPageState();
}

class _SparePartListPageState extends State<SparePartListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          NavigatorHelper(context).goTo(
            CreateSparePartPage(),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Yedek Parçalar'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<SparePartListBloc>(context)
              .add(ClearSparePartListEvent());
          return Future.delayed(Duration(milliseconds: 300));
        },
        child: BlocBuilder<SparePartListBloc, SparePartListState>(
            builder: (context, state) {
          if (state is SparePartListLoadedState) {
            if (state.sparePartList.count == 0) {
              return Center(
                child: Text(
                  "Yedek parça bulunamadı, lütfen yedek parça ekleyin",
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              itemCount: state.sparePartList.count,
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
                      child: ListTile(
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Ürün Adı: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${state.sparePartList.body[index].productName} ${state.sparePartList.body[index].productModel}"),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Yedek Parça Adı: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("${state.sparePartList.body[index].name}"),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Yedek Parça Stok: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    " ${state.sparePartList.body[index].count} adet"),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Yedek Parça Birim Fiyat: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${state.sparePartList.body[index].price}₺"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (state is SparePartListInitialState) {
            BlocProvider.of<SparePartListBloc>(context)
                .add(GetSparePartListEvent());
          }
          if (state is SparePartListErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Yedek parça bulunamadı"),
                  RaisedButton(
                    child: Text("Yeniden Dene"),
                    onPressed: () {
                      BlocProvider.of<SparePartListBloc>(context).add(
                        ClearSparePartListEvent(),
                      );
                    },
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
