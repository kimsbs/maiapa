import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void Press_Map(BuildContext context, String text) async{
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

  static LatLng initialLocation = LatLng(
      37.5023273,
      126.764252
  );

  static CameraPosition initialPosition = CameraPosition(
    target: initialLocation,
    zoom: 17,
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

  void getLocation(LatLng initialLocation,CameraPosition initialPosition) async{
    final location = await Geolocator.getCurrentPosition();

    mapController!.animateCamera(CameraUpdate.newLatLng(
      LatLng(
        location.latitude,
        location.longitude,
      ),
    )
    );

    initialLocation=LatLng(location.latitude,location.longitude);
    initialPosition = CameraPosition(
      target: LatLng(location.latitude,location.longitude),
      zoom: 55,
    );
    return ;
    }

  @override
  void initState(){
    super.initState();
    setState(() {
      getLocation(initialLocation,initialPosition);
      print('initState part');
      print(initialLocation);
      print(initialPosition);
    });
  }

  Future<String> moveLocation() async{
    if(mapController == null){
      return '에러';
    }

    final location = await Geolocator.getCurrentPosition();

    mapController!.animateCamera(CameraUpdate.newLatLng(
      LatLng(
        location.latitude,
        location.longitude,
      ),
    )
    );

    initialLocation=LatLng(location.latitude,location.longitude);
    initialPosition = CameraPosition(
      target: initialLocation,
      zoom: 25,
    );

    return '현재 위치 확인 완료';
  }

  @override
  Widget build(BuildContext context) {
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
    )
    );
  }

  onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if(!isLocationEnabled){
      return '위치 서비스를 활성화해주세요.';
    }

    LocationPermission  checkedPermission = await Geolocator.checkPermission();

    if(checkedPermission == LocationPermission.denied){
      checkedPermission = await Geolocator.requestPermission();

      if(checkedPermission == LocationPermission.denied){
        return '위치 권한을 허가해주세요.';
      }
    }

    if(checkedPermission == LocationPermission.deniedForever){
      return '설정에서 앱의 위치 권한을 허가해주세요.';
    }
    print('check Permission successed');
    return '위치 권한이 허가되었습니다.';
  }

  AppBar renderAppBar(){
    return AppBar(
      title: Text(
        'Googlemap',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            if(mapController == null){
              return;
            }
            final location = await Geolocator.getCurrentPosition();

            mapController!.animateCamera(CameraUpdate.newLatLng(
              LatLng(
                location.latitude,
                location.longitude,
              ),
            )
            );

          },
          color: Colors.blue,
          icon: Icon(
              Icons.my_location
          ),
        )
      ],
    );
  }
}
