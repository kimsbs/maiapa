import 'package:google_maps_flutter/google_maps_flutter.dart';

const List<List<String>> disease_code_list = [
  ["00", "일반의"],
  ["01", "내과"],
  ["02", "신경과"],
  ["03", "정신건강의학과"],
  ["04", "외과"],
  ["05", "정형외과"],
  ["06", "신경외과"],
  ["07", "흉부외과"],
  ["08", "성형외과"],
  ["09", "마취통증의학과"],
  ["10", "산부인과"],
  ["11", "소아청소년과"],
  ["12", "안과"],
  ["13", "이비인후과"],
  ["14", "피부과"],
  ["15", "비뇨의학과"],
  ["16", "영상의학과"],
  ["17", "방사선종양학과"],
  ["18", "병리과"],
  ["19", "진단검사의학과"],
  ["20", "결핵과"],
  ["21", "재활의학과"],
  ["22", "핵의학과"],
  ["23", "가정의학과"],
  ["24", "응급의학과"],
  ["25", "직업환경의학과"],
  ["26", "예방의학과"],
  ["50", "구강악안면외과"],
  ["51", "치과보철과"],
  ["52", "치과교정과"],
  ["53", "소아치과"],
  ["54", "치주과"],
  ["55", "치과보존과"],
  ["56", "구강내과"],
  ["57", "영상치의학과"],
  ["58", "구강병리과"],
  ["59", "예방치과"],
  ["61", "통합치의학과"],
  ["80", "한방내과"],
  ["81", "한방부인과"],
  ["82", "한방소아과"],
  ["83", "한방안이비인후피부과"],
  ["84", "한방신경정신과"],
  ["85", "침구과"],
  ["86", "한방재활의학과"],
  ["87", "사상체질과"],
  ["88", "한방응급"]
];

//질병정보 구조체
class Disease {
  dynamic type;
  dynamic code;
  dynamic searched;

  Disease(var code, var type, var searched) {
    //name == disease_code -> api에 검색가능. (tpye가 1인 경우.)
    this.code = code;
    //type == 1 진단코드를 가지고있음,
    //type == 2 병에 맞는 진단과가 존재하지 않음.
    //tpye == 3 wrong input
    this.type = type;
    this.searched = searched;
  }
}

List<List<dynamic>> csv_data = [];
List<List<String>> diagnosis = [];
List<String> distance = ["1000", "3000", "5000", "10000"];

Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
bool flag = false;
double lat = 0;
double lng = 0;
