// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_save.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGameSaveCollection on Isar {
  IsarCollection<GameSave> get gameSaves => this.collection();
}

const GameSaveSchema = CollectionSchema(
  name: r'GameSave',
  id: -2957817159186665000,
  properties: {
    r'boardObjectiveLabel': PropertySchema(
      id: 0,
      name: r'boardObjectiveLabel',
      type: IsarType.string,
    ),
    r'boardObjectiveMaxPosition': PropertySchema(
      id: 1,
      name: r'boardObjectiveMaxPosition',
      type: IsarType.long,
    ),
    r'consecutiveRedWeeks': PropertySchema(
      id: 2,
      name: r'consecutiveRedWeeks',
      type: IsarType.long,
    ),
    r'cupRound': PropertySchema(
      id: 3,
      name: r'cupRound',
      type: IsarType.long,
    ),
    r'currentDay': PropertySchema(
      id: 4,
      name: r'currentDay',
      type: IsarType.long,
    ),
    r'currentMatchday': PropertySchema(
      id: 5,
      name: r'currentMatchday',
      type: IsarType.long,
    ),
    r'financiallyDismissed': PropertySchema(
      id: 6,
      name: r'financiallyDismissed',
      type: IsarType.bool,
    ),
    r'inCup': PropertySchema(
      id: 7,
      name: r'inCup',
      type: IsarType.bool,
    ),
    r'internationalScoutsUsed': PropertySchema(
      id: 8,
      name: r'internationalScoutsUsed',
      type: IsarType.long,
    ),
    r'matchMode': PropertySchema(
      id: 9,
      name: r'matchMode',
      type: IsarType.string,
    ),
    r'seasonFinished': PropertySchema(
      id: 10,
      name: r'seasonFinished',
      type: IsarType.bool,
    ),
    r'seasonNumber': PropertySchema(
      id: 11,
      name: r'seasonNumber',
      type: IsarType.long,
    ),
    r'staffMedicoLevel': PropertySchema(
      id: 12,
      name: r'staffMedicoLevel',
      type: IsarType.long,
    ),
    r'staffMedicoName': PropertySchema(
      id: 13,
      name: r'staffMedicoName',
      type: IsarType.string,
    ),
    r'staffPreparatorLevel': PropertySchema(
      id: 14,
      name: r'staffPreparatorLevel',
      type: IsarType.long,
    ),
    r'staffPreparatorName': PropertySchema(
      id: 15,
      name: r'staffPreparatorName',
      type: IsarType.string,
    ),
    r'staffSecretaryLevel': PropertySchema(
      id: 16,
      name: r'staffSecretaryLevel',
      type: IsarType.long,
    ),
    r'staffSecretaryName': PropertySchema(
      id: 17,
      name: r'staffSecretaryName',
      type: IsarType.string,
    ),
    r'totalMatchdays': PropertySchema(
      id: 18,
      name: r'totalMatchdays',
      type: IsarType.long,
    ),
    r'trophies': PropertySchema(
      id: 19,
      name: r'trophies',
      type: IsarType.stringList,
    ),
    r'userTeamApiId': PropertySchema(
      id: 20,
      name: r'userTeamApiId',
      type: IsarType.long,
    )
  },
  estimateSize: _gameSaveEstimateSize,
  serialize: _gameSaveSerialize,
  deserialize: _gameSaveDeserialize,
  deserializeProp: _gameSaveDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _gameSaveGetId,
  getLinks: _gameSaveGetLinks,
  attach: _gameSaveAttach,
  version: '3.1.0+1',
);

int _gameSaveEstimateSize(
  GameSave object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.boardObjectiveLabel.length * 3;
  bytesCount += 3 + object.matchMode.length * 3;
  bytesCount += 3 + object.staffMedicoName.length * 3;
  bytesCount += 3 + object.staffPreparatorName.length * 3;
  bytesCount += 3 + object.staffSecretaryName.length * 3;
  bytesCount += 3 + object.trophies.length * 3;
  {
    for (var i = 0; i < object.trophies.length; i++) {
      final value = object.trophies[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _gameSaveSerialize(
  GameSave object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.boardObjectiveLabel);
  writer.writeLong(offsets[1], object.boardObjectiveMaxPosition);
  writer.writeLong(offsets[2], object.consecutiveRedWeeks);
  writer.writeLong(offsets[3], object.cupRound);
  writer.writeLong(offsets[4], object.currentDay);
  writer.writeLong(offsets[5], object.currentMatchday);
  writer.writeBool(offsets[6], object.financiallyDismissed);
  writer.writeBool(offsets[7], object.inCup);
  writer.writeLong(offsets[8], object.internationalScoutsUsed);
  writer.writeString(offsets[9], object.matchMode);
  writer.writeBool(offsets[10], object.seasonFinished);
  writer.writeLong(offsets[11], object.seasonNumber);
  writer.writeLong(offsets[12], object.staffMedicoLevel);
  writer.writeString(offsets[13], object.staffMedicoName);
  writer.writeLong(offsets[14], object.staffPreparatorLevel);
  writer.writeString(offsets[15], object.staffPreparatorName);
  writer.writeLong(offsets[16], object.staffSecretaryLevel);
  writer.writeString(offsets[17], object.staffSecretaryName);
  writer.writeLong(offsets[18], object.totalMatchdays);
  writer.writeStringList(offsets[19], object.trophies);
  writer.writeLong(offsets[20], object.userTeamApiId);
}

GameSave _gameSaveDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GameSave();
  object.boardObjectiveLabel = reader.readString(offsets[0]);
  object.boardObjectiveMaxPosition = reader.readLong(offsets[1]);
  object.consecutiveRedWeeks = reader.readLong(offsets[2]);
  object.cupRound = reader.readLong(offsets[3]);
  object.currentDay = reader.readLong(offsets[4]);
  object.currentMatchday = reader.readLong(offsets[5]);
  object.financiallyDismissed = reader.readBool(offsets[6]);
  object.id = id;
  object.inCup = reader.readBool(offsets[7]);
  object.internationalScoutsUsed = reader.readLong(offsets[8]);
  object.matchMode = reader.readString(offsets[9]);
  object.seasonFinished = reader.readBool(offsets[10]);
  object.seasonNumber = reader.readLong(offsets[11]);
  object.staffMedicoLevel = reader.readLong(offsets[12]);
  object.staffMedicoName = reader.readString(offsets[13]);
  object.staffPreparatorLevel = reader.readLong(offsets[14]);
  object.staffPreparatorName = reader.readString(offsets[15]);
  object.staffSecretaryLevel = reader.readLong(offsets[16]);
  object.staffSecretaryName = reader.readString(offsets[17]);
  object.totalMatchdays = reader.readLong(offsets[18]);
  object.trophies = reader.readStringList(offsets[19]) ?? [];
  object.userTeamApiId = reader.readLong(offsets[20]);
  return object;
}

P _gameSaveDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readStringList(offset) ?? []) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _gameSaveGetId(GameSave object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _gameSaveGetLinks(GameSave object) {
  return [];
}

void _gameSaveAttach(IsarCollection<dynamic> col, Id id, GameSave object) {
  object.id = id;
}

extension GameSaveQueryWhereSort on QueryBuilder<GameSave, GameSave, QWhere> {
  QueryBuilder<GameSave, GameSave, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GameSaveQueryWhere on QueryBuilder<GameSave, GameSave, QWhereClause> {
  QueryBuilder<GameSave, GameSave, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GameSaveQueryFilter
    on QueryBuilder<GameSave, GameSave, QFilterCondition> {
  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardObjectiveLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardObjectiveLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardObjectiveLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardObjectiveLabel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'boardObjectiveLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'boardObjectiveLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boardObjectiveLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boardObjectiveLabel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardObjectiveLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boardObjectiveLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveMaxPositionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardObjectiveMaxPosition',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveMaxPositionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardObjectiveMaxPosition',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveMaxPositionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardObjectiveMaxPosition',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardObjectiveMaxPositionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardObjectiveMaxPosition',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      consecutiveRedWeeksEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consecutiveRedWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      consecutiveRedWeeksGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consecutiveRedWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      consecutiveRedWeeksLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consecutiveRedWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      consecutiveRedWeeksBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consecutiveRedWeeks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> cupRoundEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cupRound',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> cupRoundGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cupRound',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> cupRoundLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cupRound',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> cupRoundBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cupRound',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> currentDayEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentDay',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> currentDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentDay',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> currentDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentDay',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> currentDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      currentMatchdayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      currentMatchdayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      currentMatchdayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      currentMatchdayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentMatchday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      financiallyDismissedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'financiallyDismissed',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> inCupEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inCup',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      internationalScoutsUsedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'internationalScoutsUsed',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      internationalScoutsUsedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'internationalScoutsUsed',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      internationalScoutsUsedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'internationalScoutsUsed',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      internationalScoutsUsedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'internationalScoutsUsed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> matchModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> matchModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> matchModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> matchModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> matchModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'matchMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> matchModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'matchMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> matchModeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'matchMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> matchModeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'matchMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> matchModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchMode',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      matchModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'matchMode',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> seasonFinishedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seasonFinished',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> seasonNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seasonNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      seasonNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seasonNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> seasonNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seasonNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> seasonNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seasonNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoLevelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffMedicoLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'staffMedicoLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'staffMedicoLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'staffMedicoLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffMedicoName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'staffMedicoName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'staffMedicoName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'staffMedicoName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'staffMedicoName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'staffMedicoName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'staffMedicoName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'staffMedicoName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffMedicoName',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffMedicoNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'staffMedicoName',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorLevelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffPreparatorLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'staffPreparatorLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'staffPreparatorLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'staffPreparatorLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffPreparatorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'staffPreparatorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'staffPreparatorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'staffPreparatorName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'staffPreparatorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'staffPreparatorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'staffPreparatorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'staffPreparatorName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffPreparatorName',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffPreparatorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'staffPreparatorName',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryLevelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffSecretaryLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'staffSecretaryLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'staffSecretaryLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'staffSecretaryLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffSecretaryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'staffSecretaryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'staffSecretaryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'staffSecretaryName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'staffSecretaryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'staffSecretaryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'staffSecretaryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'staffSecretaryName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'staffSecretaryName',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      staffSecretaryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'staffSecretaryName',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> totalMatchdaysEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalMatchdays',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      totalMatchdaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalMatchdays',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      totalMatchdaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalMatchdays',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> totalMatchdaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalMatchdays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trophies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trophies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trophies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trophies',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trophies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trophies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trophies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trophies',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trophies',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trophies',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> trophiesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trophies',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> trophiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trophies',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> trophiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trophies',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trophies',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trophiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trophies',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> trophiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trophies',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> userTeamApiIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      userTeamApiIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> userTeamApiIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> userTeamApiIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userTeamApiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GameSaveQueryObject
    on QueryBuilder<GameSave, GameSave, QFilterCondition> {}

extension GameSaveQueryLinks
    on QueryBuilder<GameSave, GameSave, QFilterCondition> {}

extension GameSaveQuerySortBy on QueryBuilder<GameSave, GameSave, QSortBy> {
  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByBoardObjectiveLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardObjectiveLabel', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByBoardObjectiveLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardObjectiveLabel', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByBoardObjectiveMaxPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardObjectiveMaxPosition', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByBoardObjectiveMaxPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardObjectiveMaxPosition', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByConsecutiveRedWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveRedWeeks', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByConsecutiveRedWeeksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveRedWeeks', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByCupRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cupRound', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByCupRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cupRound', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByCurrentDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDay', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByCurrentDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDay', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByCurrentMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMatchday', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByCurrentMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMatchday', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByFinanciallyDismissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financiallyDismissed', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByFinanciallyDismissedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financiallyDismissed', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByInCup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inCup', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByInCupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inCup', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByInternationalScoutsUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internationalScoutsUsed', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByInternationalScoutsUsedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internationalScoutsUsed', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByMatchMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchMode', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByMatchModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchMode', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortBySeasonFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonFinished', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortBySeasonFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonFinished', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortBySeasonNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonNumber', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortBySeasonNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonNumber', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByStaffMedicoLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffMedicoLevel', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByStaffMedicoLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffMedicoLevel', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByStaffMedicoName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffMedicoName', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByStaffMedicoNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffMedicoName', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByStaffPreparatorLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffPreparatorLevel', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByStaffPreparatorLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffPreparatorLevel', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByStaffPreparatorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffPreparatorName', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByStaffPreparatorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffPreparatorName', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByStaffSecretaryLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffSecretaryLevel', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByStaffSecretaryLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffSecretaryLevel', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByStaffSecretaryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffSecretaryName', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByStaffSecretaryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffSecretaryName', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByTotalMatchdays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMatchdays', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByTotalMatchdaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMatchdays', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByUserTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByUserTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userTeamApiId', Sort.desc);
    });
  }
}

extension GameSaveQuerySortThenBy
    on QueryBuilder<GameSave, GameSave, QSortThenBy> {
  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByBoardObjectiveLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardObjectiveLabel', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByBoardObjectiveLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardObjectiveLabel', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByBoardObjectiveMaxPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardObjectiveMaxPosition', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByBoardObjectiveMaxPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardObjectiveMaxPosition', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByConsecutiveRedWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveRedWeeks', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByConsecutiveRedWeeksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveRedWeeks', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByCupRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cupRound', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByCupRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cupRound', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByCurrentDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDay', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByCurrentDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDay', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByCurrentMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMatchday', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByCurrentMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentMatchday', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByFinanciallyDismissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financiallyDismissed', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByFinanciallyDismissedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financiallyDismissed', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByInCup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inCup', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByInCupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inCup', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByInternationalScoutsUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internationalScoutsUsed', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByInternationalScoutsUsedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internationalScoutsUsed', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByMatchMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchMode', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByMatchModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchMode', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenBySeasonFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonFinished', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenBySeasonFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonFinished', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenBySeasonNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonNumber', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenBySeasonNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seasonNumber', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByStaffMedicoLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffMedicoLevel', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByStaffMedicoLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffMedicoLevel', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByStaffMedicoName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffMedicoName', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByStaffMedicoNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffMedicoName', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByStaffPreparatorLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffPreparatorLevel', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByStaffPreparatorLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffPreparatorLevel', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByStaffPreparatorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffPreparatorName', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByStaffPreparatorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffPreparatorName', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByStaffSecretaryLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffSecretaryLevel', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByStaffSecretaryLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffSecretaryLevel', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByStaffSecretaryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffSecretaryName', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByStaffSecretaryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'staffSecretaryName', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByTotalMatchdays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMatchdays', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByTotalMatchdaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMatchdays', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByUserTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByUserTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userTeamApiId', Sort.desc);
    });
  }
}

extension GameSaveQueryWhereDistinct
    on QueryBuilder<GameSave, GameSave, QDistinct> {
  QueryBuilder<GameSave, GameSave, QDistinct> distinctByBoardObjectiveLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardObjectiveLabel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct>
      distinctByBoardObjectiveMaxPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardObjectiveMaxPosition');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByConsecutiveRedWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consecutiveRedWeeks');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByCupRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cupRound');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByCurrentDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentDay');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByCurrentMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentMatchday');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByFinanciallyDismissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'financiallyDismissed');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByInCup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inCup');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct>
      distinctByInternationalScoutsUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'internationalScoutsUsed');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByMatchMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctBySeasonFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seasonFinished');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctBySeasonNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seasonNumber');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByStaffMedicoLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'staffMedicoLevel');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByStaffMedicoName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'staffMedicoName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByStaffPreparatorLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'staffPreparatorLevel');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByStaffPreparatorName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'staffPreparatorName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByStaffSecretaryLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'staffSecretaryLevel');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByStaffSecretaryName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'staffSecretaryName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByTotalMatchdays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalMatchdays');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByTrophies() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trophies');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByUserTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userTeamApiId');
    });
  }
}

extension GameSaveQueryProperty
    on QueryBuilder<GameSave, GameSave, QQueryProperty> {
  QueryBuilder<GameSave, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GameSave, String, QQueryOperations>
      boardObjectiveLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardObjectiveLabel');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations>
      boardObjectiveMaxPositionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardObjectiveMaxPosition');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> consecutiveRedWeeksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consecutiveRedWeeks');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> cupRoundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cupRound');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> currentDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentDay');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> currentMatchdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentMatchday');
    });
  }

  QueryBuilder<GameSave, bool, QQueryOperations>
      financiallyDismissedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'financiallyDismissed');
    });
  }

  QueryBuilder<GameSave, bool, QQueryOperations> inCupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inCup');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations>
      internationalScoutsUsedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'internationalScoutsUsed');
    });
  }

  QueryBuilder<GameSave, String, QQueryOperations> matchModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchMode');
    });
  }

  QueryBuilder<GameSave, bool, QQueryOperations> seasonFinishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seasonFinished');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> seasonNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seasonNumber');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> staffMedicoLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'staffMedicoLevel');
    });
  }

  QueryBuilder<GameSave, String, QQueryOperations> staffMedicoNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'staffMedicoName');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> staffPreparatorLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'staffPreparatorLevel');
    });
  }

  QueryBuilder<GameSave, String, QQueryOperations>
      staffPreparatorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'staffPreparatorName');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> staffSecretaryLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'staffSecretaryLevel');
    });
  }

  QueryBuilder<GameSave, String, QQueryOperations>
      staffSecretaryNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'staffSecretaryName');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> totalMatchdaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalMatchdays');
    });
  }

  QueryBuilder<GameSave, List<String>, QQueryOperations> trophiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trophies');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> userTeamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userTeamApiId');
    });
  }
}
