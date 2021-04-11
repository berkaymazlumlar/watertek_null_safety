import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teknoloji_kimya_servis/helpers/date_helper.dart';
import 'package:teknoloji_kimya_servis/models/user_location_list.dart';

class UserLocationDetailPage extends StatefulWidget {
  final UserLocationList userLocation;
  UserLocationDetailPage({Key key, @required this.userLocation})
      : super(key: key);
  @override
  State<UserLocationDetailPage> createState() => UserLocationDetailPageState();
}

class UserLocationDetailPageState extends State<UserLocationDetailPage> {
  Completer<GoogleMapController> _controller = Completer();
  Timer _timer;
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  double _lat = 0;
  double _lng = 0;
  String _updatedAt = "";

  Future<void> _startTimer() async {
    final GoogleMapController controller = await _controller.future;
    await getLatLongThenMarkAndZoom(controller);
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) async {
        await getLatLongThenMarkAndZoom(controller);
      },
    );
  }

  Future getLatLongThenMarkAndZoom(GoogleMapController controller) async {
    final _response = await FirebaseFirestore.instance
        .collection("location")
        .doc(widget.userLocation.id)
        .get();

    setState(() {
      _lat = double.parse(_response["lat"]);
      _lng = double.parse(_response["lng"]);
      _updatedAt = DateHelper.getStringShortDateTR(
        DateTime.parse(
          _response["updatedAt"].toString(),
        ),
      );

      _markers.clear();
      _markers.add(
        Marker(
          infoWindow: InfoWindow(title: "${widget.userLocation.name}"),
          markerId: MarkerId(DateTime.now().millisecondsSinceEpoch.toString()),
          position: LatLng(
            double.parse(_response["lat"]),
            double.parse(_response["lng"]),
          ),
          icon: pinLocationIcon,
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _lat = double.parse(widget.userLocation.lat);
    _lng = double.parse(widget.userLocation.lng);
    _updatedAt = DateHelper.getStringShortDateTR(widget.userLocation.updatedAt);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konum ($_updatedAt)"),
      ),
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            double.parse(widget.userLocation.lat),
            double.parse(widget.userLocation.lng),
          ),
          zoom: 16,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          (await _controller.future).animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  _lat,
                  _lng,
                ),
                zoom: 16,
              ),
            ),
          );
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}
