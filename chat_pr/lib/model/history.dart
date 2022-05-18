import 'package:drift/drift.dart';

class History extends Table{
  //검색 날짜
  DateTimeColumn get date => dateTime().clientDefault(
        () => DateTime.now(),
  )();

  //병원 위도, 경도
  RealColumn get lat => real()();
  RealColumn get lng => real()();
}