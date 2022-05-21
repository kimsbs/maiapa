import 'package:chat_pr/value_and_struct.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
double lat = 0;
double lng = 0;
bool flag=false;

void Press_Map(BuildContext context, Disease d_val) async {
  if(flag==false){
    await getHospInfo(d_val);
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

Future<void> getLocation() async {
  final location = await Geolocator.getCurrentPosition();

  MapFlg = false;
  lat = location.latitude;
  lng = location.longitude;
}

Future<void> setMarker(double lat,double lng,int index, String hospName,String addr,var telNo) async {
  if(telNo.runtimeType == String && telNo != ""){
    Marker marker = Marker(
      markerId: MarkerId(index.toString()),
      position: LatLng(lat,lng),
      infoWindow: InfoWindow( //popup info
        title: hospName,
        snippet: addr+telNo,
      ),
      onTap: (){

      },
    );
    MarkerId markerId = MarkerId(index.toString());
    markers[markerId] = marker;
  }
  else{
    Marker marker = Marker(
      markerId: MarkerId(index.toString()),
      position: LatLng(lat,lng),
      infoWindow: InfoWindow( //popup info
        title: hospName,
        snippet: addr,
      ),
      onTap: (){

      },
    );
    MarkerId markerId = MarkerId(index.toString());
    markers[markerId] = marker;
  }
}

Future<void> getHospInfo(Disease d_val) async {
  await getLocation();
  //api 호출을 위한 주소
  String apiAddr = "http://apis.data.go.kr/B551182/hospInfoService1/getHospBasisList1"
      +"?ServiceKey=u96Y%2FJMiV2PQH9eebpHHOGTDnvn%2BgLPsZkdYmDk%2BhsSK2Kzie24zvEuZRacAG%2FucPEIlUkwEUzD8DjNIKiDuRQ%3D%3D"
      +"&numOfRows=200&xPos="
      +lng.toString()
      +"&yPos="
      +lat.toString()
      +"&dgsbjtCd="
      +d_val.name
      +"&radius=1000&_type=json";

  print(d_val.name);

  http.Response response;//api 호출의 결과를 받기 위한 변수
  var data1;//api 호출을 통해 받은 정보를 json으로 바꾼 결과를 저장한다.
  try {
    response = await http.get(Uri.parse(apiAddr));//필요 api 호출
    data1 = jsonDecode(utf8.decode(response.bodyBytes));

    for(int i = 0 ; i < data1["response"]["body"]["items"]["item"].length ; i++){
      if((data1["response"]["body"]["items"]["item"][i]["YPos"] is double)
          &&(data1["response"]["body"]["items"]["item"][i]["XPos"] is double)) {
        await setMarker(data1["response"]["body"]["items"]["item"][i]["YPos"],
            data1["response"]["body"]["items"]["item"][i]["XPos"],
            i,
            data1["response"]["body"]["items"]["item"][i]["yadmNm"],
            data1["response"]["body"]["items"]["item"][i]["addr"],
            data1["response"]["body"]["items"]["item"][i]["telno"],);
      }
      else if(data1["response"]["body"]["items"]["item"][i]["YPos"] is double){
        print("XPos 값 이상 발견");
      }
      else if(data1["response"]["body"]["items"]["item"][i]["XPos"] is double){
        print("YPos 값 이상 발견");
      }
    }
  } catch (e) {
    print(e);
  }

  flag=true;
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

  final double zoom_value = 17.5;

  static LatLng initialLocation = LatLng(lat, lng);

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
