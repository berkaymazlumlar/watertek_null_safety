import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:teknoloji_kimya_servis/blocs/user_location_list/user_location_list_bloc.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/helpers/navigator_helper.dart';
import 'package:teknoloji_kimya_servis/pages/location/user_location_detail_page.dart';

class UserLocationListPage extends StatefulWidget {
  UserLocationListPage({Key key}) : super(key: key);

  @override
  _UserLocationListPageState createState() => _UserLocationListPageState();
}

class _UserLocationListPageState extends State<UserLocationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcı Konumları'),
      ),
      body: BlocBuilder<UserLocationListBloc, UserLocationListState>(
        builder: (context, state) {
          if (state is UserLocationListInitialState) {
            BlocProvider.of<UserLocationListBloc>(context).add(
              GetUserLocationListEvent(),
            );
          }
          if (state is UserLocationListSuccessState) {
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<UserLocationListBloc>(context).add(
                  ClearUserLocationListEvent(),
                );
                return Future.delayed(
                  Duration(milliseconds: 300),
                );
              },
              child: state.userLocationList.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Konum servisini kullanan kullanıcı bulunmamakta",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<UserLocationListBloc>(context)
                                  .add(
                                ClearUserLocationListEvent(),
                              );
                            },
                            child: Text("Sayfayı yenile"),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: state.userLocationList.length,
                      itemBuilder: (context, index) {
                        final _user = state.userLocationList[index];
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
                                  NavigatorHelper(context).goTo(
                                    UserLocationDetailPage(
                                      userLocation: _user,
                                    ),
                                  );
                                },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Çalışan Adı: \n",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("${_user.name}\n"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Son Güncelleme: \n",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "${DateHelper.getStringDateHourTR(_user.updatedAt)}\n"),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      "Son Görülen Adresi:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: FutureBuilder(
                                        future: getLocationNameFromLatLng(
                                          double.parse(_user.lat),
                                          double.parse(_user.lng),
                                        ),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.hasData) {
                                            return Text("${snapshot.data}");
                                          }
                                          return Text("Alınıyor...");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            );
          }
          if (state is UserLocationListFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Konum bulunamadı"),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<UserLocationListBloc>(context).add(
                        ClearUserLocationListEvent(),
                      );
                    },
                    child: Text("Yeniden dene"),
                  ),
                ],
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

  Future<String> getLocationNameFromLatLng(double lat, double lng) async {
    print("1");
    final coordinates = new Coordinates(lat, lng);
    print("2");
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print("3");
    final first = addresses.first;
    print("4");
    return "${first.addressLine}";
  }
}
