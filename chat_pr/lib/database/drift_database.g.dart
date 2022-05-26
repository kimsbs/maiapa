// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class HistoryData extends DataClass implements Insertable<HistoryData> {
  final String searchWord;
  final String Hospital_name;
  final String Hospital_addr;
  final double lat;
  final double lng;
  HistoryData(
      {required this.searchWord,
      required this.Hospital_name,
      required this.Hospital_addr,
      required this.lat,
      required this.lng});
  factory HistoryData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return HistoryData(
      searchWord: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}search_word'])!,
      Hospital_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hospital_name'])!,
      Hospital_addr: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hospital_addr'])!,
      lat: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat'])!,
      lng: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lng'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['search_word'] = Variable<String>(searchWord);
    map['hospital_name'] = Variable<String>(Hospital_name);
    map['hospital_addr'] = Variable<String>(Hospital_addr);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    return map;
  }

  HistoryCompanion toCompanion(bool nullToAbsent) {
    return HistoryCompanion(
      searchWord: Value(searchWord),
      Hospital_name: Value(Hospital_name),
      Hospital_addr: Value(Hospital_addr),
      lat: Value(lat),
      lng: Value(lng),
    );
  }

  factory HistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryData(
      searchWord: serializer.fromJson<String>(json['searchWord']),
      Hospital_name: serializer.fromJson<String>(json['Hospital_name']),
      Hospital_addr: serializer.fromJson<String>(json['Hospital_addr']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'searchWord': serializer.toJson<String>(searchWord),
      'Hospital_name': serializer.toJson<String>(Hospital_name),
      'Hospital_addr': serializer.toJson<String>(Hospital_addr),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
    };
  }

  HistoryData copyWith(
          {String? searchWord,
          String? Hospital_name,
          String? Hospital_addr,
          double? lat,
          double? lng}) =>
      HistoryData(
        searchWord: searchWord ?? this.searchWord,
        Hospital_name: Hospital_name ?? this.Hospital_name,
        Hospital_addr: Hospital_addr ?? this.Hospital_addr,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );
  @override
  String toString() {
    return (StringBuffer('HistoryData(')
          ..write('searchWord: $searchWord, ')
          ..write('Hospital_name: $Hospital_name, ')
          ..write('Hospital_addr: $Hospital_addr, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(searchWord, Hospital_name, Hospital_addr, lat, lng);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryData &&
          other.searchWord == this.searchWord &&
          other.Hospital_name == this.Hospital_name &&
          other.Hospital_addr == this.Hospital_addr &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class HistoryCompanion extends UpdateCompanion<HistoryData> {
  final Value<String> searchWord;
  final Value<String> Hospital_name;
  final Value<String> Hospital_addr;
  final Value<double> lat;
  final Value<double> lng;
  const HistoryCompanion({
    this.searchWord = const Value.absent(),
    this.Hospital_name = const Value.absent(),
    this.Hospital_addr = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
  });
  HistoryCompanion.insert({
    required String searchWord,
    required String Hospital_name,
    required String Hospital_addr,
    required double lat,
    required double lng,
  })  : searchWord = Value(searchWord),
        Hospital_name = Value(Hospital_name),
        Hospital_addr = Value(Hospital_addr),
        lat = Value(lat),
        lng = Value(lng);
  static Insertable<HistoryData> custom({
    Expression<String>? searchWord,
    Expression<String>? Hospital_name,
    Expression<String>? Hospital_addr,
    Expression<double>? lat,
    Expression<double>? lng,
  }) {
    return RawValuesInsertable({
      if (searchWord != null) 'search_word': searchWord,
      if (Hospital_name != null) 'hospital_name': Hospital_name,
      if (Hospital_addr != null) 'hospital_addr': Hospital_addr,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    });
  }

  HistoryCompanion copyWith(
      {Value<String>? searchWord,
      Value<String>? Hospital_name,
      Value<String>? Hospital_addr,
      Value<double>? lat,
      Value<double>? lng}) {
    return HistoryCompanion(
      searchWord: searchWord ?? this.searchWord,
      Hospital_name: Hospital_name ?? this.Hospital_name,
      Hospital_addr: Hospital_addr ?? this.Hospital_addr,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (searchWord.present) {
      map['search_word'] = Variable<String>(searchWord.value);
    }
    if (Hospital_name.present) {
      map['hospital_name'] = Variable<String>(Hospital_name.value);
    }
    if (Hospital_addr.present) {
      map['hospital_addr'] = Variable<String>(Hospital_addr.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryCompanion(')
          ..write('searchWord: $searchWord, ')
          ..write('Hospital_name: $Hospital_name, ')
          ..write('Hospital_addr: $Hospital_addr, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }
}

class $HistoryTable extends History with TableInfo<$HistoryTable, HistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _searchWordMeta = const VerificationMeta('searchWord');
  @override
  late final GeneratedColumn<String?> searchWord = GeneratedColumn<String?>(
      'search_word', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _Hospital_nameMeta =
      const VerificationMeta('Hospital_name');
  @override
  late final GeneratedColumn<String?> Hospital_name = GeneratedColumn<String?>(
      'hospital_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _Hospital_addrMeta =
      const VerificationMeta('Hospital_addr');
  @override
  late final GeneratedColumn<String?> Hospital_addr = GeneratedColumn<String?>(
      'hospital_addr', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double?> lat = GeneratedColumn<double?>(
      'lat', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double?> lng = GeneratedColumn<double?>(
      'lng', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [searchWord, Hospital_name, Hospital_addr, lat, lng];
  @override
  String get aliasedName => _alias ?? 'history';
  @override
  String get actualTableName => 'history';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('search_word')) {
      context.handle(
          _searchWordMeta,
          searchWord.isAcceptableOrUnknown(
              data['search_word']!, _searchWordMeta));
    } else if (isInserting) {
      context.missing(_searchWordMeta);
    }
    if (data.containsKey('hospital_name')) {
      context.handle(
          _Hospital_nameMeta,
          Hospital_name.isAcceptableOrUnknown(
              data['hospital_name']!, _Hospital_nameMeta));
    } else if (isInserting) {
      context.missing(_Hospital_nameMeta);
    }
    if (data.containsKey('hospital_addr')) {
      context.handle(
          _Hospital_addrMeta,
          Hospital_addr.isAcceptableOrUnknown(
              data['hospital_addr']!, _Hospital_addrMeta));
    } else if (isInserting) {
      context.missing(_Hospital_addrMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {searchWord, Hospital_name, Hospital_addr};
  @override
  HistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return HistoryData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HistoryTable createAlias(String alias) {
    return $HistoryTable(attachedDatabase, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $HistoryTable history = $HistoryTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [history];
}
