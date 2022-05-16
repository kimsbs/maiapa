import 'package:chat_pr/value_and_struct.dart';

Disease check_valid(String text) {
  String init_txt = "[질병] 혹은 [진료기관]를 입력해주시면, 주변의 병원을 추천해 드릴게요!";

  if (text == "/도움")
    return Disease(init_txt, 4);
  //case 1 : 특이질환 리스트 내부.
  else if (special.indexOf(text) != -1)
    return Disease(text, 1);
  //case 2 : 일반 진료(내과 등등) 리스트 내부.
  else if (normal.indexOf(text) != -1)
    return Disease(text, 2);
  //case 3 : 질병에 따른 진단과 매칭 후, case 1, 2에 해당되는지?;
  //case 4 : wrong input
  else
    return Disease("질병 혹은 진료기관을 입력해 주세요!\nex) 화상, 내과", 3);
}