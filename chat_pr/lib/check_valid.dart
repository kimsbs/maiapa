import 'package:chat_pr/value_and_struct.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:chat_pr/patient_info.dart';

Future<void> findSimilar() async {
  Map<String, dynamic> map;
  List data;
  var jsonText = await rootBundle.loadString('asset/json/Symptom.json');
  map = jsonDecode(jsonText);
  data = map["case"];
  print(data.length);
  print("aaaa");
  print(data[0]);
}

Disease check_valid(String text) {
  String init_txt = "병 진단을 원하시면 [진단],\n주변 병원 검색을 원하시면 [병원]를 입력해주세요!";
  String return_str = "";
  int i;
  int flag = 0;
  String disease_code = "";

  if (text == "/도움") {
    needDiag = 0;
    return Disease(init_txt, 4, text);
  }
  else if(text == "병원"){
    sex = ""; //성별
    age = "";  //나이 => 연령대로 입력 ex)40대, 50대
    Height = 0;
    Weight = 0; // 키, 몸무게 => 5단위 정수로 입력
    complaint = ""; //증상 ex)배가 아파요
    onset = ""; //증상 발현 시기 ex) 2일전, 3시간전
    location = ""; //증상 위치 ex) 명치, 복부
    Associated = ""; //추가 증상
    needDiag = 0;
    return Disease("질병 혹은 진단과를 입력해 주세요!\nex) 화상, 내과", 3, text);
  }

  else if(text == "진단"){
    needDiag = 1; // 진단 항목으로 넘어갔음을 표시
    return Disease("성별을 입력해주세요!\nex) 남성, 여성", 3, text);
  }
  else if(needDiag >= 1){//진단 과정
    switch(needDiag)
    {
      case 1:
        sex = text;
        needDiag = 2;
        return_str ="연령대를 입력해주세요!\nex) 신생아, 유아, 영아, 20대, 40대";
        break;
      case 2:
        if(text == "신생아" || text == "유아" || text == "영아"){
          age = text;
        }
        else {
          print(text.split('')[0] + text.split('')[1] + 's');
          age = text.split('')[0] + text.split('')[1] + 's';
        }
        needDiag = 3;
        return_str = "키/몸무게 순으로 입력해주세요!\nex) 153/45, 160/55, 182/80";
        break ;
      case 3:
        Height = int.parse(text.split('/')[0]);
        Weight = int.parse(text.split('/')[1]);
        needDiag = 4;
        return_str = "증상을 입력해주세요!\nex) 배가 아파요, 유방이 아파요, 눈이 노래요";
        break ;
      case 4:
        complaint = text;
        needDiag = 5;
        return_str = "증상이 나타난지 얼마나 됐는지 입력해주세요!\nex) 2일전, 3시간전";
        break ;
      case 5:
        onset = text;
        needDiag = 6;
        return_str = "증상 위치를 입력해주세요!\nex) 눈, 전신, 유방, 얼굴, 없음";
        break ;
      case 6:
        location = text;
        needDiag = 7;
        return_str = "또 다른 증상이 있으면 입력해주세요!\nex) 두통, 어지러움, 유방 통증, 없음";
        break ;
      case 7:
        Associated = text;
        findSimilar();
        needDiag = 0;
        return_str = "진단 끝";
        break ;
    }
    return Disease(return_str, 3, text);
  }

  //case 1 : 리스트 내부.
  disease_code_list.forEach((element) {
    if(flag == 0 && element[1] == text) {
      flag = 1;
      disease_code = element[0];
    }
  });
  //case 3 : 질병에 따른 진단과 매칭 후, case 1, 2에 해당되는지?;
  if(flag == 0) {
    diagnosis.forEach((element) {
      if (flag == 0 && element[0] == text) {
        flag = 2;
        for (i = 1; i <= 3; i++) {
          disease_code_list.forEach((dcl) {
            if (flag == 2 && dcl[1] == element[i]) {
              flag = 1;
              disease_code = dcl[0];
            }
          });
        }
      }
    });
  }
  if(flag == 1) {
    return Disease(disease_code, flag, text);
  }
  else if(flag == 2) { //case 3중 매칭된 병원이 없을경우
    return Disease("$text에 적합한 진단과가 없습니다.", 2, text);
  }//default
  return Disease("질병 혹은 진단과를 입력해 주세요!\nex) 화상, 내과", 3, text);
}
