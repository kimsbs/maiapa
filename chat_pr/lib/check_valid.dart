import 'package:tuple/tuple.dart';
//1. 특이질환 2. 진단과 3. 질병이 아닐경우 "오류" return;
//만약 질병일경우, 진단과로 매칭.
Tuple2<String, bool> Is_rightInput(String text) {
  if (text == "지도")
    return Tuple2(text, true);
  else
    return Tuple2("질병 혹은 진료 기관을 입력해 주세요!\nex) 내과, 지도", false);
}