import 'package:chat_pr/findHosp.dart';
import 'package:chat_pr/value_and_struct.dart';
import 'package:chat_pr/patient_info.dart';

Disease check_valid(String text) {
  String init_txt = "병 진단을 원하시면 [진단],\n주변 병원 검색을 원하시면 [병원]를 입력해주세요!";
  String return_str = "";
  int i;
  int flag = 0;
  String disease_code = "";

  if (text == "/도움") {
    //needDiag = 0;
    return Disease(init_txt, 4, "");
  }
  // else if (text == "병원") {
  //   sex = ""; //성별
  //   age = ""; //나이 => 연령대로 입력 ex)40대, 50대
  //   Height = 0;
  //   Weight = 0; // 키, 몸무게 => 5단위 정수로 입력
  //   complaint = ""; //증상 ex)배가 아파요
  //   onset = ""; //증상 발현 시기 ex) 2일전, 3시간전
  //   location = ""; //증상 위치 ex) 명치, 복부
  //   Associated = ""; //추가 증상
  //   needDiag = 0;
  //   return Disease("질병 혹은 진단과를 입력해 주세요!\nex) 화상, 내과", 3, text);
  // }
  else if (text == "진단") {
    needDiag = 1; // 진단 항목으로 넘어갔음을 표시
    return Disease("성별을 입력해주세요!\nex) 남자, 여자", 3, text);
  }
  if (needDiag >= 1) {
    if (needDiag == 1 && (text == "남자" || text == "여자")) {
      //진단 과정
      needDiag = 2;
      sex = text;
      return_str = "연령대를 입력해주세요!\nex) 신생아, 유아, 영아, 20대, 40대";
      return Disease(return_str, 3, "");
    } else if (needDiag == 2) {
      if (text == "신생아" || text == "유아" || text == "영아") {
        age = text;
      } else if (text == "10대" ||
          text == "20대" ||
          text == "30대" ||
          text == "40대" ||
          text == "50대" ||
          text == "60대" ||
          text == "70대" ||
          text == "80대" ||
          text == "90대") {
        age = text.split('')[0] + text.split('')[1] + 's';
      }
      needDiag = 3;
      return_str = "키/몸무게 순으로 입력해주세요!\nex) 153/45, 160/55, 182/80";
      return Disease(return_str, 3, "");
    }
    //text.contains('/') && Height == 0 && Weight == 0
    else if (needDiag == 3) {
      needDiag = 4;
      Height = int.parse(text.split('/')[0]);
      Weight = int.parse(text.split('/')[1]);
      return_str =
          "증상과 증상이 나타난지 얼마나 됐는지 /로 구분하여 입력해주세요!\nex) 배가 아파요/2일전, 유방이 아파요/일주일전, 눈이 노래요/3일전";
      return Disease(return_str, 3, "");
    } else if (needDiag == 4 && text.contains('/')) {
      needDiag = 5;
      complaint = text.split('/')[0];
      onset = text.split('/')[1];
      return_str = "검사 중입니다. 잠시만 기다려 주세요.\n \"결과\" 입력시 주변 병원을 보여드릴게요";
      findSimilar(age, sex, Height, Weight, complaint);
      return Disease(return_str, 3, "");
    } else if (needDiag == 5) {
      if (text == "결과" && complaint != "" && hospToGo == "") {
        return_str = "유사한 항목을 찾을 수 없습니다.\n가까운 병원 방문을 권고합니다.";
        return Disease(return_str, 3, "");
      } else if (text == "결과" && hospToGo == "") {
        return_str = "아직 검사 중입니다. 잠시만 기다려 주세요.\n \"결과\" 입력시 주변 병원을 보여드릴게요";
        findSimilar(age, sex, Height, Weight, complaint);
        return Disease(return_str, 3, "");
      } else if (text == "결과" && hospToGo != "") {
        //case 1 : 리스트 내부.
        diagnosis.forEach((element) {
          if (flag == 0 && element[0] == expDis) {
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
        if (flag == 1) {
          return_str = "{$expDis}이(가) 예상됩니다. \n관련 병원을 지도에 보여드릴게요.";
          return Disease(disease_code, flag, "");
        } else {
          //case 3중 매칭된 병원이 없을경우
          return Disease("$expDis에 적합한 진단과가 없습니다.", 2, "");
        }
      }
    }
  }

  //case 1 : 리스트 내부.
  disease_code_list.forEach((element) {
    if (flag == 0 && element[1] == text) {
      flag = 1;
      disease_code = element[0];
    }
  });
  //case 3 : 질병에 따른 진단과 매칭 후, case 1, 2에 해당되는지?;
  if (flag == 0) {
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
  if (flag == 1) {
    return Disease(disease_code, flag, "");
  } else if (flag == 2) {
    //case 3중 매칭된 병원이 없을경우
    return Disease("$text에 적합한 진단과가 없습니다.", 2, "");
  } //default
  return Disease("질병 혹은 진단과를 입력해 주세요!\nex) 화상, 내과", 3, "");
}
