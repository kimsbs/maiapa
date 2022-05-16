import 'package:chat_pr/value_and_struct.dart';

Disease check_valid(String text) {
  String init_txt = "[질병] 혹은 [진료기관]를 입력해주시면, 주변의 병원을 추천해 드릴게요!";
  int i;
  int flag = 0;
  String disease_name = "";

  if (text == "/도움") {
    return Disease(init_txt, 4);
  }
  //case 1 : 특이질환 리스트 내부.
  else if (special.contains(text)) {
    return Disease(text, 1);
  }
  //case 2 : 일반 진료(내과 등등) 리스트 내부.
  else if (normal.contains(text)) {
    return Disease(text, 2);
  }
  //case 3 : 질병에 따른 진단과 매칭 후, case 1, 2에 해당되는지?;
  diagnosis.forEach((element) {
    if (flag == 0 && element[0] == text) {
      flag = 3;
      for (i = 1; i <= 3; i++) {
        if (special.contains(element[i])) {
          flag = 1;
          disease_name = element[i];
        }
        else if (normal.contains(element[i])) {
          flag = 2;
          disease_name = element[i];
        }
      }
    }
  });
  if(flag == 3) { //case 3중 매칭된 병원이 없을경우
    return Disease("$text에 적합한 진단과가 없습니다.", 3);
  }
  else if(flag == 1 || flag == 2){ //case3중 매칭된 병원이있을경우
    return Disease(disease_name, flag);
  }//default
  return Disease("질병 혹은 진료기관을 입력해 주세요!\nex) 화상, 내과", 3);
}
