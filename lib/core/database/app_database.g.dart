// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ActivePlansTable extends ActivePlans
    with TableInfo<$ActivePlansTable, ActivePlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivePlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _memorizationAmountMeta =
      const VerificationMeta('memorizationAmount');
  @override
  late final GeneratedColumn<double> memorizationAmount =
      GeneratedColumn<double>('memorization_amount', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _memorizationUnitMeta =
      const VerificationMeta('memorizationUnit');
  @override
  late final GeneratedColumn<String> memorizationUnit = GeneratedColumn<String>(
      'memorization_unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewAmountMeta =
      const VerificationMeta('reviewAmount');
  @override
  late final GeneratedColumn<double> reviewAmount = GeneratedColumn<double>(
      'review_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _reviewUnitMeta =
      const VerificationMeta('reviewUnit');
  @override
  late final GeneratedColumn<String> reviewUnit = GeneratedColumn<String>(
      'review_unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _memorizationStartSurahMeta =
      const VerificationMeta('memorizationStartSurah');
  @override
  late final GeneratedColumn<int> memorizationStartSurah = GeneratedColumn<int>(
      'memorization_start_surah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _memorizationStartAyahMeta =
      const VerificationMeta('memorizationStartAyah');
  @override
  late final GeneratedColumn<int> memorizationStartAyah = GeneratedColumn<int>(
      'memorization_start_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentMemorizationSurahMeta =
      const VerificationMeta('currentMemorizationSurah');
  @override
  late final GeneratedColumn<int> currentMemorizationSurah =
      GeneratedColumn<int>('current_memorization_surah', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentMemorizationAyahMeta =
      const VerificationMeta('currentMemorizationAyah');
  @override
  late final GeneratedColumn<int> currentMemorizationAyah =
      GeneratedColumn<int>('current_memorization_ayah', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        status,
        memorizationAmount,
        memorizationUnit,
        reviewAmount,
        reviewUnit,
        memorizationStartSurah,
        memorizationStartAyah,
        currentMemorizationSurah,
        currentMemorizationAyah
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'active_plans';
  @override
  VerificationContext validateIntegrity(Insertable<ActivePlan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('memorization_amount')) {
      context.handle(
          _memorizationAmountMeta,
          memorizationAmount.isAcceptableOrUnknown(
              data['memorization_amount']!, _memorizationAmountMeta));
    } else if (isInserting) {
      context.missing(_memorizationAmountMeta);
    }
    if (data.containsKey('memorization_unit')) {
      context.handle(
          _memorizationUnitMeta,
          memorizationUnit.isAcceptableOrUnknown(
              data['memorization_unit']!, _memorizationUnitMeta));
    } else if (isInserting) {
      context.missing(_memorizationUnitMeta);
    }
    if (data.containsKey('review_amount')) {
      context.handle(
          _reviewAmountMeta,
          reviewAmount.isAcceptableOrUnknown(
              data['review_amount']!, _reviewAmountMeta));
    } else if (isInserting) {
      context.missing(_reviewAmountMeta);
    }
    if (data.containsKey('review_unit')) {
      context.handle(
          _reviewUnitMeta,
          reviewUnit.isAcceptableOrUnknown(
              data['review_unit']!, _reviewUnitMeta));
    } else if (isInserting) {
      context.missing(_reviewUnitMeta);
    }
    if (data.containsKey('memorization_start_surah')) {
      context.handle(
          _memorizationStartSurahMeta,
          memorizationStartSurah.isAcceptableOrUnknown(
              data['memorization_start_surah']!, _memorizationStartSurahMeta));
    } else if (isInserting) {
      context.missing(_memorizationStartSurahMeta);
    }
    if (data.containsKey('memorization_start_ayah')) {
      context.handle(
          _memorizationStartAyahMeta,
          memorizationStartAyah.isAcceptableOrUnknown(
              data['memorization_start_ayah']!, _memorizationStartAyahMeta));
    } else if (isInserting) {
      context.missing(_memorizationStartAyahMeta);
    }
    if (data.containsKey('current_memorization_surah')) {
      context.handle(
          _currentMemorizationSurahMeta,
          currentMemorizationSurah.isAcceptableOrUnknown(
              data['current_memorization_surah']!,
              _currentMemorizationSurahMeta));
    } else if (isInserting) {
      context.missing(_currentMemorizationSurahMeta);
    }
    if (data.containsKey('current_memorization_ayah')) {
      context.handle(
          _currentMemorizationAyahMeta,
          currentMemorizationAyah.isAcceptableOrUnknown(
              data['current_memorization_ayah']!,
              _currentMemorizationAyahMeta));
    } else if (isInserting) {
      context.missing(_currentMemorizationAyahMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivePlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivePlan(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      memorizationAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}memorization_amount'])!,
      memorizationUnit: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}memorization_unit'])!,
      reviewAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}review_amount'])!,
      reviewUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_unit'])!,
      memorizationStartSurah: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}memorization_start_surah'])!,
      memorizationStartAyah: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}memorization_start_ayah'])!,
      currentMemorizationSurah: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}current_memorization_surah'])!,
      currentMemorizationAyah: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}current_memorization_ayah'])!,
    );
  }

  @override
  $ActivePlansTable createAlias(String alias) {
    return $ActivePlansTable(attachedDatabase, alias);
  }
}

class ActivePlan extends DataClass implements Insertable<ActivePlan> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final double memorizationAmount;
  final String memorizationUnit;
  final double reviewAmount;
  final String reviewUnit;
  final int memorizationStartSurah;
  final int memorizationStartAyah;
  final int currentMemorizationSurah;
  final int currentMemorizationAyah;
  const ActivePlan(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.status,
      required this.memorizationAmount,
      required this.memorizationUnit,
      required this.reviewAmount,
      required this.reviewUnit,
      required this.memorizationStartSurah,
      required this.memorizationStartAyah,
      required this.currentMemorizationSurah,
      required this.currentMemorizationAyah});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['status'] = Variable<String>(status);
    map['memorization_amount'] = Variable<double>(memorizationAmount);
    map['memorization_unit'] = Variable<String>(memorizationUnit);
    map['review_amount'] = Variable<double>(reviewAmount);
    map['review_unit'] = Variable<String>(reviewUnit);
    map['memorization_start_surah'] = Variable<int>(memorizationStartSurah);
    map['memorization_start_ayah'] = Variable<int>(memorizationStartAyah);
    map['current_memorization_surah'] = Variable<int>(currentMemorizationSurah);
    map['current_memorization_ayah'] = Variable<int>(currentMemorizationAyah);
    return map;
  }

  ActivePlansCompanion toCompanion(bool nullToAbsent) {
    return ActivePlansCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      status: Value(status),
      memorizationAmount: Value(memorizationAmount),
      memorizationUnit: Value(memorizationUnit),
      reviewAmount: Value(reviewAmount),
      reviewUnit: Value(reviewUnit),
      memorizationStartSurah: Value(memorizationStartSurah),
      memorizationStartAyah: Value(memorizationStartAyah),
      currentMemorizationSurah: Value(currentMemorizationSurah),
      currentMemorizationAyah: Value(currentMemorizationAyah),
    );
  }

  factory ActivePlan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivePlan(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
      memorizationAmount:
          serializer.fromJson<double>(json['memorizationAmount']),
      memorizationUnit: serializer.fromJson<String>(json['memorizationUnit']),
      reviewAmount: serializer.fromJson<double>(json['reviewAmount']),
      reviewUnit: serializer.fromJson<String>(json['reviewUnit']),
      memorizationStartSurah:
          serializer.fromJson<int>(json['memorizationStartSurah']),
      memorizationStartAyah:
          serializer.fromJson<int>(json['memorizationStartAyah']),
      currentMemorizationSurah:
          serializer.fromJson<int>(json['currentMemorizationSurah']),
      currentMemorizationAyah:
          serializer.fromJson<int>(json['currentMemorizationAyah']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'status': serializer.toJson<String>(status),
      'memorizationAmount': serializer.toJson<double>(memorizationAmount),
      'memorizationUnit': serializer.toJson<String>(memorizationUnit),
      'reviewAmount': serializer.toJson<double>(reviewAmount),
      'reviewUnit': serializer.toJson<String>(reviewUnit),
      'memorizationStartSurah': serializer.toJson<int>(memorizationStartSurah),
      'memorizationStartAyah': serializer.toJson<int>(memorizationStartAyah),
      'currentMemorizationSurah':
          serializer.toJson<int>(currentMemorizationSurah),
      'currentMemorizationAyah':
          serializer.toJson<int>(currentMemorizationAyah),
    };
  }

  ActivePlan copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? status,
          double? memorizationAmount,
          String? memorizationUnit,
          double? reviewAmount,
          String? reviewUnit,
          int? memorizationStartSurah,
          int? memorizationStartAyah,
          int? currentMemorizationSurah,
          int? currentMemorizationAyah}) =>
      ActivePlan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        memorizationAmount: memorizationAmount ?? this.memorizationAmount,
        memorizationUnit: memorizationUnit ?? this.memorizationUnit,
        reviewAmount: reviewAmount ?? this.reviewAmount,
        reviewUnit: reviewUnit ?? this.reviewUnit,
        memorizationStartSurah:
            memorizationStartSurah ?? this.memorizationStartSurah,
        memorizationStartAyah:
            memorizationStartAyah ?? this.memorizationStartAyah,
        currentMemorizationSurah:
            currentMemorizationSurah ?? this.currentMemorizationSurah,
        currentMemorizationAyah:
            currentMemorizationAyah ?? this.currentMemorizationAyah,
      );
  ActivePlan copyWithCompanion(ActivePlansCompanion data) {
    return ActivePlan(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
      memorizationAmount: data.memorizationAmount.present
          ? data.memorizationAmount.value
          : this.memorizationAmount,
      memorizationUnit: data.memorizationUnit.present
          ? data.memorizationUnit.value
          : this.memorizationUnit,
      reviewAmount: data.reviewAmount.present
          ? data.reviewAmount.value
          : this.reviewAmount,
      reviewUnit:
          data.reviewUnit.present ? data.reviewUnit.value : this.reviewUnit,
      memorizationStartSurah: data.memorizationStartSurah.present
          ? data.memorizationStartSurah.value
          : this.memorizationStartSurah,
      memorizationStartAyah: data.memorizationStartAyah.present
          ? data.memorizationStartAyah.value
          : this.memorizationStartAyah,
      currentMemorizationSurah: data.currentMemorizationSurah.present
          ? data.currentMemorizationSurah.value
          : this.currentMemorizationSurah,
      currentMemorizationAyah: data.currentMemorizationAyah.present
          ? data.currentMemorizationAyah.value
          : this.currentMemorizationAyah,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivePlan(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('memorizationAmount: $memorizationAmount, ')
          ..write('memorizationUnit: $memorizationUnit, ')
          ..write('reviewAmount: $reviewAmount, ')
          ..write('reviewUnit: $reviewUnit, ')
          ..write('memorizationStartSurah: $memorizationStartSurah, ')
          ..write('memorizationStartAyah: $memorizationStartAyah, ')
          ..write('currentMemorizationSurah: $currentMemorizationSurah, ')
          ..write('currentMemorizationAyah: $currentMemorizationAyah')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      updatedAt,
      status,
      memorizationAmount,
      memorizationUnit,
      reviewAmount,
      reviewUnit,
      memorizationStartSurah,
      memorizationStartAyah,
      currentMemorizationSurah,
      currentMemorizationAyah);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivePlan &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status &&
          other.memorizationAmount == this.memorizationAmount &&
          other.memorizationUnit == this.memorizationUnit &&
          other.reviewAmount == this.reviewAmount &&
          other.reviewUnit == this.reviewUnit &&
          other.memorizationStartSurah == this.memorizationStartSurah &&
          other.memorizationStartAyah == this.memorizationStartAyah &&
          other.currentMemorizationSurah == this.currentMemorizationSurah &&
          other.currentMemorizationAyah == this.currentMemorizationAyah);
}

class ActivePlansCompanion extends UpdateCompanion<ActivePlan> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> status;
  final Value<double> memorizationAmount;
  final Value<String> memorizationUnit;
  final Value<double> reviewAmount;
  final Value<String> reviewUnit;
  final Value<int> memorizationStartSurah;
  final Value<int> memorizationStartAyah;
  final Value<int> currentMemorizationSurah;
  final Value<int> currentMemorizationAyah;
  final Value<int> rowid;
  const ActivePlansCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.memorizationAmount = const Value.absent(),
    this.memorizationUnit = const Value.absent(),
    this.reviewAmount = const Value.absent(),
    this.reviewUnit = const Value.absent(),
    this.memorizationStartSurah = const Value.absent(),
    this.memorizationStartAyah = const Value.absent(),
    this.currentMemorizationSurah = const Value.absent(),
    this.currentMemorizationAyah = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivePlansCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String status,
    required double memorizationAmount,
    required String memorizationUnit,
    required double reviewAmount,
    required String reviewUnit,
    required int memorizationStartSurah,
    required int memorizationStartAyah,
    required int currentMemorizationSurah,
    required int currentMemorizationAyah,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        status = Value(status),
        memorizationAmount = Value(memorizationAmount),
        memorizationUnit = Value(memorizationUnit),
        reviewAmount = Value(reviewAmount),
        reviewUnit = Value(reviewUnit),
        memorizationStartSurah = Value(memorizationStartSurah),
        memorizationStartAyah = Value(memorizationStartAyah),
        currentMemorizationSurah = Value(currentMemorizationSurah),
        currentMemorizationAyah = Value(currentMemorizationAyah);
  static Insertable<ActivePlan> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? status,
    Expression<double>? memorizationAmount,
    Expression<String>? memorizationUnit,
    Expression<double>? reviewAmount,
    Expression<String>? reviewUnit,
    Expression<int>? memorizationStartSurah,
    Expression<int>? memorizationStartAyah,
    Expression<int>? currentMemorizationSurah,
    Expression<int>? currentMemorizationAyah,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (memorizationAmount != null) 'memorization_amount': memorizationAmount,
      if (memorizationUnit != null) 'memorization_unit': memorizationUnit,
      if (reviewAmount != null) 'review_amount': reviewAmount,
      if (reviewUnit != null) 'review_unit': reviewUnit,
      if (memorizationStartSurah != null)
        'memorization_start_surah': memorizationStartSurah,
      if (memorizationStartAyah != null)
        'memorization_start_ayah': memorizationStartAyah,
      if (currentMemorizationSurah != null)
        'current_memorization_surah': currentMemorizationSurah,
      if (currentMemorizationAyah != null)
        'current_memorization_ayah': currentMemorizationAyah,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivePlansCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? status,
      Value<double>? memorizationAmount,
      Value<String>? memorizationUnit,
      Value<double>? reviewAmount,
      Value<String>? reviewUnit,
      Value<int>? memorizationStartSurah,
      Value<int>? memorizationStartAyah,
      Value<int>? currentMemorizationSurah,
      Value<int>? currentMemorizationAyah,
      Value<int>? rowid}) {
    return ActivePlansCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      memorizationAmount: memorizationAmount ?? this.memorizationAmount,
      memorizationUnit: memorizationUnit ?? this.memorizationUnit,
      reviewAmount: reviewAmount ?? this.reviewAmount,
      reviewUnit: reviewUnit ?? this.reviewUnit,
      memorizationStartSurah:
          memorizationStartSurah ?? this.memorizationStartSurah,
      memorizationStartAyah:
          memorizationStartAyah ?? this.memorizationStartAyah,
      currentMemorizationSurah:
          currentMemorizationSurah ?? this.currentMemorizationSurah,
      currentMemorizationAyah:
          currentMemorizationAyah ?? this.currentMemorizationAyah,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (memorizationAmount.present) {
      map['memorization_amount'] = Variable<double>(memorizationAmount.value);
    }
    if (memorizationUnit.present) {
      map['memorization_unit'] = Variable<String>(memorizationUnit.value);
    }
    if (reviewAmount.present) {
      map['review_amount'] = Variable<double>(reviewAmount.value);
    }
    if (reviewUnit.present) {
      map['review_unit'] = Variable<String>(reviewUnit.value);
    }
    if (memorizationStartSurah.present) {
      map['memorization_start_surah'] =
          Variable<int>(memorizationStartSurah.value);
    }
    if (memorizationStartAyah.present) {
      map['memorization_start_ayah'] =
          Variable<int>(memorizationStartAyah.value);
    }
    if (currentMemorizationSurah.present) {
      map['current_memorization_surah'] =
          Variable<int>(currentMemorizationSurah.value);
    }
    if (currentMemorizationAyah.present) {
      map['current_memorization_ayah'] =
          Variable<int>(currentMemorizationAyah.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivePlansCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('memorizationAmount: $memorizationAmount, ')
          ..write('memorizationUnit: $memorizationUnit, ')
          ..write('reviewAmount: $reviewAmount, ')
          ..write('reviewUnit: $reviewUnit, ')
          ..write('memorizationStartSurah: $memorizationStartSurah, ')
          ..write('memorizationStartAyah: $memorizationStartAyah, ')
          ..write('currentMemorizationSurah: $currentMemorizationSurah, ')
          ..write('currentMemorizationAyah: $currentMemorizationAyah, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DayAssignmentsTable extends DayAssignments
    with TableInfo<$DayAssignmentsTable, DayAssignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES active_plans (id)'));
  static const VerificationMeta _dateKeyMeta =
      const VerificationMeta('dateKey');
  @override
  late final GeneratedColumn<String> dateKey = GeneratedColumn<String>(
      'date_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _memorizationStartSurahMeta =
      const VerificationMeta('memorizationStartSurah');
  @override
  late final GeneratedColumn<int> memorizationStartSurah = GeneratedColumn<int>(
      'memorization_start_surah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _memorizationStartAyahMeta =
      const VerificationMeta('memorizationStartAyah');
  @override
  late final GeneratedColumn<int> memorizationStartAyah = GeneratedColumn<int>(
      'memorization_start_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _memorizationEndSurahMeta =
      const VerificationMeta('memorizationEndSurah');
  @override
  late final GeneratedColumn<int> memorizationEndSurah = GeneratedColumn<int>(
      'memorization_end_surah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _memorizationEndAyahMeta =
      const VerificationMeta('memorizationEndAyah');
  @override
  late final GeneratedColumn<int> memorizationEndAyah = GeneratedColumn<int>(
      'memorization_end_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _memorizationAmountMeta =
      const VerificationMeta('memorizationAmount');
  @override
  late final GeneratedColumn<double> memorizationAmount =
      GeneratedColumn<double>('memorization_amount', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _memorizationUnitMeta =
      const VerificationMeta('memorizationUnit');
  @override
  late final GeneratedColumn<String> memorizationUnit = GeneratedColumn<String>(
      'memorization_unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reviewAmountMeta =
      const VerificationMeta('reviewAmount');
  @override
  late final GeneratedColumn<double> reviewAmount = GeneratedColumn<double>(
      'review_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _reviewUnitMeta =
      const VerificationMeta('reviewUnit');
  @override
  late final GeneratedColumn<String> reviewUnit = GeneratedColumn<String>(
      'review_unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isMemorizationDoneMeta =
      const VerificationMeta('isMemorizationDone');
  @override
  late final GeneratedColumn<bool> isMemorizationDone = GeneratedColumn<bool>(
      'is_memorization_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_memorization_done" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isReviewDoneMeta =
      const VerificationMeta('isReviewDone');
  @override
  late final GeneratedColumn<bool> isReviewDone = GeneratedColumn<bool>(
      'is_review_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_review_done" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        planId,
        dateKey,
        memorizationStartSurah,
        memorizationStartAyah,
        memorizationEndSurah,
        memorizationEndAyah,
        memorizationAmount,
        memorizationUnit,
        reviewAmount,
        reviewUnit,
        isMemorizationDone,
        isReviewDone,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_assignments';
  @override
  VerificationContext validateIntegrity(Insertable<DayAssignment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(_planIdMeta,
          planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta));
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('date_key')) {
      context.handle(_dateKeyMeta,
          dateKey.isAcceptableOrUnknown(data['date_key']!, _dateKeyMeta));
    } else if (isInserting) {
      context.missing(_dateKeyMeta);
    }
    if (data.containsKey('memorization_start_surah')) {
      context.handle(
          _memorizationStartSurahMeta,
          memorizationStartSurah.isAcceptableOrUnknown(
              data['memorization_start_surah']!, _memorizationStartSurahMeta));
    } else if (isInserting) {
      context.missing(_memorizationStartSurahMeta);
    }
    if (data.containsKey('memorization_start_ayah')) {
      context.handle(
          _memorizationStartAyahMeta,
          memorizationStartAyah.isAcceptableOrUnknown(
              data['memorization_start_ayah']!, _memorizationStartAyahMeta));
    } else if (isInserting) {
      context.missing(_memorizationStartAyahMeta);
    }
    if (data.containsKey('memorization_end_surah')) {
      context.handle(
          _memorizationEndSurahMeta,
          memorizationEndSurah.isAcceptableOrUnknown(
              data['memorization_end_surah']!, _memorizationEndSurahMeta));
    } else if (isInserting) {
      context.missing(_memorizationEndSurahMeta);
    }
    if (data.containsKey('memorization_end_ayah')) {
      context.handle(
          _memorizationEndAyahMeta,
          memorizationEndAyah.isAcceptableOrUnknown(
              data['memorization_end_ayah']!, _memorizationEndAyahMeta));
    } else if (isInserting) {
      context.missing(_memorizationEndAyahMeta);
    }
    if (data.containsKey('memorization_amount')) {
      context.handle(
          _memorizationAmountMeta,
          memorizationAmount.isAcceptableOrUnknown(
              data['memorization_amount']!, _memorizationAmountMeta));
    } else if (isInserting) {
      context.missing(_memorizationAmountMeta);
    }
    if (data.containsKey('memorization_unit')) {
      context.handle(
          _memorizationUnitMeta,
          memorizationUnit.isAcceptableOrUnknown(
              data['memorization_unit']!, _memorizationUnitMeta));
    } else if (isInserting) {
      context.missing(_memorizationUnitMeta);
    }
    if (data.containsKey('review_amount')) {
      context.handle(
          _reviewAmountMeta,
          reviewAmount.isAcceptableOrUnknown(
              data['review_amount']!, _reviewAmountMeta));
    } else if (isInserting) {
      context.missing(_reviewAmountMeta);
    }
    if (data.containsKey('review_unit')) {
      context.handle(
          _reviewUnitMeta,
          reviewUnit.isAcceptableOrUnknown(
              data['review_unit']!, _reviewUnitMeta));
    } else if (isInserting) {
      context.missing(_reviewUnitMeta);
    }
    if (data.containsKey('is_memorization_done')) {
      context.handle(
          _isMemorizationDoneMeta,
          isMemorizationDone.isAcceptableOrUnknown(
              data['is_memorization_done']!, _isMemorizationDoneMeta));
    }
    if (data.containsKey('is_review_done')) {
      context.handle(
          _isReviewDoneMeta,
          isReviewDone.isAcceptableOrUnknown(
              data['is_review_done']!, _isReviewDoneMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DayAssignment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayAssignment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_id'])!,
      dateKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_key'])!,
      memorizationStartSurah: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}memorization_start_surah'])!,
      memorizationStartAyah: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}memorization_start_ayah'])!,
      memorizationEndSurah: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}memorization_end_surah'])!,
      memorizationEndAyah: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}memorization_end_ayah'])!,
      memorizationAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}memorization_amount'])!,
      memorizationUnit: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}memorization_unit'])!,
      reviewAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}review_amount'])!,
      reviewUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_unit'])!,
      isMemorizationDone: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_memorization_done'])!,
      isReviewDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_review_done'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DayAssignmentsTable createAlias(String alias) {
    return $DayAssignmentsTable(attachedDatabase, alias);
  }
}

class DayAssignment extends DataClass implements Insertable<DayAssignment> {
  final String id;
  final String planId;
  final String dateKey;
  final int memorizationStartSurah;
  final int memorizationStartAyah;
  final int memorizationEndSurah;
  final int memorizationEndAyah;
  final double memorizationAmount;
  final String memorizationUnit;
  final double reviewAmount;
  final String reviewUnit;
  final bool isMemorizationDone;
  final bool isReviewDone;
  final DateTime createdAt;
  const DayAssignment(
      {required this.id,
      required this.planId,
      required this.dateKey,
      required this.memorizationStartSurah,
      required this.memorizationStartAyah,
      required this.memorizationEndSurah,
      required this.memorizationEndAyah,
      required this.memorizationAmount,
      required this.memorizationUnit,
      required this.reviewAmount,
      required this.reviewUnit,
      required this.isMemorizationDone,
      required this.isReviewDone,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['date_key'] = Variable<String>(dateKey);
    map['memorization_start_surah'] = Variable<int>(memorizationStartSurah);
    map['memorization_start_ayah'] = Variable<int>(memorizationStartAyah);
    map['memorization_end_surah'] = Variable<int>(memorizationEndSurah);
    map['memorization_end_ayah'] = Variable<int>(memorizationEndAyah);
    map['memorization_amount'] = Variable<double>(memorizationAmount);
    map['memorization_unit'] = Variable<String>(memorizationUnit);
    map['review_amount'] = Variable<double>(reviewAmount);
    map['review_unit'] = Variable<String>(reviewUnit);
    map['is_memorization_done'] = Variable<bool>(isMemorizationDone);
    map['is_review_done'] = Variable<bool>(isReviewDone);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DayAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return DayAssignmentsCompanion(
      id: Value(id),
      planId: Value(planId),
      dateKey: Value(dateKey),
      memorizationStartSurah: Value(memorizationStartSurah),
      memorizationStartAyah: Value(memorizationStartAyah),
      memorizationEndSurah: Value(memorizationEndSurah),
      memorizationEndAyah: Value(memorizationEndAyah),
      memorizationAmount: Value(memorizationAmount),
      memorizationUnit: Value(memorizationUnit),
      reviewAmount: Value(reviewAmount),
      reviewUnit: Value(reviewUnit),
      isMemorizationDone: Value(isMemorizationDone),
      isReviewDone: Value(isReviewDone),
      createdAt: Value(createdAt),
    );
  }

  factory DayAssignment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayAssignment(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      dateKey: serializer.fromJson<String>(json['dateKey']),
      memorizationStartSurah:
          serializer.fromJson<int>(json['memorizationStartSurah']),
      memorizationStartAyah:
          serializer.fromJson<int>(json['memorizationStartAyah']),
      memorizationEndSurah:
          serializer.fromJson<int>(json['memorizationEndSurah']),
      memorizationEndAyah:
          serializer.fromJson<int>(json['memorizationEndAyah']),
      memorizationAmount:
          serializer.fromJson<double>(json['memorizationAmount']),
      memorizationUnit: serializer.fromJson<String>(json['memorizationUnit']),
      reviewAmount: serializer.fromJson<double>(json['reviewAmount']),
      reviewUnit: serializer.fromJson<String>(json['reviewUnit']),
      isMemorizationDone: serializer.fromJson<bool>(json['isMemorizationDone']),
      isReviewDone: serializer.fromJson<bool>(json['isReviewDone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'dateKey': serializer.toJson<String>(dateKey),
      'memorizationStartSurah': serializer.toJson<int>(memorizationStartSurah),
      'memorizationStartAyah': serializer.toJson<int>(memorizationStartAyah),
      'memorizationEndSurah': serializer.toJson<int>(memorizationEndSurah),
      'memorizationEndAyah': serializer.toJson<int>(memorizationEndAyah),
      'memorizationAmount': serializer.toJson<double>(memorizationAmount),
      'memorizationUnit': serializer.toJson<String>(memorizationUnit),
      'reviewAmount': serializer.toJson<double>(reviewAmount),
      'reviewUnit': serializer.toJson<String>(reviewUnit),
      'isMemorizationDone': serializer.toJson<bool>(isMemorizationDone),
      'isReviewDone': serializer.toJson<bool>(isReviewDone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DayAssignment copyWith(
          {String? id,
          String? planId,
          String? dateKey,
          int? memorizationStartSurah,
          int? memorizationStartAyah,
          int? memorizationEndSurah,
          int? memorizationEndAyah,
          double? memorizationAmount,
          String? memorizationUnit,
          double? reviewAmount,
          String? reviewUnit,
          bool? isMemorizationDone,
          bool? isReviewDone,
          DateTime? createdAt}) =>
      DayAssignment(
        id: id ?? this.id,
        planId: planId ?? this.planId,
        dateKey: dateKey ?? this.dateKey,
        memorizationStartSurah:
            memorizationStartSurah ?? this.memorizationStartSurah,
        memorizationStartAyah:
            memorizationStartAyah ?? this.memorizationStartAyah,
        memorizationEndSurah: memorizationEndSurah ?? this.memorizationEndSurah,
        memorizationEndAyah: memorizationEndAyah ?? this.memorizationEndAyah,
        memorizationAmount: memorizationAmount ?? this.memorizationAmount,
        memorizationUnit: memorizationUnit ?? this.memorizationUnit,
        reviewAmount: reviewAmount ?? this.reviewAmount,
        reviewUnit: reviewUnit ?? this.reviewUnit,
        isMemorizationDone: isMemorizationDone ?? this.isMemorizationDone,
        isReviewDone: isReviewDone ?? this.isReviewDone,
        createdAt: createdAt ?? this.createdAt,
      );
  DayAssignment copyWithCompanion(DayAssignmentsCompanion data) {
    return DayAssignment(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      dateKey: data.dateKey.present ? data.dateKey.value : this.dateKey,
      memorizationStartSurah: data.memorizationStartSurah.present
          ? data.memorizationStartSurah.value
          : this.memorizationStartSurah,
      memorizationStartAyah: data.memorizationStartAyah.present
          ? data.memorizationStartAyah.value
          : this.memorizationStartAyah,
      memorizationEndSurah: data.memorizationEndSurah.present
          ? data.memorizationEndSurah.value
          : this.memorizationEndSurah,
      memorizationEndAyah: data.memorizationEndAyah.present
          ? data.memorizationEndAyah.value
          : this.memorizationEndAyah,
      memorizationAmount: data.memorizationAmount.present
          ? data.memorizationAmount.value
          : this.memorizationAmount,
      memorizationUnit: data.memorizationUnit.present
          ? data.memorizationUnit.value
          : this.memorizationUnit,
      reviewAmount: data.reviewAmount.present
          ? data.reviewAmount.value
          : this.reviewAmount,
      reviewUnit:
          data.reviewUnit.present ? data.reviewUnit.value : this.reviewUnit,
      isMemorizationDone: data.isMemorizationDone.present
          ? data.isMemorizationDone.value
          : this.isMemorizationDone,
      isReviewDone: data.isReviewDone.present
          ? data.isReviewDone.value
          : this.isReviewDone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayAssignment(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dateKey: $dateKey, ')
          ..write('memorizationStartSurah: $memorizationStartSurah, ')
          ..write('memorizationStartAyah: $memorizationStartAyah, ')
          ..write('memorizationEndSurah: $memorizationEndSurah, ')
          ..write('memorizationEndAyah: $memorizationEndAyah, ')
          ..write('memorizationAmount: $memorizationAmount, ')
          ..write('memorizationUnit: $memorizationUnit, ')
          ..write('reviewAmount: $reviewAmount, ')
          ..write('reviewUnit: $reviewUnit, ')
          ..write('isMemorizationDone: $isMemorizationDone, ')
          ..write('isReviewDone: $isReviewDone, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      planId,
      dateKey,
      memorizationStartSurah,
      memorizationStartAyah,
      memorizationEndSurah,
      memorizationEndAyah,
      memorizationAmount,
      memorizationUnit,
      reviewAmount,
      reviewUnit,
      isMemorizationDone,
      isReviewDone,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayAssignment &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.dateKey == this.dateKey &&
          other.memorizationStartSurah == this.memorizationStartSurah &&
          other.memorizationStartAyah == this.memorizationStartAyah &&
          other.memorizationEndSurah == this.memorizationEndSurah &&
          other.memorizationEndAyah == this.memorizationEndAyah &&
          other.memorizationAmount == this.memorizationAmount &&
          other.memorizationUnit == this.memorizationUnit &&
          other.reviewAmount == this.reviewAmount &&
          other.reviewUnit == this.reviewUnit &&
          other.isMemorizationDone == this.isMemorizationDone &&
          other.isReviewDone == this.isReviewDone &&
          other.createdAt == this.createdAt);
}

class DayAssignmentsCompanion extends UpdateCompanion<DayAssignment> {
  final Value<String> id;
  final Value<String> planId;
  final Value<String> dateKey;
  final Value<int> memorizationStartSurah;
  final Value<int> memorizationStartAyah;
  final Value<int> memorizationEndSurah;
  final Value<int> memorizationEndAyah;
  final Value<double> memorizationAmount;
  final Value<String> memorizationUnit;
  final Value<double> reviewAmount;
  final Value<String> reviewUnit;
  final Value<bool> isMemorizationDone;
  final Value<bool> isReviewDone;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DayAssignmentsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.dateKey = const Value.absent(),
    this.memorizationStartSurah = const Value.absent(),
    this.memorizationStartAyah = const Value.absent(),
    this.memorizationEndSurah = const Value.absent(),
    this.memorizationEndAyah = const Value.absent(),
    this.memorizationAmount = const Value.absent(),
    this.memorizationUnit = const Value.absent(),
    this.reviewAmount = const Value.absent(),
    this.reviewUnit = const Value.absent(),
    this.isMemorizationDone = const Value.absent(),
    this.isReviewDone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DayAssignmentsCompanion.insert({
    required String id,
    required String planId,
    required String dateKey,
    required int memorizationStartSurah,
    required int memorizationStartAyah,
    required int memorizationEndSurah,
    required int memorizationEndAyah,
    required double memorizationAmount,
    required String memorizationUnit,
    required double reviewAmount,
    required String reviewUnit,
    this.isMemorizationDone = const Value.absent(),
    this.isReviewDone = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        planId = Value(planId),
        dateKey = Value(dateKey),
        memorizationStartSurah = Value(memorizationStartSurah),
        memorizationStartAyah = Value(memorizationStartAyah),
        memorizationEndSurah = Value(memorizationEndSurah),
        memorizationEndAyah = Value(memorizationEndAyah),
        memorizationAmount = Value(memorizationAmount),
        memorizationUnit = Value(memorizationUnit),
        reviewAmount = Value(reviewAmount),
        reviewUnit = Value(reviewUnit),
        createdAt = Value(createdAt);
  static Insertable<DayAssignment> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? dateKey,
    Expression<int>? memorizationStartSurah,
    Expression<int>? memorizationStartAyah,
    Expression<int>? memorizationEndSurah,
    Expression<int>? memorizationEndAyah,
    Expression<double>? memorizationAmount,
    Expression<String>? memorizationUnit,
    Expression<double>? reviewAmount,
    Expression<String>? reviewUnit,
    Expression<bool>? isMemorizationDone,
    Expression<bool>? isReviewDone,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (dateKey != null) 'date_key': dateKey,
      if (memorizationStartSurah != null)
        'memorization_start_surah': memorizationStartSurah,
      if (memorizationStartAyah != null)
        'memorization_start_ayah': memorizationStartAyah,
      if (memorizationEndSurah != null)
        'memorization_end_surah': memorizationEndSurah,
      if (memorizationEndAyah != null)
        'memorization_end_ayah': memorizationEndAyah,
      if (memorizationAmount != null) 'memorization_amount': memorizationAmount,
      if (memorizationUnit != null) 'memorization_unit': memorizationUnit,
      if (reviewAmount != null) 'review_amount': reviewAmount,
      if (reviewUnit != null) 'review_unit': reviewUnit,
      if (isMemorizationDone != null)
        'is_memorization_done': isMemorizationDone,
      if (isReviewDone != null) 'is_review_done': isReviewDone,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DayAssignmentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? planId,
      Value<String>? dateKey,
      Value<int>? memorizationStartSurah,
      Value<int>? memorizationStartAyah,
      Value<int>? memorizationEndSurah,
      Value<int>? memorizationEndAyah,
      Value<double>? memorizationAmount,
      Value<String>? memorizationUnit,
      Value<double>? reviewAmount,
      Value<String>? reviewUnit,
      Value<bool>? isMemorizationDone,
      Value<bool>? isReviewDone,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DayAssignmentsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      dateKey: dateKey ?? this.dateKey,
      memorizationStartSurah:
          memorizationStartSurah ?? this.memorizationStartSurah,
      memorizationStartAyah:
          memorizationStartAyah ?? this.memorizationStartAyah,
      memorizationEndSurah: memorizationEndSurah ?? this.memorizationEndSurah,
      memorizationEndAyah: memorizationEndAyah ?? this.memorizationEndAyah,
      memorizationAmount: memorizationAmount ?? this.memorizationAmount,
      memorizationUnit: memorizationUnit ?? this.memorizationUnit,
      reviewAmount: reviewAmount ?? this.reviewAmount,
      reviewUnit: reviewUnit ?? this.reviewUnit,
      isMemorizationDone: isMemorizationDone ?? this.isMemorizationDone,
      isReviewDone: isReviewDone ?? this.isReviewDone,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (dateKey.present) {
      map['date_key'] = Variable<String>(dateKey.value);
    }
    if (memorizationStartSurah.present) {
      map['memorization_start_surah'] =
          Variable<int>(memorizationStartSurah.value);
    }
    if (memorizationStartAyah.present) {
      map['memorization_start_ayah'] =
          Variable<int>(memorizationStartAyah.value);
    }
    if (memorizationEndSurah.present) {
      map['memorization_end_surah'] = Variable<int>(memorizationEndSurah.value);
    }
    if (memorizationEndAyah.present) {
      map['memorization_end_ayah'] = Variable<int>(memorizationEndAyah.value);
    }
    if (memorizationAmount.present) {
      map['memorization_amount'] = Variable<double>(memorizationAmount.value);
    }
    if (memorizationUnit.present) {
      map['memorization_unit'] = Variable<String>(memorizationUnit.value);
    }
    if (reviewAmount.present) {
      map['review_amount'] = Variable<double>(reviewAmount.value);
    }
    if (reviewUnit.present) {
      map['review_unit'] = Variable<String>(reviewUnit.value);
    }
    if (isMemorizationDone.present) {
      map['is_memorization_done'] = Variable<bool>(isMemorizationDone.value);
    }
    if (isReviewDone.present) {
      map['is_review_done'] = Variable<bool>(isReviewDone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dateKey: $dateKey, ')
          ..write('memorizationStartSurah: $memorizationStartSurah, ')
          ..write('memorizationStartAyah: $memorizationStartAyah, ')
          ..write('memorizationEndSurah: $memorizationEndSurah, ')
          ..write('memorizationEndAyah: $memorizationEndAyah, ')
          ..write('memorizationAmount: $memorizationAmount, ')
          ..write('memorizationUnit: $memorizationUnit, ')
          ..write('reviewAmount: $reviewAmount, ')
          ..write('reviewUnit: $reviewUnit, ')
          ..write('isMemorizationDone: $isMemorizationDone, ')
          ..write('isReviewDone: $isReviewDone, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ActivePlansTable activePlans = $ActivePlansTable(this);
  late final $DayAssignmentsTable dayAssignments = $DayAssignmentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [activePlans, dayAssignments];
}

typedef $$ActivePlansTableCreateCompanionBuilder = ActivePlansCompanion
    Function({
  required String id,
  required DateTime createdAt,
  required DateTime updatedAt,
  required String status,
  required double memorizationAmount,
  required String memorizationUnit,
  required double reviewAmount,
  required String reviewUnit,
  required int memorizationStartSurah,
  required int memorizationStartAyah,
  required int currentMemorizationSurah,
  required int currentMemorizationAyah,
  Value<int> rowid,
});
typedef $$ActivePlansTableUpdateCompanionBuilder = ActivePlansCompanion
    Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> status,
  Value<double> memorizationAmount,
  Value<String> memorizationUnit,
  Value<double> reviewAmount,
  Value<String> reviewUnit,
  Value<int> memorizationStartSurah,
  Value<int> memorizationStartAyah,
  Value<int> currentMemorizationSurah,
  Value<int> currentMemorizationAyah,
  Value<int> rowid,
});

final class $$ActivePlansTableReferences
    extends BaseReferences<_$AppDatabase, $ActivePlansTable, ActivePlan> {
  $$ActivePlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DayAssignmentsTable, List<DayAssignment>>
      _dayAssignmentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dayAssignments,
              aliasName: $_aliasNameGenerator(
                  db.activePlans.id, db.dayAssignments.planId));

  $$DayAssignmentsTableProcessedTableManager get dayAssignmentsRefs {
    final manager = $$DayAssignmentsTableTableManager($_db, $_db.dayAssignments)
        .filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_dayAssignmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ActivePlansTableFilterComposer
    extends Composer<_$AppDatabase, $ActivePlansTable> {
  $$ActivePlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get memorizationAmount => $composableBuilder(
      column: $table.memorizationAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memorizationUnit => $composableBuilder(
      column: $table.memorizationUnit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get reviewAmount => $composableBuilder(
      column: $table.reviewAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewUnit => $composableBuilder(
      column: $table.reviewUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get memorizationStartSurah => $composableBuilder(
      column: $table.memorizationStartSurah,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get memorizationStartAyah => $composableBuilder(
      column: $table.memorizationStartAyah,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentMemorizationSurah => $composableBuilder(
      column: $table.currentMemorizationSurah,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentMemorizationAyah => $composableBuilder(
      column: $table.currentMemorizationAyah,
      builder: (column) => ColumnFilters(column));

  Expression<bool> dayAssignmentsRefs(
      Expression<bool> Function($$DayAssignmentsTableFilterComposer f) f) {
    final $$DayAssignmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dayAssignments,
        getReferencedColumn: (t) => t.planId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DayAssignmentsTableFilterComposer(
              $db: $db,
              $table: $db.dayAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ActivePlansTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivePlansTable> {
  $$ActivePlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get memorizationAmount => $composableBuilder(
      column: $table.memorizationAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memorizationUnit => $composableBuilder(
      column: $table.memorizationUnit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get reviewAmount => $composableBuilder(
      column: $table.reviewAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewUnit => $composableBuilder(
      column: $table.reviewUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get memorizationStartSurah => $composableBuilder(
      column: $table.memorizationStartSurah,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get memorizationStartAyah => $composableBuilder(
      column: $table.memorizationStartAyah,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentMemorizationSurah => $composableBuilder(
      column: $table.currentMemorizationSurah,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentMemorizationAyah => $composableBuilder(
      column: $table.currentMemorizationAyah,
      builder: (column) => ColumnOrderings(column));
}

class $$ActivePlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivePlansTable> {
  $$ActivePlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get memorizationAmount => $composableBuilder(
      column: $table.memorizationAmount, builder: (column) => column);

  GeneratedColumn<String> get memorizationUnit => $composableBuilder(
      column: $table.memorizationUnit, builder: (column) => column);

  GeneratedColumn<double> get reviewAmount => $composableBuilder(
      column: $table.reviewAmount, builder: (column) => column);

  GeneratedColumn<String> get reviewUnit => $composableBuilder(
      column: $table.reviewUnit, builder: (column) => column);

  GeneratedColumn<int> get memorizationStartSurah => $composableBuilder(
      column: $table.memorizationStartSurah, builder: (column) => column);

  GeneratedColumn<int> get memorizationStartAyah => $composableBuilder(
      column: $table.memorizationStartAyah, builder: (column) => column);

  GeneratedColumn<int> get currentMemorizationSurah => $composableBuilder(
      column: $table.currentMemorizationSurah, builder: (column) => column);

  GeneratedColumn<int> get currentMemorizationAyah => $composableBuilder(
      column: $table.currentMemorizationAyah, builder: (column) => column);

  Expression<T> dayAssignmentsRefs<T extends Object>(
      Expression<T> Function($$DayAssignmentsTableAnnotationComposer a) f) {
    final $$DayAssignmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dayAssignments,
        getReferencedColumn: (t) => t.planId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DayAssignmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.dayAssignments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ActivePlansTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActivePlansTable,
    ActivePlan,
    $$ActivePlansTableFilterComposer,
    $$ActivePlansTableOrderingComposer,
    $$ActivePlansTableAnnotationComposer,
    $$ActivePlansTableCreateCompanionBuilder,
    $$ActivePlansTableUpdateCompanionBuilder,
    (ActivePlan, $$ActivePlansTableReferences),
    ActivePlan,
    PrefetchHooks Function({bool dayAssignmentsRefs})> {
  $$ActivePlansTableTableManager(_$AppDatabase db, $ActivePlansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivePlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivePlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivePlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> memorizationAmount = const Value.absent(),
            Value<String> memorizationUnit = const Value.absent(),
            Value<double> reviewAmount = const Value.absent(),
            Value<String> reviewUnit = const Value.absent(),
            Value<int> memorizationStartSurah = const Value.absent(),
            Value<int> memorizationStartAyah = const Value.absent(),
            Value<int> currentMemorizationSurah = const Value.absent(),
            Value<int> currentMemorizationAyah = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivePlansCompanion(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            status: status,
            memorizationAmount: memorizationAmount,
            memorizationUnit: memorizationUnit,
            reviewAmount: reviewAmount,
            reviewUnit: reviewUnit,
            memorizationStartSurah: memorizationStartSurah,
            memorizationStartAyah: memorizationStartAyah,
            currentMemorizationSurah: currentMemorizationSurah,
            currentMemorizationAyah: currentMemorizationAyah,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime createdAt,
            required DateTime updatedAt,
            required String status,
            required double memorizationAmount,
            required String memorizationUnit,
            required double reviewAmount,
            required String reviewUnit,
            required int memorizationStartSurah,
            required int memorizationStartAyah,
            required int currentMemorizationSurah,
            required int currentMemorizationAyah,
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivePlansCompanion.insert(
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt,
            status: status,
            memorizationAmount: memorizationAmount,
            memorizationUnit: memorizationUnit,
            reviewAmount: reviewAmount,
            reviewUnit: reviewUnit,
            memorizationStartSurah: memorizationStartSurah,
            memorizationStartAyah: memorizationStartAyah,
            currentMemorizationSurah: currentMemorizationSurah,
            currentMemorizationAyah: currentMemorizationAyah,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ActivePlansTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dayAssignmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (dayAssignmentsRefs) db.dayAssignments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dayAssignmentsRefs)
                    await $_getPrefetchedData<ActivePlan, $ActivePlansTable,
                            DayAssignment>(
                        currentTable: table,
                        referencedTable: $$ActivePlansTableReferences
                            ._dayAssignmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ActivePlansTableReferences(db, table, p0)
                                .dayAssignmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.planId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ActivePlansTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActivePlansTable,
    ActivePlan,
    $$ActivePlansTableFilterComposer,
    $$ActivePlansTableOrderingComposer,
    $$ActivePlansTableAnnotationComposer,
    $$ActivePlansTableCreateCompanionBuilder,
    $$ActivePlansTableUpdateCompanionBuilder,
    (ActivePlan, $$ActivePlansTableReferences),
    ActivePlan,
    PrefetchHooks Function({bool dayAssignmentsRefs})>;
typedef $$DayAssignmentsTableCreateCompanionBuilder = DayAssignmentsCompanion
    Function({
  required String id,
  required String planId,
  required String dateKey,
  required int memorizationStartSurah,
  required int memorizationStartAyah,
  required int memorizationEndSurah,
  required int memorizationEndAyah,
  required double memorizationAmount,
  required String memorizationUnit,
  required double reviewAmount,
  required String reviewUnit,
  Value<bool> isMemorizationDone,
  Value<bool> isReviewDone,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$DayAssignmentsTableUpdateCompanionBuilder = DayAssignmentsCompanion
    Function({
  Value<String> id,
  Value<String> planId,
  Value<String> dateKey,
  Value<int> memorizationStartSurah,
  Value<int> memorizationStartAyah,
  Value<int> memorizationEndSurah,
  Value<int> memorizationEndAyah,
  Value<double> memorizationAmount,
  Value<String> memorizationUnit,
  Value<double> reviewAmount,
  Value<String> reviewUnit,
  Value<bool> isMemorizationDone,
  Value<bool> isReviewDone,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$DayAssignmentsTableReferences
    extends BaseReferences<_$AppDatabase, $DayAssignmentsTable, DayAssignment> {
  $$DayAssignmentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ActivePlansTable _planIdTable(_$AppDatabase db) =>
      db.activePlans.createAlias(
          $_aliasNameGenerator(db.dayAssignments.planId, db.activePlans.id));

  $$ActivePlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$ActivePlansTableTableManager($_db, $_db.activePlans)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DayAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $DayAssignmentsTable> {
  $$DayAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateKey => $composableBuilder(
      column: $table.dateKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get memorizationStartSurah => $composableBuilder(
      column: $table.memorizationStartSurah,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get memorizationStartAyah => $composableBuilder(
      column: $table.memorizationStartAyah,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get memorizationEndSurah => $composableBuilder(
      column: $table.memorizationEndSurah,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get memorizationEndAyah => $composableBuilder(
      column: $table.memorizationEndAyah,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get memorizationAmount => $composableBuilder(
      column: $table.memorizationAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memorizationUnit => $composableBuilder(
      column: $table.memorizationUnit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get reviewAmount => $composableBuilder(
      column: $table.reviewAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewUnit => $composableBuilder(
      column: $table.reviewUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMemorizationDone => $composableBuilder(
      column: $table.isMemorizationDone,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isReviewDone => $composableBuilder(
      column: $table.isReviewDone, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ActivePlansTableFilterComposer get planId {
    final $$ActivePlansTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planId,
        referencedTable: $db.activePlans,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivePlansTableFilterComposer(
              $db: $db,
              $table: $db.activePlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DayAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DayAssignmentsTable> {
  $$DayAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateKey => $composableBuilder(
      column: $table.dateKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get memorizationStartSurah => $composableBuilder(
      column: $table.memorizationStartSurah,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get memorizationStartAyah => $composableBuilder(
      column: $table.memorizationStartAyah,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get memorizationEndSurah => $composableBuilder(
      column: $table.memorizationEndSurah,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get memorizationEndAyah => $composableBuilder(
      column: $table.memorizationEndAyah,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get memorizationAmount => $composableBuilder(
      column: $table.memorizationAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memorizationUnit => $composableBuilder(
      column: $table.memorizationUnit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get reviewAmount => $composableBuilder(
      column: $table.reviewAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewUnit => $composableBuilder(
      column: $table.reviewUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMemorizationDone => $composableBuilder(
      column: $table.isMemorizationDone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isReviewDone => $composableBuilder(
      column: $table.isReviewDone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ActivePlansTableOrderingComposer get planId {
    final $$ActivePlansTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planId,
        referencedTable: $db.activePlans,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivePlansTableOrderingComposer(
              $db: $db,
              $table: $db.activePlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DayAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayAssignmentsTable> {
  $$DayAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dateKey =>
      $composableBuilder(column: $table.dateKey, builder: (column) => column);

  GeneratedColumn<int> get memorizationStartSurah => $composableBuilder(
      column: $table.memorizationStartSurah, builder: (column) => column);

  GeneratedColumn<int> get memorizationStartAyah => $composableBuilder(
      column: $table.memorizationStartAyah, builder: (column) => column);

  GeneratedColumn<int> get memorizationEndSurah => $composableBuilder(
      column: $table.memorizationEndSurah, builder: (column) => column);

  GeneratedColumn<int> get memorizationEndAyah => $composableBuilder(
      column: $table.memorizationEndAyah, builder: (column) => column);

  GeneratedColumn<double> get memorizationAmount => $composableBuilder(
      column: $table.memorizationAmount, builder: (column) => column);

  GeneratedColumn<String> get memorizationUnit => $composableBuilder(
      column: $table.memorizationUnit, builder: (column) => column);

  GeneratedColumn<double> get reviewAmount => $composableBuilder(
      column: $table.reviewAmount, builder: (column) => column);

  GeneratedColumn<String> get reviewUnit => $composableBuilder(
      column: $table.reviewUnit, builder: (column) => column);

  GeneratedColumn<bool> get isMemorizationDone => $composableBuilder(
      column: $table.isMemorizationDone, builder: (column) => column);

  GeneratedColumn<bool> get isReviewDone => $composableBuilder(
      column: $table.isReviewDone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ActivePlansTableAnnotationComposer get planId {
    final $$ActivePlansTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planId,
        referencedTable: $db.activePlans,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivePlansTableAnnotationComposer(
              $db: $db,
              $table: $db.activePlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DayAssignmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DayAssignmentsTable,
    DayAssignment,
    $$DayAssignmentsTableFilterComposer,
    $$DayAssignmentsTableOrderingComposer,
    $$DayAssignmentsTableAnnotationComposer,
    $$DayAssignmentsTableCreateCompanionBuilder,
    $$DayAssignmentsTableUpdateCompanionBuilder,
    (DayAssignment, $$DayAssignmentsTableReferences),
    DayAssignment,
    PrefetchHooks Function({bool planId})> {
  $$DayAssignmentsTableTableManager(
      _$AppDatabase db, $DayAssignmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayAssignmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayAssignmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayAssignmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> planId = const Value.absent(),
            Value<String> dateKey = const Value.absent(),
            Value<int> memorizationStartSurah = const Value.absent(),
            Value<int> memorizationStartAyah = const Value.absent(),
            Value<int> memorizationEndSurah = const Value.absent(),
            Value<int> memorizationEndAyah = const Value.absent(),
            Value<double> memorizationAmount = const Value.absent(),
            Value<String> memorizationUnit = const Value.absent(),
            Value<double> reviewAmount = const Value.absent(),
            Value<String> reviewUnit = const Value.absent(),
            Value<bool> isMemorizationDone = const Value.absent(),
            Value<bool> isReviewDone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DayAssignmentsCompanion(
            id: id,
            planId: planId,
            dateKey: dateKey,
            memorizationStartSurah: memorizationStartSurah,
            memorizationStartAyah: memorizationStartAyah,
            memorizationEndSurah: memorizationEndSurah,
            memorizationEndAyah: memorizationEndAyah,
            memorizationAmount: memorizationAmount,
            memorizationUnit: memorizationUnit,
            reviewAmount: reviewAmount,
            reviewUnit: reviewUnit,
            isMemorizationDone: isMemorizationDone,
            isReviewDone: isReviewDone,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String planId,
            required String dateKey,
            required int memorizationStartSurah,
            required int memorizationStartAyah,
            required int memorizationEndSurah,
            required int memorizationEndAyah,
            required double memorizationAmount,
            required String memorizationUnit,
            required double reviewAmount,
            required String reviewUnit,
            Value<bool> isMemorizationDone = const Value.absent(),
            Value<bool> isReviewDone = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              DayAssignmentsCompanion.insert(
            id: id,
            planId: planId,
            dateKey: dateKey,
            memorizationStartSurah: memorizationStartSurah,
            memorizationStartAyah: memorizationStartAyah,
            memorizationEndSurah: memorizationEndSurah,
            memorizationEndAyah: memorizationEndAyah,
            memorizationAmount: memorizationAmount,
            memorizationUnit: memorizationUnit,
            reviewAmount: reviewAmount,
            reviewUnit: reviewUnit,
            isMemorizationDone: isMemorizationDone,
            isReviewDone: isReviewDone,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DayAssignmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({planId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (planId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.planId,
                    referencedTable:
                        $$DayAssignmentsTableReferences._planIdTable(db),
                    referencedColumn:
                        $$DayAssignmentsTableReferences._planIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DayAssignmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DayAssignmentsTable,
    DayAssignment,
    $$DayAssignmentsTableFilterComposer,
    $$DayAssignmentsTableOrderingComposer,
    $$DayAssignmentsTableAnnotationComposer,
    $$DayAssignmentsTableCreateCompanionBuilder,
    $$DayAssignmentsTableUpdateCompanionBuilder,
    (DayAssignment, $$DayAssignmentsTableReferences),
    DayAssignment,
    PrefetchHooks Function({bool planId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ActivePlansTableTableManager get activePlans =>
      $$ActivePlansTableTableManager(_db, _db.activePlans);
  $$DayAssignmentsTableTableManager get dayAssignments =>
      $$DayAssignmentsTableTableManager(_db, _db.dayAssignments);
}
