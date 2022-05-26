import 'package:chat_pr/value_and_struct.dart';
import 'package:drift/drift.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'database/drift_database.dart';

Future<void> getLocation() async {
  final location = await Geolocator.getCurrentPosition();

  lat = location.latitude;
  lng = location.longitude;
}

Future<void> setMarker(double lat, double lng, int index, String hospName,
    String addr, var telNo, String schWord, BitmapDescriptor myMarker) async {
  Marker marker_set(String tmp) {
    return Marker(
      markerId: MarkerId(index.toString()),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        //popup info
        title: hospName,
        snippet: tmp,
      ),
      icon: myMarker,
        onTap: ()async {
          await GetIt.I<LocalDatabase>().createHistory(
              HistoryCompanion(
                searchWord: Value(schWord),
                Hospital_name: Value(hospName),
                Hospital_addr: Value(addr),
                lat: Value(lat),
                lng: Value(lng),
              )
          );
        },
    );
  }

  if (telNo.runtimeType == String && telNo != "") {
    Marker marker = marker_set(addr + telNo);
    MarkerId markerId = MarkerId(index.toString());
    markers[markerId] = marker;
  } else {
    Marker marker = marker_set(addr);
    MarkerId markerId = MarkerId(index.toString());
    markers[markerId] = marker;
  }
}

Future<void> data_to_setmarker(var data1, String searched) async {
  BitmapDescriptor myMarker = await BitmapDescriptor.fromAssetImage(
      //now img 70px. 꼴리는 거로 바꾸세욘,..,
      const ImageConfiguration(),
      "asset/img/r_marker.png");

  if (data1["response"]["body"]["totalCount"] == 1) {
    if (data1["response"]["body"]["items"]["item"]["YPos"] is String) {
      data1["response"]["body"]["items"]["item"]["YPos"] =
          double.parse(data1["response"]["body"]["items"]["item"]["YPos"]);
    }
    if (data1["response"]["body"]["items"]["item"]["XPos"] is String) {
      data1["response"]["body"]["items"]["item"]["XPos"] =
          double.parse(data1["response"]["body"]["items"]["item"]["XPos"]);
    }
    if ((data1["response"]["body"]["items"]["item"]["YPos"] is double) &&
        (data1["response"]["body"]["items"]["item"]["XPos"] is double)) {
      await setMarker(
          data1["response"]["body"]["items"]["item"]["YPos"],
          data1["response"]["body"]["items"]["item"]["XPos"],
          0,
          data1["response"]["body"]["items"]["item"]["yadmNm"],
          data1["response"]["body"]["items"]["item"]["addr"],
          data1["response"]["body"]["items"]["item"]["telno"],
          searched,
          myMarker);
    }
  } else {
    print(data1["response"]["body"]["totalCount"]);
    for (int i = 0;
        i < data1["response"]["body"]["totalCount"];
        i++) {
      if (data1["response"]["body"]["items"]["item"][i]["YPos"] is String) {
        data1["response"]["body"]["items"]["item"][i]["YPos"] =
            double.parse(data1["response"]["body"]["items"]["item"][i]["YPos"]);
      }
      if (data1["response"]["body"]["items"]["item"][i]["XPos"] is String) {
        data1["response"]["body"]["items"]["item"][i]["XPos"] =
            double.parse(data1["response"]["body"]["items"]["item"][i]["XPos"]);
      }
      await setMarker(
          data1["response"]["body"]["items"]["item"][i]["YPos"],
          data1["response"]["body"]["items"]["item"][i]["XPos"],
          i,
          data1["response"]["body"]["items"]["item"][i]["yadmNm"],
          data1["response"]["body"]["items"]["item"][i]["addr"],
          data1["response"]["body"]["items"]["item"][i]["telno"],
          searched,
          myMarker);
    }
  }
}

Future<void> getHospInfo(Disease d_val) async {
  await getLocation();
  String Servicekey =
      "u96Y%2FJMiV2PQH9eebpHHOGTDnvn%2BgLPsZkdYmDk%2BhsSK2Kzie24zvEuZRacAG%2FucPEIlUkwEUzD8DjNIKiDuRQ%3D%3D";
  int distance_cnt = -1;
  var data1; //api 호출을 위한 주소
  http.Response response; //api 호출의 결과를 받기 위한 변수
  do {
    String apiAddr =
        "http://apis.data.go.kr/B551182/hospInfoService1/getHospBasisList1" +
            "?ServiceKey=" +
            Servicekey +
            "&numOfRows=2000&xPos=" +
            lng.toString() +
            "&yPos=" +
            lat.toString() +
            "&dgsbjtCd=" +
            d_val.code +
            "&radius=" +
            distance[++distance_cnt] +
            "&_type=json";

    response = await http.get(Uri.parse(apiAddr)); //필요 api 호출
    data1 = jsonDecode(utf8.decode(response.bodyBytes));
  } while (distance_cnt < 4 && data1["response"]["body"]["totalCount"] == 0);
  try {
    await data_to_setmarker(data1, d_val.searched);
  } catch (e) {
    print(e);
  }

  flag = true;
}
