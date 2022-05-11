import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void Press_Map(BuildContext context, String text) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => googleMap(),
    ),
  );
}

class googleMap extends StatefulWidget {
  const googleMap({Key? key}) : super(key: key);

  @override
  State<googleMap> createState() => _googleMapState();
}

class _googleMapState extends State<googleMap> {
  GoogleMapController? mapController;

  final double zoom_value = 17.5;
  static LatLng initialLocation = LatLng(37.5023273, 126.764252);

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

  static Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: initialLocation,
  );

  void getLocation() async {
    final location = await Geolocator.getCurrentPosition();

    mapController!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          location.latitude,
          location.longitude,
        ),
      ),
    );
    initialLocation = LatLng(location.latitude, location.longitude);
    initialPosition = CameraPosition(
      target: LatLng(location.latitude, location.longitude),
      zoom: zoom_value,
    );
    circle = Circle(
      circleId: CircleId('circle'),
      center: initialLocation,
      fillColor: Colors.blue.withOpacity(0.5),
      radius: distance,
      strokeColor: Colors.blue,
      strokeWidth: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
        appBar: renderAppBar(),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: initialPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          circles: Set.from([circle]),
          markers: Set.from([marker]),
          onMapCreated: onMapCreated,
        ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  AppBar renderAppBar() {
    return AppBar(
      title: const Text(
        'Googlemap',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: (){
            press_button();
          },
          color: Colors.blue,
          icon: const Icon(Icons.my_location),
        )
      ],
    );
  }

  void press_button() async{
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
