import 'dart:convert';
import 'package:chat_pr/patient_info.dart';
import 'package:flutter/services.dart';

Future<void> findSimilar(String age, String sex, int Height, int Weight, String Complaints) async {
  Map<String, dynamic> map;
  List data;
  int i = 0;
  var jsonText = await rootBundle.loadString('asset/json/Symptom.json');
  map = jsonDecode(jsonText);
  data = map["case"];

  if((sex == "") || (Height == 0) || (Weight == 0) || (Complaints == "")){
    return ;
  }

  for(i=0;i<data.length;i++){
    if((data[i]["Sex"] == sex) && (data[i]["Height"] >= Height - 5) && (data[i]["Height"] <= Height + 5)
        && (data[i]["Weight"] >= Weight - 5) && (data[i]["Weight"] <= Weight + 5) && (data[i]["Chief complaint"].toString().contains(Complaints))){
      print("aaaa");
      print(Complaints);
      print(data[i]["Chief complaint"].toString());
      expDis = data[i]["level5/diagnosis"].toString();
      print(expDis);
      print("bbbb");
      break;
    }
  }

  List data2;
  var jsonText2 = await rootBundle.loadString('asset/json/Disease_info.json');
  map = jsonDecode(jsonText2);
  data2 = map["disease"];

  for(i=0;i<data2.length;i++){
    if(data2[i]["원 질병이름"] == expDis){
      hospToGo = data2[i]["진료과"];
      break;
    }
  }
}