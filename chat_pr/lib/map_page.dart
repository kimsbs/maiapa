import 'package:chat_pr/value_and_struct.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'get_map_info.dart';

void Press_Map(BuildContext context, Disease d_val) async {
  if (flag == false) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });
    await getHospInfo(d_val);
    Navigator.of(context).pop();
  }
  Navigator.of(context).push(_createRoute_map(d_val));
}

Route _createRoute_map(Disease d_val) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => googleMap(
      d_val: d_val,
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
  googleMap({required this.d_val});

  Disease d_val;

  @override
  State<googleMap> createState() => _googleMapState(d_val: d_val);
}

class _googleMapState extends State<googleMap> {
  _googleMapState({required this.d_val});

  Disease d_val;

  GoogleMapController? mapController;

  final double zoom_value = 16.5;

  static LatLng initialLocation = LatLng(lat, lng);

  static CameraPosition initialPosition = CameraPosition(
    target: initialLocation,
    zoom: 16.5,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: flag == false
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
    mapController!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          location.latitude,
          location.longitude,
        ),
      ),
    );
  }
}
