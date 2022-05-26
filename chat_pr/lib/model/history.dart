import 'package:drift/drift.dart';

class History extends Table{
  // 검색 기록
  TextColumn get searchWord => text()();
  //병원 이름
  TextColumn get Hospital_name => text()();

  //병원 주소
  TextColumn get Hospital_addr => text()();

  //병원 위도, 경도
  RealColumn get lat => real()();
  RealColumn get lng => real()();

}