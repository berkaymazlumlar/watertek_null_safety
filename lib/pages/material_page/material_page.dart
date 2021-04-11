import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/health_report/bloc/health_report_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/material_list/bloc/material_list_bloc.dart';
import 'package:teknoloji_kimya_servis/blocs/work_code/bloc/work_code_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';

import 'add_material_page.dart';

class MaterialListPage extends StatefulWidget {
  @override
  _MaterialListPageState createState() => _MaterialListPageState();
}

class _MaterialListPageState extends State<MaterialListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          NavigatorHelper(context).goTo(
            CreateMaterialPage(),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Sarf Malzemeler'),
      ),
      body: BlocBuilder<MaterialListBloc, MaterialListState>(
        builder: (BuildContext context, state) {
          if (state is MaterialListLoadedState) {
            return ListView.builder(
                itemCount: state.materialList.body.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
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
                          title: Text(
                              "${state.materialList.body[index].materialName} - ${state.materialList.body[index].materialModel}"),
                        ),
                      ),
                    ),
                  );
                });
          }
          if (state is MaterialListInitialState) {
            BlocProvider.of<MaterialListBloc>(context).add(
              GetMaterialListEvent(),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Container _buildContainer({String key, String value, Color color}) {
    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$key",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("$value"),
        ],
      ),
    );
  }
}
