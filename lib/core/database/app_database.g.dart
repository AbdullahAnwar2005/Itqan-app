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
  static const VerificationMeta _memorizationDaysMeta =
      const VerificationMeta('memorizationDays');
  @override
  late final GeneratedColumn<String> memorizationDays = GeneratedColumn<String>(
      'memorization_days', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('1,2,3,4,5'));
  static const VerificationMeta _reviewScheduleMeta =
      const VerificationMeta('reviewSchedule');
  @override
  late final GeneratedColumn<String> reviewSchedule = GeneratedColumn<String>(
      'review_schedule', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('everyday'));
  static const VerificationMeta _customReviewDaysMeta =
      const VerificationMeta('customReviewDays');
  @override
  late final GeneratedColumn<String> customReviewDays = GeneratedColumn<String>(
      'custom_review_days', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _previousMemorizedRangesMeta =
      const VerificationMeta('previousMemorizedRanges');
  @override
  late final GeneratedColumn<String> previousMemorizedRanges =
      GeneratedColumn<String>('previous_memorized_ranges', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
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
        currentMemorizationAyah,
        memorizationDays,
        reviewSchedule,
        customReviewDays,
        previousMemorizedRanges
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
    if (data.containsKey('memorization_days')) {
      context.handle(
          _memorizationDaysMeta,
          memorizationDays.isAcceptableOrUnknown(
              data['memorization_days']!, _memorizationDaysMeta));
    }
    if (data.containsKey('review_schedule')) {
      context.handle(
          _reviewScheduleMeta,
          reviewSchedule.isAcceptableOrUnknown(
              data['review_schedule']!, _reviewScheduleMeta));
    }
    if (data.containsKey('custom_review_days')) {
      context.handle(
          _customReviewDaysMeta,
          customReviewDays.isAcceptableOrUnknown(
              data['custom_review_days']!, _customReviewDaysMeta));
    }
    if (data.containsKey('previous_memorized_ranges')) {
      context.handle(
          _previousMemorizedRangesMeta,
          previousMemorizedRanges.isAcceptableOrUnknown(
              data['previous_memorized_ranges']!,
              _previousMemorizedRangesMeta));
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
      memorizationDays: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}memorization_days'])!,
      reviewSchedule: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}review_schedule'])!,
      customReviewDays: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}custom_review_days'])!,
      previousMemorizedRanges: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}previous_memorized_ranges'])!,
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

  /// Comma-separated weekday ints (1=Mon … 7=Sun). e.g. "1,2,3,4,5"
  final String memorizationDays;

  /// Persistence key of [ReviewSchedule] enum.
  final String reviewSchedule;

  /// Comma-separated custom review days. Empty string if not custom.
  final String customReviewDays;
  final String previousMemorizedRanges;
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
      required this.currentMemorizationAyah,
      required this.memorizationDays,
      required this.reviewSchedule,
      required this.customReviewDays,
      required this.previousMemorizedRanges});
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
    map['memorization_days'] = Variable<String>(memorizationDays);
    map['review_schedule'] = Variable<String>(reviewSchedule);
    map['custom_review_days'] = Variable<String>(customReviewDays);
    map['previous_memorized_ranges'] =
        Variable<String>(previousMemorizedRanges);
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
      memorizationDays: Value(memorizationDays),
      reviewSchedule: Value(reviewSchedule),
      customReviewDays: Value(customReviewDays),
      previousMemorizedRanges: Value(previousMemorizedRanges),
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
      memorizationDays: serializer.fromJson<String>(json['memorizationDays']),
      reviewSchedule: serializer.fromJson<String>(json['reviewSchedule']),
      customReviewDays: serializer.fromJson<String>(json['customReviewDays']),
      previousMemorizedRanges:
          serializer.fromJson<String>(json['previousMemorizedRanges']),
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
      'memorizationDays': serializer.toJson<String>(memorizationDays),
      'reviewSchedule': serializer.toJson<String>(reviewSchedule),
      'customReviewDays': serializer.toJson<String>(customReviewDays),
      'previousMemorizedRanges':
          serializer.toJson<String>(previousMemorizedRanges),
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
          int? currentMemorizationAyah,
          String? memorizationDays,
          String? reviewSchedule,
          String? customReviewDays,
          String? previousMemorizedRanges}) =>
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
        memorizationDays: memorizationDays ?? this.memorizationDays,
        reviewSchedule: reviewSchedule ?? this.reviewSchedule,
        customReviewDays: customReviewDays ?? this.customReviewDays,
        previousMemorizedRanges:
            previousMemorizedRanges ?? this.previousMemorizedRanges,
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
      memorizationDays: data.memorizationDays.present
          ? data.memorizationDays.value
          : this.memorizationDays,
      reviewSchedule: data.reviewSchedule.present
          ? data.reviewSchedule.value
          : this.reviewSchedule,
      customReviewDays: data.customReviewDays.present
          ? data.customReviewDays.value
          : this.customReviewDays,
      previousMemorizedRanges: data.previousMemorizedRanges.present
          ? data.previousMemorizedRanges.value
          : this.previousMemorizedRanges,
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
          ..write('currentMemorizationAyah: $currentMemorizationAyah, ')
          ..write('memorizationDays: $memorizationDays, ')
          ..write('reviewSchedule: $reviewSchedule, ')
          ..write('customReviewDays: $customReviewDays, ')
          ..write('previousMemorizedRanges: $previousMemorizedRanges')
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
      currentMemorizationAyah,
      memorizationDays,
      reviewSchedule,
      customReviewDays,
      previousMemorizedRanges);
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
          other.currentMemorizationAyah == this.currentMemorizationAyah &&
          other.memorizationDays == this.memorizationDays &&
          other.reviewSchedule == this.reviewSchedule &&
          other.customReviewDays == this.customReviewDays &&
          other.previousMemorizedRanges == this.previousMemorizedRanges);
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
  final Value<String> memorizationDays;
  final Value<String> reviewSchedule;
  final Value<String> customReviewDays;
  final Value<String> previousMemorizedRanges;
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
    this.memorizationDays = const Value.absent(),
    this.reviewSchedule = const Value.absent(),
    this.customReviewDays = const Value.absent(),
    this.previousMemorizedRanges = const Value.absent(),
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
    this.memorizationDays = const Value.absent(),
    this.reviewSchedule = const Value.absent(),
    this.customReviewDays = const Value.absent(),
    this.previousMemorizedRanges = const Value.absent(),
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
    Expression<String>? memorizationDays,
    Expression<String>? reviewSchedule,
    Expression<String>? customReviewDays,
    Expression<String>? previousMemorizedRanges,
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
      if (memorizationDays != null) 'memorization_days': memorizationDays,
      if (reviewSchedule != null) 'review_schedule': reviewSchedule,
      if (customReviewDays != null) 'custom_review_days': customReviewDays,
      if (previousMemorizedRanges != null)
        'previous_memorized_ranges': previousMemorizedRanges,
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
      Value<String>? memorizationDays,
      Value<String>? reviewSchedule,
      Value<String>? customReviewDays,
      Value<String>? previousMemorizedRanges,
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
      memorizationDays: memorizationDays ?? this.memorizationDays,
      reviewSchedule: reviewSchedule ?? this.reviewSchedule,
      customReviewDays: customReviewDays ?? this.customReviewDays,
      previousMemorizedRanges:
          previousMemorizedRanges ?? this.previousMemorizedRanges,
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
    if (memorizationDays.present) {
      map['memorization_days'] = Variable<String>(memorizationDays.value);
    }
    if (reviewSchedule.present) {
      map['review_schedule'] = Variable<String>(reviewSchedule.value);
    }
    if (customReviewDays.present) {
      map['custom_review_days'] = Variable<String>(customReviewDays.value);
    }
    if (previousMemorizedRanges.present) {
      map['previous_memorized_ranges'] =
          Variable<String>(previousMemorizedRanges.value);
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
          ..write('memorizationDays: $memorizationDays, ')
          ..write('reviewSchedule: $reviewSchedule, ')
          ..write('customReviewDays: $customReviewDays, ')
          ..write('previousMemorizedRanges: $previousMemorizedRanges, ')
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
  static const VerificationMeta _hasMemoTaskMeta =
      const VerificationMeta('hasMemoTask');
  @override
  late final GeneratedColumn<bool> hasMemoTask = GeneratedColumn<bool>(
      'has_memo_task', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_memo_task" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _hasReviewTaskMeta =
      const VerificationMeta('hasReviewTask');
  @override
  late final GeneratedColumn<bool> hasReviewTask = GeneratedColumn<bool>(
      'has_review_task', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_review_task" IN (0, 1))'),
      defaultValue: const Constant(true));
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
        hasMemoTask,
        hasReviewTask,
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
    if (data.containsKey('has_memo_task')) {
      context.handle(
          _hasMemoTaskMeta,
          hasMemoTask.isAcceptableOrUnknown(
              data['has_memo_task']!, _hasMemoTaskMeta));
    }
    if (data.containsKey('has_review_task')) {
      context.handle(
          _hasReviewTaskMeta,
          hasReviewTask.isAcceptableOrUnknown(
              data['has_review_task']!, _hasReviewTaskMeta));
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
      hasMemoTask: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_memo_task'])!,
      hasReviewTask: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_review_task'])!,
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

  /// Whether today is a scheduled memorization day.
  final bool hasMemoTask;

  /// Whether today is a scheduled review day with known content to review.
  final bool hasReviewTask;
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
      required this.hasMemoTask,
      required this.hasReviewTask,
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
    map['has_memo_task'] = Variable<bool>(hasMemoTask);
    map['has_review_task'] = Variable<bool>(hasReviewTask);
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
      hasMemoTask: Value(hasMemoTask),
      hasReviewTask: Value(hasReviewTask),
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
      hasMemoTask: serializer.fromJson<bool>(json['hasMemoTask']),
      hasReviewTask: serializer.fromJson<bool>(json['hasReviewTask']),
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
      'hasMemoTask': serializer.toJson<bool>(hasMemoTask),
      'hasReviewTask': serializer.toJson<bool>(hasReviewTask),
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
          bool? hasMemoTask,
          bool? hasReviewTask,
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
        hasMemoTask: hasMemoTask ?? this.hasMemoTask,
        hasReviewTask: hasReviewTask ?? this.hasReviewTask,
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
      hasMemoTask:
          data.hasMemoTask.present ? data.hasMemoTask.value : this.hasMemoTask,
      hasReviewTask: data.hasReviewTask.present
          ? data.hasReviewTask.value
          : this.hasReviewTask,
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
          ..write('hasMemoTask: $hasMemoTask, ')
          ..write('hasReviewTask: $hasReviewTask, ')
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
      hasMemoTask,
      hasReviewTask,
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
          other.hasMemoTask == this.hasMemoTask &&
          other.hasReviewTask == this.hasReviewTask &&
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
  final Value<bool> hasMemoTask;
  final Value<bool> hasReviewTask;
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
    this.hasMemoTask = const Value.absent(),
    this.hasReviewTask = const Value.absent(),
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
    this.hasMemoTask = const Value.absent(),
    this.hasReviewTask = const Value.absent(),
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
    Expression<bool>? hasMemoTask,
    Expression<bool>? hasReviewTask,
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
      if (hasMemoTask != null) 'has_memo_task': hasMemoTask,
      if (hasReviewTask != null) 'has_review_task': hasReviewTask,
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
      Value<bool>? hasMemoTask,
      Value<bool>? hasReviewTask,
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
      hasMemoTask: hasMemoTask ?? this.hasMemoTask,
      hasReviewTask: hasReviewTask ?? this.hasReviewTask,
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
    if (hasMemoTask.present) {
      map['has_memo_task'] = Variable<bool>(hasMemoTask.value);
    }
    if (hasReviewTask.present) {
      map['has_review_task'] = Variable<bool>(hasReviewTask.value);
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
          ..write('hasMemoTask: $hasMemoTask, ')
          ..write('hasReviewTask: $hasReviewTask, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionLogsTable extends SessionLogs
    with TableInfo<$SessionLogsTable, SessionLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assignmentIdMeta =
      const VerificationMeta('assignmentId');
  @override
  late final GeneratedColumn<String> assignmentId = GeneratedColumn<String>(
      'assignment_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionTypeMeta =
      const VerificationMeta('sessionType');
  @override
  late final GeneratedColumn<String> sessionType = GeneratedColumn<String>(
      'session_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startSurahMeta =
      const VerificationMeta('startSurah');
  @override
  late final GeneratedColumn<int> startSurah = GeneratedColumn<int>(
      'start_surah', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _startAyahMeta =
      const VerificationMeta('startAyah');
  @override
  late final GeneratedColumn<int> startAyah = GeneratedColumn<int>(
      'start_ayah', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _endSurahMeta =
      const VerificationMeta('endSurah');
  @override
  late final GeneratedColumn<int> endSurah = GeneratedColumn<int>(
      'end_surah', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _endAyahMeta =
      const VerificationMeta('endAyah');
  @override
  late final GeneratedColumn<int> endAyah = GeneratedColumn<int>(
      'end_ayah', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<String> rating = GeneratedColumn<String>(
      'rating', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        assignmentId,
        planId,
        sessionType,
        startSurah,
        startAyah,
        endSurah,
        endAyah,
        rating,
        completedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_logs';
  @override
  VerificationContext validateIntegrity(Insertable<SessionLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('assignment_id')) {
      context.handle(
          _assignmentIdMeta,
          assignmentId.isAcceptableOrUnknown(
              data['assignment_id']!, _assignmentIdMeta));
    } else if (isInserting) {
      context.missing(_assignmentIdMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(_planIdMeta,
          planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta));
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('session_type')) {
      context.handle(
          _sessionTypeMeta,
          sessionType.isAcceptableOrUnknown(
              data['session_type']!, _sessionTypeMeta));
    } else if (isInserting) {
      context.missing(_sessionTypeMeta);
    }
    if (data.containsKey('start_surah')) {
      context.handle(
          _startSurahMeta,
          startSurah.isAcceptableOrUnknown(
              data['start_surah']!, _startSurahMeta));
    }
    if (data.containsKey('start_ayah')) {
      context.handle(_startAyahMeta,
          startAyah.isAcceptableOrUnknown(data['start_ayah']!, _startAyahMeta));
    }
    if (data.containsKey('end_surah')) {
      context.handle(_endSurahMeta,
          endSurah.isAcceptableOrUnknown(data['end_surah']!, _endSurahMeta));
    }
    if (data.containsKey('end_ayah')) {
      context.handle(_endAyahMeta,
          endAyah.isAcceptableOrUnknown(data['end_ayah']!, _endAyahMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    } else if (isInserting) {
      context.missing(_completedAtMeta);
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
  SessionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      assignmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}assignment_id'])!,
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_id'])!,
      sessionType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_type'])!,
      startSurah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_surah']),
      startAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_ayah']),
      endSurah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_surah']),
      endAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_ayah']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rating'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SessionLogsTable createAlias(String alias) {
    return $SessionLogsTable(attachedDatabase, alias);
  }
}

class SessionLog extends DataClass implements Insertable<SessionLog> {
  final String id;
  final String assignmentId;
  final String planId;
  final String sessionType;
  final int? startSurah;
  final int? startAyah;
  final int? endSurah;
  final int? endAyah;
  final String rating;
  final DateTime completedAt;
  final DateTime createdAt;
  const SessionLog(
      {required this.id,
      required this.assignmentId,
      required this.planId,
      required this.sessionType,
      this.startSurah,
      this.startAyah,
      this.endSurah,
      this.endAyah,
      required this.rating,
      required this.completedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['assignment_id'] = Variable<String>(assignmentId);
    map['plan_id'] = Variable<String>(planId);
    map['session_type'] = Variable<String>(sessionType);
    if (!nullToAbsent || startSurah != null) {
      map['start_surah'] = Variable<int>(startSurah);
    }
    if (!nullToAbsent || startAyah != null) {
      map['start_ayah'] = Variable<int>(startAyah);
    }
    if (!nullToAbsent || endSurah != null) {
      map['end_surah'] = Variable<int>(endSurah);
    }
    if (!nullToAbsent || endAyah != null) {
      map['end_ayah'] = Variable<int>(endAyah);
    }
    map['rating'] = Variable<String>(rating);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SessionLogsCompanion toCompanion(bool nullToAbsent) {
    return SessionLogsCompanion(
      id: Value(id),
      assignmentId: Value(assignmentId),
      planId: Value(planId),
      sessionType: Value(sessionType),
      startSurah: startSurah == null && nullToAbsent
          ? const Value.absent()
          : Value(startSurah),
      startAyah: startAyah == null && nullToAbsent
          ? const Value.absent()
          : Value(startAyah),
      endSurah: endSurah == null && nullToAbsent
          ? const Value.absent()
          : Value(endSurah),
      endAyah: endAyah == null && nullToAbsent
          ? const Value.absent()
          : Value(endAyah),
      rating: Value(rating),
      completedAt: Value(completedAt),
      createdAt: Value(createdAt),
    );
  }

  factory SessionLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionLog(
      id: serializer.fromJson<String>(json['id']),
      assignmentId: serializer.fromJson<String>(json['assignmentId']),
      planId: serializer.fromJson<String>(json['planId']),
      sessionType: serializer.fromJson<String>(json['sessionType']),
      startSurah: serializer.fromJson<int?>(json['startSurah']),
      startAyah: serializer.fromJson<int?>(json['startAyah']),
      endSurah: serializer.fromJson<int?>(json['endSurah']),
      endAyah: serializer.fromJson<int?>(json['endAyah']),
      rating: serializer.fromJson<String>(json['rating']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'assignmentId': serializer.toJson<String>(assignmentId),
      'planId': serializer.toJson<String>(planId),
      'sessionType': serializer.toJson<String>(sessionType),
      'startSurah': serializer.toJson<int?>(startSurah),
      'startAyah': serializer.toJson<int?>(startAyah),
      'endSurah': serializer.toJson<int?>(endSurah),
      'endAyah': serializer.toJson<int?>(endAyah),
      'rating': serializer.toJson<String>(rating),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SessionLog copyWith(
          {String? id,
          String? assignmentId,
          String? planId,
          String? sessionType,
          Value<int?> startSurah = const Value.absent(),
          Value<int?> startAyah = const Value.absent(),
          Value<int?> endSurah = const Value.absent(),
          Value<int?> endAyah = const Value.absent(),
          String? rating,
          DateTime? completedAt,
          DateTime? createdAt}) =>
      SessionLog(
        id: id ?? this.id,
        assignmentId: assignmentId ?? this.assignmentId,
        planId: planId ?? this.planId,
        sessionType: sessionType ?? this.sessionType,
        startSurah: startSurah.present ? startSurah.value : this.startSurah,
        startAyah: startAyah.present ? startAyah.value : this.startAyah,
        endSurah: endSurah.present ? endSurah.value : this.endSurah,
        endAyah: endAyah.present ? endAyah.value : this.endAyah,
        rating: rating ?? this.rating,
        completedAt: completedAt ?? this.completedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  SessionLog copyWithCompanion(SessionLogsCompanion data) {
    return SessionLog(
      id: data.id.present ? data.id.value : this.id,
      assignmentId: data.assignmentId.present
          ? data.assignmentId.value
          : this.assignmentId,
      planId: data.planId.present ? data.planId.value : this.planId,
      sessionType:
          data.sessionType.present ? data.sessionType.value : this.sessionType,
      startSurah:
          data.startSurah.present ? data.startSurah.value : this.startSurah,
      startAyah: data.startAyah.present ? data.startAyah.value : this.startAyah,
      endSurah: data.endSurah.present ? data.endSurah.value : this.endSurah,
      endAyah: data.endAyah.present ? data.endAyah.value : this.endAyah,
      rating: data.rating.present ? data.rating.value : this.rating,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionLog(')
          ..write('id: $id, ')
          ..write('assignmentId: $assignmentId, ')
          ..write('planId: $planId, ')
          ..write('sessionType: $sessionType, ')
          ..write('startSurah: $startSurah, ')
          ..write('startAyah: $startAyah, ')
          ..write('endSurah: $endSurah, ')
          ..write('endAyah: $endAyah, ')
          ..write('rating: $rating, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, assignmentId, planId, sessionType,
      startSurah, startAyah, endSurah, endAyah, rating, completedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionLog &&
          other.id == this.id &&
          other.assignmentId == this.assignmentId &&
          other.planId == this.planId &&
          other.sessionType == this.sessionType &&
          other.startSurah == this.startSurah &&
          other.startAyah == this.startAyah &&
          other.endSurah == this.endSurah &&
          other.endAyah == this.endAyah &&
          other.rating == this.rating &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt);
}

class SessionLogsCompanion extends UpdateCompanion<SessionLog> {
  final Value<String> id;
  final Value<String> assignmentId;
  final Value<String> planId;
  final Value<String> sessionType;
  final Value<int?> startSurah;
  final Value<int?> startAyah;
  final Value<int?> endSurah;
  final Value<int?> endAyah;
  final Value<String> rating;
  final Value<DateTime> completedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SessionLogsCompanion({
    this.id = const Value.absent(),
    this.assignmentId = const Value.absent(),
    this.planId = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.startSurah = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endSurah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.rating = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionLogsCompanion.insert({
    required String id,
    required String assignmentId,
    required String planId,
    required String sessionType,
    this.startSurah = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endSurah = const Value.absent(),
    this.endAyah = const Value.absent(),
    required String rating,
    required DateTime completedAt,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        assignmentId = Value(assignmentId),
        planId = Value(planId),
        sessionType = Value(sessionType),
        rating = Value(rating),
        completedAt = Value(completedAt),
        createdAt = Value(createdAt);
  static Insertable<SessionLog> custom({
    Expression<String>? id,
    Expression<String>? assignmentId,
    Expression<String>? planId,
    Expression<String>? sessionType,
    Expression<int>? startSurah,
    Expression<int>? startAyah,
    Expression<int>? endSurah,
    Expression<int>? endAyah,
    Expression<String>? rating,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assignmentId != null) 'assignment_id': assignmentId,
      if (planId != null) 'plan_id': planId,
      if (sessionType != null) 'session_type': sessionType,
      if (startSurah != null) 'start_surah': startSurah,
      if (startAyah != null) 'start_ayah': startAyah,
      if (endSurah != null) 'end_surah': endSurah,
      if (endAyah != null) 'end_ayah': endAyah,
      if (rating != null) 'rating': rating,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? assignmentId,
      Value<String>? planId,
      Value<String>? sessionType,
      Value<int?>? startSurah,
      Value<int?>? startAyah,
      Value<int?>? endSurah,
      Value<int?>? endAyah,
      Value<String>? rating,
      Value<DateTime>? completedAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SessionLogsCompanion(
      id: id ?? this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      planId: planId ?? this.planId,
      sessionType: sessionType ?? this.sessionType,
      startSurah: startSurah ?? this.startSurah,
      startAyah: startAyah ?? this.startAyah,
      endSurah: endSurah ?? this.endSurah,
      endAyah: endAyah ?? this.endAyah,
      rating: rating ?? this.rating,
      completedAt: completedAt ?? this.completedAt,
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
    if (assignmentId.present) {
      map['assignment_id'] = Variable<String>(assignmentId.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<String>(sessionType.value);
    }
    if (startSurah.present) {
      map['start_surah'] = Variable<int>(startSurah.value);
    }
    if (startAyah.present) {
      map['start_ayah'] = Variable<int>(startAyah.value);
    }
    if (endSurah.present) {
      map['end_surah'] = Variable<int>(endSurah.value);
    }
    if (endAyah.present) {
      map['end_ayah'] = Variable<int>(endAyah.value);
    }
    if (rating.present) {
      map['rating'] = Variable<String>(rating.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
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
    return (StringBuffer('SessionLogsCompanion(')
          ..write('id: $id, ')
          ..write('assignmentId: $assignmentId, ')
          ..write('planId: $planId, ')
          ..write('sessionType: $sessionType, ')
          ..write('startSurah: $startSurah, ')
          ..write('startAyah: $startAyah, ')
          ..write('endSurah: $endSurah, ')
          ..write('endAyah: $endAyah, ')
          ..write('rating: $rating, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuranSegmentProgressesTable extends QuranSegmentProgresses
    with TableInfo<$QuranSegmentProgressesTable, QuranSegmentProgressesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuranSegmentProgressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startSurahMeta =
      const VerificationMeta('startSurah');
  @override
  late final GeneratedColumn<int> startSurah = GeneratedColumn<int>(
      'start_surah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startAyahMeta =
      const VerificationMeta('startAyah');
  @override
  late final GeneratedColumn<int> startAyah = GeneratedColumn<int>(
      'start_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endSurahMeta =
      const VerificationMeta('endSurah');
  @override
  late final GeneratedColumn<int> endSurah = GeneratedColumn<int>(
      'end_surah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endAyahMeta =
      const VerificationMeta('endAyah');
  @override
  late final GeneratedColumn<int> endAyah = GeneratedColumn<int>(
      'end_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _masteryScoreMeta =
      const VerificationMeta('masteryScore');
  @override
  late final GeneratedColumn<int> masteryScore = GeneratedColumn<int>(
      'mastery_score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastRatingMeta =
      const VerificationMeta('lastRating');
  @override
  late final GeneratedColumn<String> lastRating = GeneratedColumn<String>(
      'last_rating', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastPracticedAtMeta =
      const VerificationMeta('lastPracticedAt');
  @override
  late final GeneratedColumn<DateTime> lastPracticedAt =
      GeneratedColumn<DateTime>('last_practiced_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _nextReviewAtMeta =
      const VerificationMeta('nextReviewAt');
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
      'next_review_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('appMemorization'));
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        planId,
        startSurah,
        startAyah,
        endSurah,
        endAyah,
        status,
        masteryScore,
        lastRating,
        lastPracticedAt,
        nextReviewAt,
        source,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quran_segment_progresses';
  @override
  VerificationContext validateIntegrity(
      Insertable<QuranSegmentProgressesData> instance,
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
    if (data.containsKey('start_surah')) {
      context.handle(
          _startSurahMeta,
          startSurah.isAcceptableOrUnknown(
              data['start_surah']!, _startSurahMeta));
    } else if (isInserting) {
      context.missing(_startSurahMeta);
    }
    if (data.containsKey('start_ayah')) {
      context.handle(_startAyahMeta,
          startAyah.isAcceptableOrUnknown(data['start_ayah']!, _startAyahMeta));
    } else if (isInserting) {
      context.missing(_startAyahMeta);
    }
    if (data.containsKey('end_surah')) {
      context.handle(_endSurahMeta,
          endSurah.isAcceptableOrUnknown(data['end_surah']!, _endSurahMeta));
    } else if (isInserting) {
      context.missing(_endSurahMeta);
    }
    if (data.containsKey('end_ayah')) {
      context.handle(_endAyahMeta,
          endAyah.isAcceptableOrUnknown(data['end_ayah']!, _endAyahMeta));
    } else if (isInserting) {
      context.missing(_endAyahMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('mastery_score')) {
      context.handle(
          _masteryScoreMeta,
          masteryScore.isAcceptableOrUnknown(
              data['mastery_score']!, _masteryScoreMeta));
    } else if (isInserting) {
      context.missing(_masteryScoreMeta);
    }
    if (data.containsKey('last_rating')) {
      context.handle(
          _lastRatingMeta,
          lastRating.isAcceptableOrUnknown(
              data['last_rating']!, _lastRatingMeta));
    } else if (isInserting) {
      context.missing(_lastRatingMeta);
    }
    if (data.containsKey('last_practiced_at')) {
      context.handle(
          _lastPracticedAtMeta,
          lastPracticedAt.isAcceptableOrUnknown(
              data['last_practiced_at']!, _lastPracticedAtMeta));
    } else if (isInserting) {
      context.missing(_lastPracticedAtMeta);
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
          _nextReviewAtMeta,
          nextReviewAt.isAcceptableOrUnknown(
              data['next_review_at']!, _nextReviewAtMeta));
    } else if (isInserting) {
      context.missing(_nextReviewAtMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {planId, startSurah, startAyah, endSurah, endAyah},
      ];
  @override
  QuranSegmentProgressesData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuranSegmentProgressesData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_id'])!,
      startSurah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_surah'])!,
      startAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_ayah'])!,
      endSurah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_surah'])!,
      endAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_ayah'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      masteryScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mastery_score'])!,
      lastRating: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_rating'])!,
      lastPracticedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_practiced_at'])!,
      nextReviewAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_review_at'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $QuranSegmentProgressesTable createAlias(String alias) {
    return $QuranSegmentProgressesTable(attachedDatabase, alias);
  }
}

class QuranSegmentProgressesData extends DataClass
    implements Insertable<QuranSegmentProgressesData> {
  final String id;
  final String planId;
  final int startSurah;
  final int startAyah;
  final int endSurah;
  final int endAyah;
  final String status;
  final int masteryScore;
  final String lastRating;
  final DateTime lastPracticedAt;
  final DateTime nextReviewAt;
  final String source;
  final DateTime createdAt;
  final DateTime updatedAt;
  const QuranSegmentProgressesData(
      {required this.id,
      required this.planId,
      required this.startSurah,
      required this.startAyah,
      required this.endSurah,
      required this.endAyah,
      required this.status,
      required this.masteryScore,
      required this.lastRating,
      required this.lastPracticedAt,
      required this.nextReviewAt,
      required this.source,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['start_surah'] = Variable<int>(startSurah);
    map['start_ayah'] = Variable<int>(startAyah);
    map['end_surah'] = Variable<int>(endSurah);
    map['end_ayah'] = Variable<int>(endAyah);
    map['status'] = Variable<String>(status);
    map['mastery_score'] = Variable<int>(masteryScore);
    map['last_rating'] = Variable<String>(lastRating);
    map['last_practiced_at'] = Variable<DateTime>(lastPracticedAt);
    map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  QuranSegmentProgressesCompanion toCompanion(bool nullToAbsent) {
    return QuranSegmentProgressesCompanion(
      id: Value(id),
      planId: Value(planId),
      startSurah: Value(startSurah),
      startAyah: Value(startAyah),
      endSurah: Value(endSurah),
      endAyah: Value(endAyah),
      status: Value(status),
      masteryScore: Value(masteryScore),
      lastRating: Value(lastRating),
      lastPracticedAt: Value(lastPracticedAt),
      nextReviewAt: Value(nextReviewAt),
      source: Value(source),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory QuranSegmentProgressesData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuranSegmentProgressesData(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      startSurah: serializer.fromJson<int>(json['startSurah']),
      startAyah: serializer.fromJson<int>(json['startAyah']),
      endSurah: serializer.fromJson<int>(json['endSurah']),
      endAyah: serializer.fromJson<int>(json['endAyah']),
      status: serializer.fromJson<String>(json['status']),
      masteryScore: serializer.fromJson<int>(json['masteryScore']),
      lastRating: serializer.fromJson<String>(json['lastRating']),
      lastPracticedAt: serializer.fromJson<DateTime>(json['lastPracticedAt']),
      nextReviewAt: serializer.fromJson<DateTime>(json['nextReviewAt']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'startSurah': serializer.toJson<int>(startSurah),
      'startAyah': serializer.toJson<int>(startAyah),
      'endSurah': serializer.toJson<int>(endSurah),
      'endAyah': serializer.toJson<int>(endAyah),
      'status': serializer.toJson<String>(status),
      'masteryScore': serializer.toJson<int>(masteryScore),
      'lastRating': serializer.toJson<String>(lastRating),
      'lastPracticedAt': serializer.toJson<DateTime>(lastPracticedAt),
      'nextReviewAt': serializer.toJson<DateTime>(nextReviewAt),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  QuranSegmentProgressesData copyWith(
          {String? id,
          String? planId,
          int? startSurah,
          int? startAyah,
          int? endSurah,
          int? endAyah,
          String? status,
          int? masteryScore,
          String? lastRating,
          DateTime? lastPracticedAt,
          DateTime? nextReviewAt,
          String? source,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      QuranSegmentProgressesData(
        id: id ?? this.id,
        planId: planId ?? this.planId,
        startSurah: startSurah ?? this.startSurah,
        startAyah: startAyah ?? this.startAyah,
        endSurah: endSurah ?? this.endSurah,
        endAyah: endAyah ?? this.endAyah,
        status: status ?? this.status,
        masteryScore: masteryScore ?? this.masteryScore,
        lastRating: lastRating ?? this.lastRating,
        lastPracticedAt: lastPracticedAt ?? this.lastPracticedAt,
        nextReviewAt: nextReviewAt ?? this.nextReviewAt,
        source: source ?? this.source,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  QuranSegmentProgressesData copyWithCompanion(
      QuranSegmentProgressesCompanion data) {
    return QuranSegmentProgressesData(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      startSurah:
          data.startSurah.present ? data.startSurah.value : this.startSurah,
      startAyah: data.startAyah.present ? data.startAyah.value : this.startAyah,
      endSurah: data.endSurah.present ? data.endSurah.value : this.endSurah,
      endAyah: data.endAyah.present ? data.endAyah.value : this.endAyah,
      status: data.status.present ? data.status.value : this.status,
      masteryScore: data.masteryScore.present
          ? data.masteryScore.value
          : this.masteryScore,
      lastRating:
          data.lastRating.present ? data.lastRating.value : this.lastRating,
      lastPracticedAt: data.lastPracticedAt.present
          ? data.lastPracticedAt.value
          : this.lastPracticedAt,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuranSegmentProgressesData(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('startSurah: $startSurah, ')
          ..write('startAyah: $startAyah, ')
          ..write('endSurah: $endSurah, ')
          ..write('endAyah: $endAyah, ')
          ..write('status: $status, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('lastRating: $lastRating, ')
          ..write('lastPracticedAt: $lastPracticedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      planId,
      startSurah,
      startAyah,
      endSurah,
      endAyah,
      status,
      masteryScore,
      lastRating,
      lastPracticedAt,
      nextReviewAt,
      source,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuranSegmentProgressesData &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.startSurah == this.startSurah &&
          other.startAyah == this.startAyah &&
          other.endSurah == this.endSurah &&
          other.endAyah == this.endAyah &&
          other.status == this.status &&
          other.masteryScore == this.masteryScore &&
          other.lastRating == this.lastRating &&
          other.lastPracticedAt == this.lastPracticedAt &&
          other.nextReviewAt == this.nextReviewAt &&
          other.source == this.source &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class QuranSegmentProgressesCompanion
    extends UpdateCompanion<QuranSegmentProgressesData> {
  final Value<String> id;
  final Value<String> planId;
  final Value<int> startSurah;
  final Value<int> startAyah;
  final Value<int> endSurah;
  final Value<int> endAyah;
  final Value<String> status;
  final Value<int> masteryScore;
  final Value<String> lastRating;
  final Value<DateTime> lastPracticedAt;
  final Value<DateTime> nextReviewAt;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const QuranSegmentProgressesCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.startSurah = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endSurah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.status = const Value.absent(),
    this.masteryScore = const Value.absent(),
    this.lastRating = const Value.absent(),
    this.lastPracticedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuranSegmentProgressesCompanion.insert({
    required String id,
    required String planId,
    required int startSurah,
    required int startAyah,
    required int endSurah,
    required int endAyah,
    required String status,
    required int masteryScore,
    required String lastRating,
    required DateTime lastPracticedAt,
    required DateTime nextReviewAt,
    this.source = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        planId = Value(planId),
        startSurah = Value(startSurah),
        startAyah = Value(startAyah),
        endSurah = Value(endSurah),
        endAyah = Value(endAyah),
        status = Value(status),
        masteryScore = Value(masteryScore),
        lastRating = Value(lastRating),
        lastPracticedAt = Value(lastPracticedAt),
        nextReviewAt = Value(nextReviewAt),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<QuranSegmentProgressesData> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<int>? startSurah,
    Expression<int>? startAyah,
    Expression<int>? endSurah,
    Expression<int>? endAyah,
    Expression<String>? status,
    Expression<int>? masteryScore,
    Expression<String>? lastRating,
    Expression<DateTime>? lastPracticedAt,
    Expression<DateTime>? nextReviewAt,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (startSurah != null) 'start_surah': startSurah,
      if (startAyah != null) 'start_ayah': startAyah,
      if (endSurah != null) 'end_surah': endSurah,
      if (endAyah != null) 'end_ayah': endAyah,
      if (status != null) 'status': status,
      if (masteryScore != null) 'mastery_score': masteryScore,
      if (lastRating != null) 'last_rating': lastRating,
      if (lastPracticedAt != null) 'last_practiced_at': lastPracticedAt,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuranSegmentProgressesCompanion copyWith(
      {Value<String>? id,
      Value<String>? planId,
      Value<int>? startSurah,
      Value<int>? startAyah,
      Value<int>? endSurah,
      Value<int>? endAyah,
      Value<String>? status,
      Value<int>? masteryScore,
      Value<String>? lastRating,
      Value<DateTime>? lastPracticedAt,
      Value<DateTime>? nextReviewAt,
      Value<String>? source,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return QuranSegmentProgressesCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      startSurah: startSurah ?? this.startSurah,
      startAyah: startAyah ?? this.startAyah,
      endSurah: endSurah ?? this.endSurah,
      endAyah: endAyah ?? this.endAyah,
      status: status ?? this.status,
      masteryScore: masteryScore ?? this.masteryScore,
      lastRating: lastRating ?? this.lastRating,
      lastPracticedAt: lastPracticedAt ?? this.lastPracticedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (startSurah.present) {
      map['start_surah'] = Variable<int>(startSurah.value);
    }
    if (startAyah.present) {
      map['start_ayah'] = Variable<int>(startAyah.value);
    }
    if (endSurah.present) {
      map['end_surah'] = Variable<int>(endSurah.value);
    }
    if (endAyah.present) {
      map['end_ayah'] = Variable<int>(endAyah.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (masteryScore.present) {
      map['mastery_score'] = Variable<int>(masteryScore.value);
    }
    if (lastRating.present) {
      map['last_rating'] = Variable<String>(lastRating.value);
    }
    if (lastPracticedAt.present) {
      map['last_practiced_at'] = Variable<DateTime>(lastPracticedAt.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuranSegmentProgressesCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('startSurah: $startSurah, ')
          ..write('startAyah: $startAyah, ')
          ..write('endSurah: $endSurah, ')
          ..write('endAyah: $endAyah, ')
          ..write('status: $status, ')
          ..write('masteryScore: $masteryScore, ')
          ..write('lastRating: $lastRating, ')
          ..write('lastPracticedAt: $lastPracticedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PreviousMemorizedRangesTable extends PreviousMemorizedRanges
    with
        TableInfo<$PreviousMemorizedRangesTable, PreviousMemorizedRangeEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreviousMemorizedRangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startSurahMeta =
      const VerificationMeta('startSurah');
  @override
  late final GeneratedColumn<int> startSurah = GeneratedColumn<int>(
      'start_surah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startAyahMeta =
      const VerificationMeta('startAyah');
  @override
  late final GeneratedColumn<int> startAyah = GeneratedColumn<int>(
      'start_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endSurahMeta =
      const VerificationMeta('endSurah');
  @override
  late final GeneratedColumn<int> endSurah = GeneratedColumn<int>(
      'end_surah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endAyahMeta =
      const VerificationMeta('endAyah');
  @override
  late final GeneratedColumn<int> endAyah = GeneratedColumn<int>(
      'end_ayah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
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
  @override
  List<GeneratedColumn> get $columns => [
        id,
        planId,
        startSurah,
        startAyah,
        endSurah,
        endAyah,
        source,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'previous_memorized_ranges';
  @override
  VerificationContext validateIntegrity(
      Insertable<PreviousMemorizedRangeEntity> instance,
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
    if (data.containsKey('start_surah')) {
      context.handle(
          _startSurahMeta,
          startSurah.isAcceptableOrUnknown(
              data['start_surah']!, _startSurahMeta));
    } else if (isInserting) {
      context.missing(_startSurahMeta);
    }
    if (data.containsKey('start_ayah')) {
      context.handle(_startAyahMeta,
          startAyah.isAcceptableOrUnknown(data['start_ayah']!, _startAyahMeta));
    } else if (isInserting) {
      context.missing(_startAyahMeta);
    }
    if (data.containsKey('end_surah')) {
      context.handle(_endSurahMeta,
          endSurah.isAcceptableOrUnknown(data['end_surah']!, _endSurahMeta));
    } else if (isInserting) {
      context.missing(_endSurahMeta);
    }
    if (data.containsKey('end_ayah')) {
      context.handle(_endAyahMeta,
          endAyah.isAcceptableOrUnknown(data['end_ayah']!, _endAyahMeta));
    } else if (isInserting) {
      context.missing(_endAyahMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PreviousMemorizedRangeEntity map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreviousMemorizedRangeEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_id'])!,
      startSurah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_surah'])!,
      startAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_ayah'])!,
      endSurah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_surah'])!,
      endAyah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_ayah'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PreviousMemorizedRangesTable createAlias(String alias) {
    return $PreviousMemorizedRangesTable(attachedDatabase, alias);
  }
}

class PreviousMemorizedRangeEntity extends DataClass
    implements Insertable<PreviousMemorizedRangeEntity> {
  final String id;
  final String planId;
  final int startSurah;
  final int startAyah;
  final int endSurah;
  final int endAyah;
  final String source;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PreviousMemorizedRangeEntity(
      {required this.id,
      required this.planId,
      required this.startSurah,
      required this.startAyah,
      required this.endSurah,
      required this.endAyah,
      required this.source,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['start_surah'] = Variable<int>(startSurah);
    map['start_ayah'] = Variable<int>(startAyah);
    map['end_surah'] = Variable<int>(endSurah);
    map['end_ayah'] = Variable<int>(endAyah);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PreviousMemorizedRangesCompanion toCompanion(bool nullToAbsent) {
    return PreviousMemorizedRangesCompanion(
      id: Value(id),
      planId: Value(planId),
      startSurah: Value(startSurah),
      startAyah: Value(startAyah),
      endSurah: Value(endSurah),
      endAyah: Value(endAyah),
      source: Value(source),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PreviousMemorizedRangeEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreviousMemorizedRangeEntity(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      startSurah: serializer.fromJson<int>(json['startSurah']),
      startAyah: serializer.fromJson<int>(json['startAyah']),
      endSurah: serializer.fromJson<int>(json['endSurah']),
      endAyah: serializer.fromJson<int>(json['endAyah']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'startSurah': serializer.toJson<int>(startSurah),
      'startAyah': serializer.toJson<int>(startAyah),
      'endSurah': serializer.toJson<int>(endSurah),
      'endAyah': serializer.toJson<int>(endAyah),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PreviousMemorizedRangeEntity copyWith(
          {String? id,
          String? planId,
          int? startSurah,
          int? startAyah,
          int? endSurah,
          int? endAyah,
          String? source,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PreviousMemorizedRangeEntity(
        id: id ?? this.id,
        planId: planId ?? this.planId,
        startSurah: startSurah ?? this.startSurah,
        startAyah: startAyah ?? this.startAyah,
        endSurah: endSurah ?? this.endSurah,
        endAyah: endAyah ?? this.endAyah,
        source: source ?? this.source,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PreviousMemorizedRangeEntity copyWithCompanion(
      PreviousMemorizedRangesCompanion data) {
    return PreviousMemorizedRangeEntity(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      startSurah:
          data.startSurah.present ? data.startSurah.value : this.startSurah,
      startAyah: data.startAyah.present ? data.startAyah.value : this.startAyah,
      endSurah: data.endSurah.present ? data.endSurah.value : this.endSurah,
      endAyah: data.endAyah.present ? data.endAyah.value : this.endAyah,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreviousMemorizedRangeEntity(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('startSurah: $startSurah, ')
          ..write('startAyah: $startAyah, ')
          ..write('endSurah: $endSurah, ')
          ..write('endAyah: $endAyah, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, planId, startSurah, startAyah, endSurah,
      endAyah, source, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreviousMemorizedRangeEntity &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.startSurah == this.startSurah &&
          other.startAyah == this.startAyah &&
          other.endSurah == this.endSurah &&
          other.endAyah == this.endAyah &&
          other.source == this.source &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PreviousMemorizedRangesCompanion
    extends UpdateCompanion<PreviousMemorizedRangeEntity> {
  final Value<String> id;
  final Value<String> planId;
  final Value<int> startSurah;
  final Value<int> startAyah;
  final Value<int> endSurah;
  final Value<int> endAyah;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PreviousMemorizedRangesCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.startSurah = const Value.absent(),
    this.startAyah = const Value.absent(),
    this.endSurah = const Value.absent(),
    this.endAyah = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PreviousMemorizedRangesCompanion.insert({
    required String id,
    required String planId,
    required int startSurah,
    required int startAyah,
    required int endSurah,
    required int endAyah,
    required String source,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        planId = Value(planId),
        startSurah = Value(startSurah),
        startAyah = Value(startAyah),
        endSurah = Value(endSurah),
        endAyah = Value(endAyah),
        source = Value(source),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PreviousMemorizedRangeEntity> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<int>? startSurah,
    Expression<int>? startAyah,
    Expression<int>? endSurah,
    Expression<int>? endAyah,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (startSurah != null) 'start_surah': startSurah,
      if (startAyah != null) 'start_ayah': startAyah,
      if (endSurah != null) 'end_surah': endSurah,
      if (endAyah != null) 'end_ayah': endAyah,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PreviousMemorizedRangesCompanion copyWith(
      {Value<String>? id,
      Value<String>? planId,
      Value<int>? startSurah,
      Value<int>? startAyah,
      Value<int>? endSurah,
      Value<int>? endAyah,
      Value<String>? source,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PreviousMemorizedRangesCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      startSurah: startSurah ?? this.startSurah,
      startAyah: startAyah ?? this.startAyah,
      endSurah: endSurah ?? this.endSurah,
      endAyah: endAyah ?? this.endAyah,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (startSurah.present) {
      map['start_surah'] = Variable<int>(startSurah.value);
    }
    if (startAyah.present) {
      map['start_ayah'] = Variable<int>(startAyah.value);
    }
    if (endSurah.present) {
      map['end_surah'] = Variable<int>(endSurah.value);
    }
    if (endAyah.present) {
      map['end_ayah'] = Variable<int>(endAyah.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreviousMemorizedRangesCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('startSurah: $startSurah, ')
          ..write('startAyah: $startAyah, ')
          ..write('endSurah: $endSurah, ')
          ..write('endAyah: $endAyah, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TodayAdjustmentsTable extends TodayAdjustments
    with TableInfo<$TodayAdjustmentsTable, TodayAdjustmentEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodayAdjustmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateKeyMeta =
      const VerificationMeta('dateKey');
  @override
  late final GeneratedColumn<String> dateKey = GeneratedColumn<String>(
      'date_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deferMemorizationMeta =
      const VerificationMeta('deferMemorization');
  @override
  late final GeneratedColumn<bool> deferMemorization = GeneratedColumn<bool>(
      'defer_memorization', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("defer_memorization" IN (0, 1))'),
      defaultValue: const Constant(false));
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
  @override
  List<GeneratedColumn> get $columns =>
      [planId, dateKey, deferMemorization, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'today_adjustments';
  @override
  VerificationContext validateIntegrity(
      Insertable<TodayAdjustmentEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('defer_memorization')) {
      context.handle(
          _deferMemorizationMeta,
          deferMemorization.isAcceptableOrUnknown(
              data['defer_memorization']!, _deferMemorizationMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {planId, dateKey};
  @override
  TodayAdjustmentEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodayAdjustmentEntity(
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_id'])!,
      dateKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_key'])!,
      deferMemorization: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}defer_memorization'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TodayAdjustmentsTable createAlias(String alias) {
    return $TodayAdjustmentsTable(attachedDatabase, alias);
  }
}

class TodayAdjustmentEntity extends DataClass
    implements Insertable<TodayAdjustmentEntity> {
  final String planId;
  final String dateKey;
  final bool deferMemorization;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TodayAdjustmentEntity(
      {required this.planId,
      required this.dateKey,
      required this.deferMemorization,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['plan_id'] = Variable<String>(planId);
    map['date_key'] = Variable<String>(dateKey);
    map['defer_memorization'] = Variable<bool>(deferMemorization);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TodayAdjustmentsCompanion toCompanion(bool nullToAbsent) {
    return TodayAdjustmentsCompanion(
      planId: Value(planId),
      dateKey: Value(dateKey),
      deferMemorization: Value(deferMemorization),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TodayAdjustmentEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodayAdjustmentEntity(
      planId: serializer.fromJson<String>(json['planId']),
      dateKey: serializer.fromJson<String>(json['dateKey']),
      deferMemorization: serializer.fromJson<bool>(json['deferMemorization']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'planId': serializer.toJson<String>(planId),
      'dateKey': serializer.toJson<String>(dateKey),
      'deferMemorization': serializer.toJson<bool>(deferMemorization),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TodayAdjustmentEntity copyWith(
          {String? planId,
          String? dateKey,
          bool? deferMemorization,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TodayAdjustmentEntity(
        planId: planId ?? this.planId,
        dateKey: dateKey ?? this.dateKey,
        deferMemorization: deferMemorization ?? this.deferMemorization,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TodayAdjustmentEntity copyWithCompanion(TodayAdjustmentsCompanion data) {
    return TodayAdjustmentEntity(
      planId: data.planId.present ? data.planId.value : this.planId,
      dateKey: data.dateKey.present ? data.dateKey.value : this.dateKey,
      deferMemorization: data.deferMemorization.present
          ? data.deferMemorization.value
          : this.deferMemorization,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodayAdjustmentEntity(')
          ..write('planId: $planId, ')
          ..write('dateKey: $dateKey, ')
          ..write('deferMemorization: $deferMemorization, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(planId, dateKey, deferMemorization, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodayAdjustmentEntity &&
          other.planId == this.planId &&
          other.dateKey == this.dateKey &&
          other.deferMemorization == this.deferMemorization &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TodayAdjustmentsCompanion extends UpdateCompanion<TodayAdjustmentEntity> {
  final Value<String> planId;
  final Value<String> dateKey;
  final Value<bool> deferMemorization;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TodayAdjustmentsCompanion({
    this.planId = const Value.absent(),
    this.dateKey = const Value.absent(),
    this.deferMemorization = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TodayAdjustmentsCompanion.insert({
    required String planId,
    required String dateKey,
    this.deferMemorization = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : planId = Value(planId),
        dateKey = Value(dateKey),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TodayAdjustmentEntity> custom({
    Expression<String>? planId,
    Expression<String>? dateKey,
    Expression<bool>? deferMemorization,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (planId != null) 'plan_id': planId,
      if (dateKey != null) 'date_key': dateKey,
      if (deferMemorization != null) 'defer_memorization': deferMemorization,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TodayAdjustmentsCompanion copyWith(
      {Value<String>? planId,
      Value<String>? dateKey,
      Value<bool>? deferMemorization,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return TodayAdjustmentsCompanion(
      planId: planId ?? this.planId,
      dateKey: dateKey ?? this.dateKey,
      deferMemorization: deferMemorization ?? this.deferMemorization,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (dateKey.present) {
      map['date_key'] = Variable<String>(dateKey.value);
    }
    if (deferMemorization.present) {
      map['defer_memorization'] = Variable<bool>(deferMemorization.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodayAdjustmentsCompanion(')
          ..write('planId: $planId, ')
          ..write('dateKey: $dateKey, ')
          ..write('deferMemorization: $deferMemorization, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecoveryResolutionsTable extends RecoveryResolutions
    with TableInfo<$RecoveryResolutionsTable, RecoveryResolutionEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecoveryResolutionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resolvedBeforeDateKeyMeta =
      const VerificationMeta('resolvedBeforeDateKey');
  @override
  late final GeneratedColumn<String> resolvedBeforeDateKey =
      GeneratedColumn<String>('resolved_before_date_key', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resolvedAtMeta =
      const VerificationMeta('resolvedAt');
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
      'resolved_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
  @override
  List<GeneratedColumn> get $columns =>
      [planId, resolvedBeforeDateKey, resolvedAt, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recovery_resolutions';
  @override
  VerificationContext validateIntegrity(
      Insertable<RecoveryResolutionEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('plan_id')) {
      context.handle(_planIdMeta,
          planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta));
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('resolved_before_date_key')) {
      context.handle(
          _resolvedBeforeDateKeyMeta,
          resolvedBeforeDateKey.isAcceptableOrUnknown(
              data['resolved_before_date_key']!, _resolvedBeforeDateKeyMeta));
    } else if (isInserting) {
      context.missing(_resolvedBeforeDateKeyMeta);
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
          _resolvedAtMeta,
          resolvedAt.isAcceptableOrUnknown(
              data['resolved_at']!, _resolvedAtMeta));
    } else if (isInserting) {
      context.missing(_resolvedAtMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {planId};
  @override
  RecoveryResolutionEntity map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecoveryResolutionEntity(
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_id'])!,
      resolvedBeforeDateKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}resolved_before_date_key'])!,
      resolvedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}resolved_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RecoveryResolutionsTable createAlias(String alias) {
    return $RecoveryResolutionsTable(attachedDatabase, alias);
  }
}

class RecoveryResolutionEntity extends DataClass
    implements Insertable<RecoveryResolutionEntity> {
  final String planId;
  final String resolvedBeforeDateKey;
  final DateTime resolvedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RecoveryResolutionEntity(
      {required this.planId,
      required this.resolvedBeforeDateKey,
      required this.resolvedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['plan_id'] = Variable<String>(planId);
    map['resolved_before_date_key'] = Variable<String>(resolvedBeforeDateKey);
    map['resolved_at'] = Variable<DateTime>(resolvedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecoveryResolutionsCompanion toCompanion(bool nullToAbsent) {
    return RecoveryResolutionsCompanion(
      planId: Value(planId),
      resolvedBeforeDateKey: Value(resolvedBeforeDateKey),
      resolvedAt: Value(resolvedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecoveryResolutionEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecoveryResolutionEntity(
      planId: serializer.fromJson<String>(json['planId']),
      resolvedBeforeDateKey:
          serializer.fromJson<String>(json['resolvedBeforeDateKey']),
      resolvedAt: serializer.fromJson<DateTime>(json['resolvedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'planId': serializer.toJson<String>(planId),
      'resolvedBeforeDateKey': serializer.toJson<String>(resolvedBeforeDateKey),
      'resolvedAt': serializer.toJson<DateTime>(resolvedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RecoveryResolutionEntity copyWith(
          {String? planId,
          String? resolvedBeforeDateKey,
          DateTime? resolvedAt,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RecoveryResolutionEntity(
        planId: planId ?? this.planId,
        resolvedBeforeDateKey:
            resolvedBeforeDateKey ?? this.resolvedBeforeDateKey,
        resolvedAt: resolvedAt ?? this.resolvedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  RecoveryResolutionEntity copyWithCompanion(
      RecoveryResolutionsCompanion data) {
    return RecoveryResolutionEntity(
      planId: data.planId.present ? data.planId.value : this.planId,
      resolvedBeforeDateKey: data.resolvedBeforeDateKey.present
          ? data.resolvedBeforeDateKey.value
          : this.resolvedBeforeDateKey,
      resolvedAt:
          data.resolvedAt.present ? data.resolvedAt.value : this.resolvedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryResolutionEntity(')
          ..write('planId: $planId, ')
          ..write('resolvedBeforeDateKey: $resolvedBeforeDateKey, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      planId, resolvedBeforeDateKey, resolvedAt, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecoveryResolutionEntity &&
          other.planId == this.planId &&
          other.resolvedBeforeDateKey == this.resolvedBeforeDateKey &&
          other.resolvedAt == this.resolvedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecoveryResolutionsCompanion
    extends UpdateCompanion<RecoveryResolutionEntity> {
  final Value<String> planId;
  final Value<String> resolvedBeforeDateKey;
  final Value<DateTime> resolvedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RecoveryResolutionsCompanion({
    this.planId = const Value.absent(),
    this.resolvedBeforeDateKey = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecoveryResolutionsCompanion.insert({
    required String planId,
    required String resolvedBeforeDateKey,
    required DateTime resolvedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : planId = Value(planId),
        resolvedBeforeDateKey = Value(resolvedBeforeDateKey),
        resolvedAt = Value(resolvedAt),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<RecoveryResolutionEntity> custom({
    Expression<String>? planId,
    Expression<String>? resolvedBeforeDateKey,
    Expression<DateTime>? resolvedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (planId != null) 'plan_id': planId,
      if (resolvedBeforeDateKey != null)
        'resolved_before_date_key': resolvedBeforeDateKey,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecoveryResolutionsCompanion copyWith(
      {Value<String>? planId,
      Value<String>? resolvedBeforeDateKey,
      Value<DateTime>? resolvedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return RecoveryResolutionsCompanion(
      planId: planId ?? this.planId,
      resolvedBeforeDateKey:
          resolvedBeforeDateKey ?? this.resolvedBeforeDateKey,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (resolvedBeforeDateKey.present) {
      map['resolved_before_date_key'] =
          Variable<String>(resolvedBeforeDateKey.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryResolutionsCompanion(')
          ..write('planId: $planId, ')
          ..write('resolvedBeforeDateKey: $resolvedBeforeDateKey, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
  late final $SessionLogsTable sessionLogs = $SessionLogsTable(this);
  late final $QuranSegmentProgressesTable quranSegmentProgresses =
      $QuranSegmentProgressesTable(this);
  late final $PreviousMemorizedRangesTable previousMemorizedRanges =
      $PreviousMemorizedRangesTable(this);
  late final $TodayAdjustmentsTable todayAdjustments =
      $TodayAdjustmentsTable(this);
  late final $RecoveryResolutionsTable recoveryResolutions =
      $RecoveryResolutionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        activePlans,
        dayAssignments,
        sessionLogs,
        quranSegmentProgresses,
        previousMemorizedRanges,
        todayAdjustments,
        recoveryResolutions
      ];
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
  Value<String> memorizationDays,
  Value<String> reviewSchedule,
  Value<String> customReviewDays,
  Value<String> previousMemorizedRanges,
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
  Value<String> memorizationDays,
  Value<String> reviewSchedule,
  Value<String> customReviewDays,
  Value<String> previousMemorizedRanges,
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

  ColumnFilters<String> get memorizationDays => $composableBuilder(
      column: $table.memorizationDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewSchedule => $composableBuilder(
      column: $table.reviewSchedule,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customReviewDays => $composableBuilder(
      column: $table.customReviewDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get previousMemorizedRanges => $composableBuilder(
      column: $table.previousMemorizedRanges,
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

  ColumnOrderings<String> get memorizationDays => $composableBuilder(
      column: $table.memorizationDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewSchedule => $composableBuilder(
      column: $table.reviewSchedule,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customReviewDays => $composableBuilder(
      column: $table.customReviewDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get previousMemorizedRanges => $composableBuilder(
      column: $table.previousMemorizedRanges,
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

  GeneratedColumn<String> get memorizationDays => $composableBuilder(
      column: $table.memorizationDays, builder: (column) => column);

  GeneratedColumn<String> get reviewSchedule => $composableBuilder(
      column: $table.reviewSchedule, builder: (column) => column);

  GeneratedColumn<String> get customReviewDays => $composableBuilder(
      column: $table.customReviewDays, builder: (column) => column);

  GeneratedColumn<String> get previousMemorizedRanges => $composableBuilder(
      column: $table.previousMemorizedRanges, builder: (column) => column);

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
            Value<String> memorizationDays = const Value.absent(),
            Value<String> reviewSchedule = const Value.absent(),
            Value<String> customReviewDays = const Value.absent(),
            Value<String> previousMemorizedRanges = const Value.absent(),
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
            memorizationDays: memorizationDays,
            reviewSchedule: reviewSchedule,
            customReviewDays: customReviewDays,
            previousMemorizedRanges: previousMemorizedRanges,
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
            Value<String> memorizationDays = const Value.absent(),
            Value<String> reviewSchedule = const Value.absent(),
            Value<String> customReviewDays = const Value.absent(),
            Value<String> previousMemorizedRanges = const Value.absent(),
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
            memorizationDays: memorizationDays,
            reviewSchedule: reviewSchedule,
            customReviewDays: customReviewDays,
            previousMemorizedRanges: previousMemorizedRanges,
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
  Value<bool> hasMemoTask,
  Value<bool> hasReviewTask,
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
  Value<bool> hasMemoTask,
  Value<bool> hasReviewTask,
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

  ColumnFilters<bool> get hasMemoTask => $composableBuilder(
      column: $table.hasMemoTask, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasReviewTask => $composableBuilder(
      column: $table.hasReviewTask, builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<bool> get hasMemoTask => $composableBuilder(
      column: $table.hasMemoTask, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasReviewTask => $composableBuilder(
      column: $table.hasReviewTask,
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

  GeneratedColumn<bool> get hasMemoTask => $composableBuilder(
      column: $table.hasMemoTask, builder: (column) => column);

  GeneratedColumn<bool> get hasReviewTask => $composableBuilder(
      column: $table.hasReviewTask, builder: (column) => column);

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
            Value<bool> hasMemoTask = const Value.absent(),
            Value<bool> hasReviewTask = const Value.absent(),
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
            hasMemoTask: hasMemoTask,
            hasReviewTask: hasReviewTask,
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
            Value<bool> hasMemoTask = const Value.absent(),
            Value<bool> hasReviewTask = const Value.absent(),
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
            hasMemoTask: hasMemoTask,
            hasReviewTask: hasReviewTask,
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
typedef $$SessionLogsTableCreateCompanionBuilder = SessionLogsCompanion
    Function({
  required String id,
  required String assignmentId,
  required String planId,
  required String sessionType,
  Value<int?> startSurah,
  Value<int?> startAyah,
  Value<int?> endSurah,
  Value<int?> endAyah,
  required String rating,
  required DateTime completedAt,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SessionLogsTableUpdateCompanionBuilder = SessionLogsCompanion
    Function({
  Value<String> id,
  Value<String> assignmentId,
  Value<String> planId,
  Value<String> sessionType,
  Value<int?> startSurah,
  Value<int?> startAyah,
  Value<int?> endSurah,
  Value<int?> endAyah,
  Value<String> rating,
  Value<DateTime> completedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SessionLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionLogsTable> {
  $$SessionLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assignmentId => $composableBuilder(
      column: $table.assignmentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionType => $composableBuilder(
      column: $table.sessionType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startSurah => $composableBuilder(
      column: $table.startSurah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endSurah => $composableBuilder(
      column: $table.endSurah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SessionLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionLogsTable> {
  $$SessionLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assignmentId => $composableBuilder(
      column: $table.assignmentId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionType => $composableBuilder(
      column: $table.sessionType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startSurah => $composableBuilder(
      column: $table.startSurah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endSurah => $composableBuilder(
      column: $table.endSurah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SessionLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionLogsTable> {
  $$SessionLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get assignmentId => $composableBuilder(
      column: $table.assignmentId, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get sessionType => $composableBuilder(
      column: $table.sessionType, builder: (column) => column);

  GeneratedColumn<int> get startSurah => $composableBuilder(
      column: $table.startSurah, builder: (column) => column);

  GeneratedColumn<int> get startAyah =>
      $composableBuilder(column: $table.startAyah, builder: (column) => column);

  GeneratedColumn<int> get endSurah =>
      $composableBuilder(column: $table.endSurah, builder: (column) => column);

  GeneratedColumn<int> get endAyah =>
      $composableBuilder(column: $table.endAyah, builder: (column) => column);

  GeneratedColumn<String> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SessionLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessionLogsTable,
    SessionLog,
    $$SessionLogsTableFilterComposer,
    $$SessionLogsTableOrderingComposer,
    $$SessionLogsTableAnnotationComposer,
    $$SessionLogsTableCreateCompanionBuilder,
    $$SessionLogsTableUpdateCompanionBuilder,
    (SessionLog, BaseReferences<_$AppDatabase, $SessionLogsTable, SessionLog>),
    SessionLog,
    PrefetchHooks Function()> {
  $$SessionLogsTableTableManager(_$AppDatabase db, $SessionLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> assignmentId = const Value.absent(),
            Value<String> planId = const Value.absent(),
            Value<String> sessionType = const Value.absent(),
            Value<int?> startSurah = const Value.absent(),
            Value<int?> startAyah = const Value.absent(),
            Value<int?> endSurah = const Value.absent(),
            Value<int?> endAyah = const Value.absent(),
            Value<String> rating = const Value.absent(),
            Value<DateTime> completedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionLogsCompanion(
            id: id,
            assignmentId: assignmentId,
            planId: planId,
            sessionType: sessionType,
            startSurah: startSurah,
            startAyah: startAyah,
            endSurah: endSurah,
            endAyah: endAyah,
            rating: rating,
            completedAt: completedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String assignmentId,
            required String planId,
            required String sessionType,
            Value<int?> startSurah = const Value.absent(),
            Value<int?> startAyah = const Value.absent(),
            Value<int?> endSurah = const Value.absent(),
            Value<int?> endAyah = const Value.absent(),
            required String rating,
            required DateTime completedAt,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionLogsCompanion.insert(
            id: id,
            assignmentId: assignmentId,
            planId: planId,
            sessionType: sessionType,
            startSurah: startSurah,
            startAyah: startAyah,
            endSurah: endSurah,
            endAyah: endAyah,
            rating: rating,
            completedAt: completedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SessionLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SessionLogsTable,
    SessionLog,
    $$SessionLogsTableFilterComposer,
    $$SessionLogsTableOrderingComposer,
    $$SessionLogsTableAnnotationComposer,
    $$SessionLogsTableCreateCompanionBuilder,
    $$SessionLogsTableUpdateCompanionBuilder,
    (SessionLog, BaseReferences<_$AppDatabase, $SessionLogsTable, SessionLog>),
    SessionLog,
    PrefetchHooks Function()>;
typedef $$QuranSegmentProgressesTableCreateCompanionBuilder
    = QuranSegmentProgressesCompanion Function({
  required String id,
  required String planId,
  required int startSurah,
  required int startAyah,
  required int endSurah,
  required int endAyah,
  required String status,
  required int masteryScore,
  required String lastRating,
  required DateTime lastPracticedAt,
  required DateTime nextReviewAt,
  Value<String> source,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$QuranSegmentProgressesTableUpdateCompanionBuilder
    = QuranSegmentProgressesCompanion Function({
  Value<String> id,
  Value<String> planId,
  Value<int> startSurah,
  Value<int> startAyah,
  Value<int> endSurah,
  Value<int> endAyah,
  Value<String> status,
  Value<int> masteryScore,
  Value<String> lastRating,
  Value<DateTime> lastPracticedAt,
  Value<DateTime> nextReviewAt,
  Value<String> source,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$QuranSegmentProgressesTableFilterComposer
    extends Composer<_$AppDatabase, $QuranSegmentProgressesTable> {
  $$QuranSegmentProgressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startSurah => $composableBuilder(
      column: $table.startSurah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endSurah => $composableBuilder(
      column: $table.endSurah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get masteryScore => $composableBuilder(
      column: $table.masteryScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastRating => $composableBuilder(
      column: $table.lastRating, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastPracticedAt => $composableBuilder(
      column: $table.lastPracticedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
      column: $table.nextReviewAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$QuranSegmentProgressesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuranSegmentProgressesTable> {
  $$QuranSegmentProgressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startSurah => $composableBuilder(
      column: $table.startSurah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endSurah => $composableBuilder(
      column: $table.endSurah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get masteryScore => $composableBuilder(
      column: $table.masteryScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastRating => $composableBuilder(
      column: $table.lastRating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastPracticedAt => $composableBuilder(
      column: $table.lastPracticedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
      column: $table.nextReviewAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$QuranSegmentProgressesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuranSegmentProgressesTable> {
  $$QuranSegmentProgressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<int> get startSurah => $composableBuilder(
      column: $table.startSurah, builder: (column) => column);

  GeneratedColumn<int> get startAyah =>
      $composableBuilder(column: $table.startAyah, builder: (column) => column);

  GeneratedColumn<int> get endSurah =>
      $composableBuilder(column: $table.endSurah, builder: (column) => column);

  GeneratedColumn<int> get endAyah =>
      $composableBuilder(column: $table.endAyah, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get masteryScore => $composableBuilder(
      column: $table.masteryScore, builder: (column) => column);

  GeneratedColumn<String> get lastRating => $composableBuilder(
      column: $table.lastRating, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPracticedAt => $composableBuilder(
      column: $table.lastPracticedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
      column: $table.nextReviewAt, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$QuranSegmentProgressesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuranSegmentProgressesTable,
    QuranSegmentProgressesData,
    $$QuranSegmentProgressesTableFilterComposer,
    $$QuranSegmentProgressesTableOrderingComposer,
    $$QuranSegmentProgressesTableAnnotationComposer,
    $$QuranSegmentProgressesTableCreateCompanionBuilder,
    $$QuranSegmentProgressesTableUpdateCompanionBuilder,
    (
      QuranSegmentProgressesData,
      BaseReferences<_$AppDatabase, $QuranSegmentProgressesTable,
          QuranSegmentProgressesData>
    ),
    QuranSegmentProgressesData,
    PrefetchHooks Function()> {
  $$QuranSegmentProgressesTableTableManager(
      _$AppDatabase db, $QuranSegmentProgressesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuranSegmentProgressesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$QuranSegmentProgressesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuranSegmentProgressesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> planId = const Value.absent(),
            Value<int> startSurah = const Value.absent(),
            Value<int> startAyah = const Value.absent(),
            Value<int> endSurah = const Value.absent(),
            Value<int> endAyah = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> masteryScore = const Value.absent(),
            Value<String> lastRating = const Value.absent(),
            Value<DateTime> lastPracticedAt = const Value.absent(),
            Value<DateTime> nextReviewAt = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuranSegmentProgressesCompanion(
            id: id,
            planId: planId,
            startSurah: startSurah,
            startAyah: startAyah,
            endSurah: endSurah,
            endAyah: endAyah,
            status: status,
            masteryScore: masteryScore,
            lastRating: lastRating,
            lastPracticedAt: lastPracticedAt,
            nextReviewAt: nextReviewAt,
            source: source,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String planId,
            required int startSurah,
            required int startAyah,
            required int endSurah,
            required int endAyah,
            required String status,
            required int masteryScore,
            required String lastRating,
            required DateTime lastPracticedAt,
            required DateTime nextReviewAt,
            Value<String> source = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              QuranSegmentProgressesCompanion.insert(
            id: id,
            planId: planId,
            startSurah: startSurah,
            startAyah: startAyah,
            endSurah: endSurah,
            endAyah: endAyah,
            status: status,
            masteryScore: masteryScore,
            lastRating: lastRating,
            lastPracticedAt: lastPracticedAt,
            nextReviewAt: nextReviewAt,
            source: source,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuranSegmentProgressesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $QuranSegmentProgressesTable,
        QuranSegmentProgressesData,
        $$QuranSegmentProgressesTableFilterComposer,
        $$QuranSegmentProgressesTableOrderingComposer,
        $$QuranSegmentProgressesTableAnnotationComposer,
        $$QuranSegmentProgressesTableCreateCompanionBuilder,
        $$QuranSegmentProgressesTableUpdateCompanionBuilder,
        (
          QuranSegmentProgressesData,
          BaseReferences<_$AppDatabase, $QuranSegmentProgressesTable,
              QuranSegmentProgressesData>
        ),
        QuranSegmentProgressesData,
        PrefetchHooks Function()>;
typedef $$PreviousMemorizedRangesTableCreateCompanionBuilder
    = PreviousMemorizedRangesCompanion Function({
  required String id,
  required String planId,
  required int startSurah,
  required int startAyah,
  required int endSurah,
  required int endAyah,
  required String source,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PreviousMemorizedRangesTableUpdateCompanionBuilder
    = PreviousMemorizedRangesCompanion Function({
  Value<String> id,
  Value<String> planId,
  Value<int> startSurah,
  Value<int> startAyah,
  Value<int> endSurah,
  Value<int> endAyah,
  Value<String> source,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$PreviousMemorizedRangesTableFilterComposer
    extends Composer<_$AppDatabase, $PreviousMemorizedRangesTable> {
  $$PreviousMemorizedRangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startSurah => $composableBuilder(
      column: $table.startSurah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endSurah => $composableBuilder(
      column: $table.endSurah, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$PreviousMemorizedRangesTableOrderingComposer
    extends Composer<_$AppDatabase, $PreviousMemorizedRangesTable> {
  $$PreviousMemorizedRangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startSurah => $composableBuilder(
      column: $table.startSurah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startAyah => $composableBuilder(
      column: $table.startAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endSurah => $composableBuilder(
      column: $table.endSurah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endAyah => $composableBuilder(
      column: $table.endAyah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PreviousMemorizedRangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreviousMemorizedRangesTable> {
  $$PreviousMemorizedRangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<int> get startSurah => $composableBuilder(
      column: $table.startSurah, builder: (column) => column);

  GeneratedColumn<int> get startAyah =>
      $composableBuilder(column: $table.startAyah, builder: (column) => column);

  GeneratedColumn<int> get endSurah =>
      $composableBuilder(column: $table.endSurah, builder: (column) => column);

  GeneratedColumn<int> get endAyah =>
      $composableBuilder(column: $table.endAyah, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PreviousMemorizedRangesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PreviousMemorizedRangesTable,
    PreviousMemorizedRangeEntity,
    $$PreviousMemorizedRangesTableFilterComposer,
    $$PreviousMemorizedRangesTableOrderingComposer,
    $$PreviousMemorizedRangesTableAnnotationComposer,
    $$PreviousMemorizedRangesTableCreateCompanionBuilder,
    $$PreviousMemorizedRangesTableUpdateCompanionBuilder,
    (
      PreviousMemorizedRangeEntity,
      BaseReferences<_$AppDatabase, $PreviousMemorizedRangesTable,
          PreviousMemorizedRangeEntity>
    ),
    PreviousMemorizedRangeEntity,
    PrefetchHooks Function()> {
  $$PreviousMemorizedRangesTableTableManager(
      _$AppDatabase db, $PreviousMemorizedRangesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreviousMemorizedRangesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$PreviousMemorizedRangesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreviousMemorizedRangesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> planId = const Value.absent(),
            Value<int> startSurah = const Value.absent(),
            Value<int> startAyah = const Value.absent(),
            Value<int> endSurah = const Value.absent(),
            Value<int> endAyah = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PreviousMemorizedRangesCompanion(
            id: id,
            planId: planId,
            startSurah: startSurah,
            startAyah: startAyah,
            endSurah: endSurah,
            endAyah: endAyah,
            source: source,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String planId,
            required int startSurah,
            required int startAyah,
            required int endSurah,
            required int endAyah,
            required String source,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PreviousMemorizedRangesCompanion.insert(
            id: id,
            planId: planId,
            startSurah: startSurah,
            startAyah: startAyah,
            endSurah: endSurah,
            endAyah: endAyah,
            source: source,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PreviousMemorizedRangesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $PreviousMemorizedRangesTable,
        PreviousMemorizedRangeEntity,
        $$PreviousMemorizedRangesTableFilterComposer,
        $$PreviousMemorizedRangesTableOrderingComposer,
        $$PreviousMemorizedRangesTableAnnotationComposer,
        $$PreviousMemorizedRangesTableCreateCompanionBuilder,
        $$PreviousMemorizedRangesTableUpdateCompanionBuilder,
        (
          PreviousMemorizedRangeEntity,
          BaseReferences<_$AppDatabase, $PreviousMemorizedRangesTable,
              PreviousMemorizedRangeEntity>
        ),
        PreviousMemorizedRangeEntity,
        PrefetchHooks Function()>;
typedef $$TodayAdjustmentsTableCreateCompanionBuilder
    = TodayAdjustmentsCompanion Function({
  required String planId,
  required String dateKey,
  Value<bool> deferMemorization,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TodayAdjustmentsTableUpdateCompanionBuilder
    = TodayAdjustmentsCompanion Function({
  Value<String> planId,
  Value<String> dateKey,
  Value<bool> deferMemorization,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$TodayAdjustmentsTableFilterComposer
    extends Composer<_$AppDatabase, $TodayAdjustmentsTable> {
  $$TodayAdjustmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateKey => $composableBuilder(
      column: $table.dateKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get deferMemorization => $composableBuilder(
      column: $table.deferMemorization,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TodayAdjustmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $TodayAdjustmentsTable> {
  $$TodayAdjustmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateKey => $composableBuilder(
      column: $table.dateKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get deferMemorization => $composableBuilder(
      column: $table.deferMemorization,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TodayAdjustmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodayAdjustmentsTable> {
  $$TodayAdjustmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get dateKey =>
      $composableBuilder(column: $table.dateKey, builder: (column) => column);

  GeneratedColumn<bool> get deferMemorization => $composableBuilder(
      column: $table.deferMemorization, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TodayAdjustmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TodayAdjustmentsTable,
    TodayAdjustmentEntity,
    $$TodayAdjustmentsTableFilterComposer,
    $$TodayAdjustmentsTableOrderingComposer,
    $$TodayAdjustmentsTableAnnotationComposer,
    $$TodayAdjustmentsTableCreateCompanionBuilder,
    $$TodayAdjustmentsTableUpdateCompanionBuilder,
    (
      TodayAdjustmentEntity,
      BaseReferences<_$AppDatabase, $TodayAdjustmentsTable,
          TodayAdjustmentEntity>
    ),
    TodayAdjustmentEntity,
    PrefetchHooks Function()> {
  $$TodayAdjustmentsTableTableManager(
      _$AppDatabase db, $TodayAdjustmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodayAdjustmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodayAdjustmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodayAdjustmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> planId = const Value.absent(),
            Value<String> dateKey = const Value.absent(),
            Value<bool> deferMemorization = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TodayAdjustmentsCompanion(
            planId: planId,
            dateKey: dateKey,
            deferMemorization: deferMemorization,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String planId,
            required String dateKey,
            Value<bool> deferMemorization = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TodayAdjustmentsCompanion.insert(
            planId: planId,
            dateKey: dateKey,
            deferMemorization: deferMemorization,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TodayAdjustmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TodayAdjustmentsTable,
    TodayAdjustmentEntity,
    $$TodayAdjustmentsTableFilterComposer,
    $$TodayAdjustmentsTableOrderingComposer,
    $$TodayAdjustmentsTableAnnotationComposer,
    $$TodayAdjustmentsTableCreateCompanionBuilder,
    $$TodayAdjustmentsTableUpdateCompanionBuilder,
    (
      TodayAdjustmentEntity,
      BaseReferences<_$AppDatabase, $TodayAdjustmentsTable,
          TodayAdjustmentEntity>
    ),
    TodayAdjustmentEntity,
    PrefetchHooks Function()>;
typedef $$RecoveryResolutionsTableCreateCompanionBuilder
    = RecoveryResolutionsCompanion Function({
  required String planId,
  required String resolvedBeforeDateKey,
  required DateTime resolvedAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$RecoveryResolutionsTableUpdateCompanionBuilder
    = RecoveryResolutionsCompanion Function({
  Value<String> planId,
  Value<String> resolvedBeforeDateKey,
  Value<DateTime> resolvedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$RecoveryResolutionsTableFilterComposer
    extends Composer<_$AppDatabase, $RecoveryResolutionsTable> {
  $$RecoveryResolutionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resolvedBeforeDateKey => $composableBuilder(
      column: $table.resolvedBeforeDateKey,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
      column: $table.resolvedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$RecoveryResolutionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecoveryResolutionsTable> {
  $$RecoveryResolutionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resolvedBeforeDateKey => $composableBuilder(
      column: $table.resolvedBeforeDateKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
      column: $table.resolvedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$RecoveryResolutionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecoveryResolutionsTable> {
  $$RecoveryResolutionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get resolvedBeforeDateKey => $composableBuilder(
      column: $table.resolvedBeforeDateKey, builder: (column) => column);

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
      column: $table.resolvedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RecoveryResolutionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecoveryResolutionsTable,
    RecoveryResolutionEntity,
    $$RecoveryResolutionsTableFilterComposer,
    $$RecoveryResolutionsTableOrderingComposer,
    $$RecoveryResolutionsTableAnnotationComposer,
    $$RecoveryResolutionsTableCreateCompanionBuilder,
    $$RecoveryResolutionsTableUpdateCompanionBuilder,
    (
      RecoveryResolutionEntity,
      BaseReferences<_$AppDatabase, $RecoveryResolutionsTable,
          RecoveryResolutionEntity>
    ),
    RecoveryResolutionEntity,
    PrefetchHooks Function()> {
  $$RecoveryResolutionsTableTableManager(
      _$AppDatabase db, $RecoveryResolutionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecoveryResolutionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecoveryResolutionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecoveryResolutionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> planId = const Value.absent(),
            Value<String> resolvedBeforeDateKey = const Value.absent(),
            Value<DateTime> resolvedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecoveryResolutionsCompanion(
            planId: planId,
            resolvedBeforeDateKey: resolvedBeforeDateKey,
            resolvedAt: resolvedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String planId,
            required String resolvedBeforeDateKey,
            required DateTime resolvedAt,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RecoveryResolutionsCompanion.insert(
            planId: planId,
            resolvedBeforeDateKey: resolvedBeforeDateKey,
            resolvedAt: resolvedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecoveryResolutionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecoveryResolutionsTable,
    RecoveryResolutionEntity,
    $$RecoveryResolutionsTableFilterComposer,
    $$RecoveryResolutionsTableOrderingComposer,
    $$RecoveryResolutionsTableAnnotationComposer,
    $$RecoveryResolutionsTableCreateCompanionBuilder,
    $$RecoveryResolutionsTableUpdateCompanionBuilder,
    (
      RecoveryResolutionEntity,
      BaseReferences<_$AppDatabase, $RecoveryResolutionsTable,
          RecoveryResolutionEntity>
    ),
    RecoveryResolutionEntity,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ActivePlansTableTableManager get activePlans =>
      $$ActivePlansTableTableManager(_db, _db.activePlans);
  $$DayAssignmentsTableTableManager get dayAssignments =>
      $$DayAssignmentsTableTableManager(_db, _db.dayAssignments);
  $$SessionLogsTableTableManager get sessionLogs =>
      $$SessionLogsTableTableManager(_db, _db.sessionLogs);
  $$QuranSegmentProgressesTableTableManager get quranSegmentProgresses =>
      $$QuranSegmentProgressesTableTableManager(
          _db, _db.quranSegmentProgresses);
  $$PreviousMemorizedRangesTableTableManager get previousMemorizedRanges =>
      $$PreviousMemorizedRangesTableTableManager(
          _db, _db.previousMemorizedRanges);
  $$TodayAdjustmentsTableTableManager get todayAdjustments =>
      $$TodayAdjustmentsTableTableManager(_db, _db.todayAdjustments);
  $$RecoveryResolutionsTableTableManager get recoveryResolutions =>
      $$RecoveryResolutionsTableTableManager(_db, _db.recoveryResolutions);
}
