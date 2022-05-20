import 'package:chat_pr/value_and_struct.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
HospInfo? hospInfo;

void Press_Map(BuildContext context, Disease d_val) async {
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

class HospInfo {
  final String name;//병원명
  final String addr;//주소
  final String phNum;//전화번호
  final String homepg;//홈페이지
  final double lng;//경도
  final double lat;//위도

  HospInfo({
    required this.name,
    required this.addr,
    required this.phNum,
    required this.homepg,
    required this.lng,
    required this.lat,
  });
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

  void setMarker(double lat,double lng,int index) {
    Marker marker = Marker(
      markerId: MarkerId(index.toString()),
      position: LatLng(lat,lng),
    );
    MarkerId markerId = MarkerId(index.toString());
    markers[markerId] = marker;
  }

  Future<void> getHospInfo() async {
    //api 호출을 위한 주소
    String apiAddr = "http://apis.data.go.kr/B551182/hospInfoService1/getHospBasisList1"
        +"?ServiceKey=u96Y%2FJMiV2PQH9eebpHHOGTDnvn%2BgLPsZkdYmDk%2BhsSK2Kzie24zvEuZRacAG%2FucPEIlUkwEUzD8DjNIKiDuRQ%3D%3D"
        +"&numOfRows=200&xPos="
        +lng.toString()
        +"&yPos="
        +lat.toString()
        +"&radius=500&_type=json";

    http.Response response;//api 호출의 결과를 받기 위한 변수
    var data1;//api 호출을 통해 받은 정보를 json으로 바꾼 결과를 저장한다.
    try {
      response = await http.get(Uri.parse(apiAddr));//필요 api 호출
      data1 = jsonDecode(utf8.decode(response.bodyBytes));

      /*
      hospInfo = HospInfo(
          name: data1["response"]["body"]["items"]["item"][0]["yadmNm"],
          addr: data1["response"]["body"]["items"]["item"][0]["addr"],
          phNum: data1["response"]["body"]["items"]["item"][0]["telno"],
          homepg: data1["response"]["body"]["items"]["item"][0]["hospUrl"],
          lng: data1["response"]["body"]["items"]["item"][0]["XPos"],
          lat: data1["response"]["body"]["items"]["item"][0]["YPos"],
      );*/

      for(int i = 0 ; i < data1["response"]["body"]["items"]["item"].length ; i++){
        if((data1["response"]["body"]["items"]["item"][i]["YPos"] is double)
            &&(data1["response"]["body"]["items"]["item"][i]["XPos"] is double)) {
          setMarker(data1["response"]["body"]["items"]["item"][i]["YPos"], data1["response"]["body"]["items"]["item"][i]["XPos"],i);
        }
        else if(data1["response"]["body"]["items"]["item"][i]["YPos"] is double){
          print("XPos 값 이상 발견");
        }
        else if(data1["response"]["body"]["items"]["item"][i]["XPos"] is double){
          print("YPos 값 이상 발견");
        }
      }

      setState(() {MapFlg = true;});
    } catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    // 부모의 initState호출
    super.initState();
    // 이 클래스애 리스너 추가
    getHospInfo();
  }
  // Future<void> getLocation() async {
  //   final location = await Geolocator.getCurrentPosition();
  //
  //   print(d_val.name);
  //   lat = location.latitude;
  //   lng = location.longitude;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: MapFlg == false
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
