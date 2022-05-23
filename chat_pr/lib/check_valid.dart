import 'package:chat_pr/value_and_struct.dart';

Disease check_valid(String text) {
  String init_txt = "[질병] 혹은 [진료기관]를 입력해주시면, 주변의 병원을 추천해 드릴게요!";
  int i;
  int flag = 0;
  String disease_code = "";

  if (text == "/도움") {
    return Disease(init_txt, 4, text);
  }
  //case 1 : 리스트 내부.
  disease_map.forEach((element) {
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
          disease_map.forEach((maps) {
            if (flag == 2 && maps[1] == element[i]) {
              flag = 1;
              disease_code = maps[0];
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
