import 'dart:io';

import 'package:chat_pr/model/history.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    History,
  ],
)
class LocalDatabase extends _$LocalDatabase{
  LocalDatabase(): super (_openConnection());

  Future<int> createHistory(HistoryCompanion data) => into(history).insert(data);

  Future<List<HistoryData>> getHistory() => select(history, distinct: true).get();

  Stream<List<HistoryData>> watchHistory() => select(history, distinct: true).watch();

  Future deleteHistory(data){return delete(history).delete(data);}

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection(){
  return LazyDatabase(()async{
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}