import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

double _lat = 0;
double _lng = 0;
bool _flg = false;
Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

void Press_Map(BuildContext context, String text) async {
  Navigator.of(context).push(_createRoute_map(text));
}

Route _createRoute_map(String text) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => googleMap(
      text: text,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class googleMap extends StatefulWidget {
  //text == 질병 혹은 진단과
  googleMap({required text});

  @override
  State<googleMap> createState() => _googleMapState();
}

class _googleMapState extends State<googleMap> {
  GoogleMapController? mapController;

  final double zoom_value = 17.5;

  static LatLng initialLocation = LatLng(_lat, _lng);

  static CameraPosition initialPosition = CameraPosition(
    target: initialLocation,
    zoom: 17.5,
  );

  static final double distance = 100;

  static Circle circle = Circle(
    circleId: CircleId('circle'),
    center: initialLocation,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: distance,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );

  //marker Set 집합을 만들어 marker를 저장한뒤, build에서 marker Set 내 marker들을 전부 추가하는 방식
  //현재는 DB에서 거리 계산하는 값을 가져오지 않아 position LatLng에 현재위치에서 임의의 거리에 있는 여러개 값들이 나오게끔 하는 식으로만 구현
  void setMarker() {
    for (int i = 0; i < 10; i++) {
      Marker marker = Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(initialLocation.latitude + (i * 0.0001),
            initialLocation.longitude + (i * 0.0001)),
      );
      MarkerId markerId = MarkerId(i.toString());
      markers[markerId] = marker;
    }
  }

  Future<void> getLocation() async {
    final location = await Geolocator.getCurrentPosition();

    _lat = location.latitude;
    _lng = location.longitude;
    setMarker();

    if (_flg == false) {
      setState(() {
        _flg = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
      appBar: renderAppBar(),
      body: _flg == false
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: initialPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              circles: Set.from([circle]),
              markers: Set<Marker>.of(markers.values),
              onMapCreated: onMapCreated,
            ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  AppBar renderAppBar() {
    return AppBar(
      title: const Center(
        child: Text(
          '지도',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Color(0xff00b050),
      actions: [
        IconButton(
          onPressed: () {
            press_button();
          },
          color: Colors.black,
          icon: const Icon(Icons.my_location),
        )
      ],
    );
  }

  void press_button() async {
    if (mapController == null) {
      return;
    }
    final location = await Geolocator.getCurrentPosition();
    mapController!.animateCamera(CameraUpdate.newLatLng(
      LatLng(
        location.latitude,
        location.longitude,
      ),
    ));
  }
}
