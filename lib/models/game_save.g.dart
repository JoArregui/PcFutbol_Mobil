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
    r'boardAcceptance': PropertySchema(
      id: 0,
      name: r'boardAcceptance',
      type: IsarType.long,
    ),
    r'boardLastFeedback': PropertySchema(
      id: 1,
      name: r'boardLastFeedback',
      type: IsarType.string,
    ),
    r'boardObjectiveLabel': PropertySchema(
      id: 2,
      name: r'boardObjectiveLabel',
      type: IsarType.string,
    ),
    r'boardObjectiveMaxPosition': PropertySchema(
      id: 3,
      name: r'boardObjectiveMaxPosition',
      type: IsarType.long,
    ),
    r'boardRequirements': PropertySchema(
      id: 4,
      name: r'boardRequirements',
      type: IsarType.objectList,
      target: r'BoardRequirement',
    ),
    r'cleanSheets': PropertySchema(
      id: 5,
      name: r'cleanSheets',
      type: IsarType.long,
    ),
    r'consecutiveRedWeeks': PropertySchema(
      id: 6,
      name: r'consecutiveRedWeeks',
      type: IsarType.long,
    ),
    r'cupRound': PropertySchema(
      id: 7,
      name: r'cupRound',
      type: IsarType.long,
    ),
    r'currentDay': PropertySchema(
      id: 8,
      name: r'currentDay',
      type: IsarType.long,
    ),
    r'currentMatchday': PropertySchema(
      id: 9,
      name: r'currentMatchday',
      type: IsarType.long,
    ),
    r'defaultFormation': PropertySchema(
      id: 10,
      name: r'defaultFormation',
      type: IsarType.string,
    ),
    r'derbiesWon': PropertySchema(
      id: 11,
      name: r'derbiesWon',
      type: IsarType.long,
    ),
    r'fanFavoritePlayerId': PropertySchema(
      id: 12,
      name: r'fanFavoritePlayerId',
      type: IsarType.string,
    ),
    r'financiallyDismissed': PropertySchema(
      id: 13,
      name: r'financiallyDismissed',
      type: IsarType.bool,
    ),
    r'inCup': PropertySchema(
      id: 14,
      name: r'inCup',
      type: IsarType.bool,
    ),
    r'internationalScoutsUsed': PropertySchema(
      id: 15,
      name: r'internationalScoutsUsed',
      type: IsarType.long,
    ),
    r'lastFanSurvey': PropertySchema(
      id: 16,
      name: r'lastFanSurvey',
      type: IsarType.object,
      target: r'FanSurvey',
    ),
    r'lastSurveyDate': PropertySchema(
      id: 17,
      name: r'lastSurveyDate',
      type: IsarType.dateTime,
    ),
    r'lineupGeneratedPlayers': PropertySchema(
      id: 18,
      name: r'lineupGeneratedPlayers',
      type: IsarType.long,
    ),
    r'lineupTotalPlayers': PropertySchema(
      id: 19,
      name: r'lineupTotalPlayers',
      type: IsarType.long,
    ),
    r'matchMode': PropertySchema(
      id: 20,
      name: r'matchMode',
      type: IsarType.string,
    ),
    r'phasePlans': PropertySchema(
      id: 21,
      name: r'phasePlans',
      type: IsarType.stringList,
    ),
    r'seasonFinished': PropertySchema(
      id: 22,
      name: r'seasonFinished',
      type: IsarType.bool,
    ),
    r'seasonNumber': PropertySchema(
      id: 23,
      name: r'seasonNumber',
      type: IsarType.long,
    ),
    r'staffMedicoLevel': PropertySchema(
      id: 24,
      name: r'staffMedicoLevel',
      type: IsarType.long,
    ),
    r'staffMedicoName': PropertySchema(
      id: 25,
      name: r'staffMedicoName',
      type: IsarType.string,
    ),
    r'staffPreparatorLevel': PropertySchema(
      id: 26,
      name: r'staffPreparatorLevel',
      type: IsarType.long,
    ),
    r'staffPreparatorName': PropertySchema(
      id: 27,
      name: r'staffPreparatorName',
      type: IsarType.string,
    ),
    r'staffSecretaryLevel': PropertySchema(
      id: 28,
      name: r'staffSecretaryLevel',
      type: IsarType.long,
    ),
    r'staffSecretaryName': PropertySchema(
      id: 29,
      name: r'staffSecretaryName',
      type: IsarType.string,
    ),
    r'teamIntensity': PropertySchema(
      id: 30,
      name: r'teamIntensity',
      type: IsarType.string,
      enumMap: _GameSaveteamIntensityEnumValueMap,
    ),
    r'teamMentality': PropertySchema(
      id: 31,
      name: r'teamMentality',
      type: IsarType.string,
      enumMap: _GameSaveteamMentalityEnumValueMap,
    ),
    r'teamStyle': PropertySchema(
      id: 32,
      name: r'teamStyle',
      type: IsarType.string,
      enumMap: _GameSaveteamStyleEnumValueMap,
    ),
    r'totalMatchdays': PropertySchema(
      id: 33,
      name: r'totalMatchdays',
      type: IsarType.long,
    ),
    r'trainingFocusesUsedToday': PropertySchema(
      id: 34,
      name: r'trainingFocusesUsedToday',
      type: IsarType.stringList,
    ),
    r'trophies': PropertySchema(
      id: 35,
      name: r'trophies',
      type: IsarType.stringList,
    ),
    r'useAutomaticPhaseAdjustments': PropertySchema(
      id: 36,
      name: r'useAutomaticPhaseAdjustments',
      type: IsarType.bool,
    ),
    r'userTeamApiId': PropertySchema(
      id: 37,
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
  embeddedSchemas: {
    r'BoardRequirement': BoardRequirementSchema,
    r'FanSurvey': FanSurveySchema
  },
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
  bytesCount += 3 + object.boardLastFeedback.length * 3;
  bytesCount += 3 + object.boardObjectiveLabel.length * 3;
  bytesCount += 3 + object.boardRequirements.length * 3;
  {
    final offsets = allOffsets[BoardRequirement]!;
    for (var i = 0; i < object.boardRequirements.length; i++) {
      final value = object.boardRequirements[i];
      bytesCount +=
          BoardRequirementSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.defaultFormation.length * 3;
  {
    final value = object.fanFavoritePlayerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastFanSurvey;
    if (value != null) {
      bytesCount += 3 +
          FanSurveySchema.estimateSize(
              value, allOffsets[FanSurvey]!, allOffsets);
    }
  }
  bytesCount += 3 + object.matchMode.length * 3;
  bytesCount += 3 + object.phasePlans.length * 3;
  {
    for (var i = 0; i < object.phasePlans.length; i++) {
      final value = object.phasePlans[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.staffMedicoName.length * 3;
  bytesCount += 3 + object.staffPreparatorName.length * 3;
  bytesCount += 3 + object.staffSecretaryName.length * 3;
  bytesCount += 3 + object.teamIntensity.name.length * 3;
  bytesCount += 3 + object.teamMentality.name.length * 3;
  bytesCount += 3 + object.teamStyle.name.length * 3;
  bytesCount += 3 + object.trainingFocusesUsedToday.length * 3;
  {
    for (var i = 0; i < object.trainingFocusesUsedToday.length; i++) {
      final value = object.trainingFocusesUsedToday[i];
      bytesCount += value.length * 3;
    }
  }
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
  writer.writeLong(offsets[0], object.boardAcceptance);
  writer.writeString(offsets[1], object.boardLastFeedback);
  writer.writeString(offsets[2], object.boardObjectiveLabel);
  writer.writeLong(offsets[3], object.boardObjectiveMaxPosition);
  writer.writeObjectList<BoardRequirement>(
    offsets[4],
    allOffsets,
    BoardRequirementSchema.serialize,
    object.boardRequirements,
  );
  writer.writeLong(offsets[5], object.cleanSheets);
  writer.writeLong(offsets[6], object.consecutiveRedWeeks);
  writer.writeLong(offsets[7], object.cupRound);
  writer.writeLong(offsets[8], object.currentDay);
  writer.writeLong(offsets[9], object.currentMatchday);
  writer.writeString(offsets[10], object.defaultFormation);
  writer.writeLong(offsets[11], object.derbiesWon);
  writer.writeString(offsets[12], object.fanFavoritePlayerId);
  writer.writeBool(offsets[13], object.financiallyDismissed);
  writer.writeBool(offsets[14], object.inCup);
  writer.writeLong(offsets[15], object.internationalScoutsUsed);
  writer.writeObject<FanSurvey>(
    offsets[16],
    allOffsets,
    FanSurveySchema.serialize,
    object.lastFanSurvey,
  );
  writer.writeDateTime(offsets[17], object.lastSurveyDate);
  writer.writeLong(offsets[18], object.lineupGeneratedPlayers);
  writer.writeLong(offsets[19], object.lineupTotalPlayers);
  writer.writeString(offsets[20], object.matchMode);
  writer.writeStringList(offsets[21], object.phasePlans);
  writer.writeBool(offsets[22], object.seasonFinished);
  writer.writeLong(offsets[23], object.seasonNumber);
  writer.writeLong(offsets[24], object.staffMedicoLevel);
  writer.writeString(offsets[25], object.staffMedicoName);
  writer.writeLong(offsets[26], object.staffPreparatorLevel);
  writer.writeString(offsets[27], object.staffPreparatorName);
  writer.writeLong(offsets[28], object.staffSecretaryLevel);
  writer.writeString(offsets[29], object.staffSecretaryName);
  writer.writeString(offsets[30], object.teamIntensity.name);
  writer.writeString(offsets[31], object.teamMentality.name);
  writer.writeString(offsets[32], object.teamStyle.name);
  writer.writeLong(offsets[33], object.totalMatchdays);
  writer.writeStringList(offsets[34], object.trainingFocusesUsedToday);
  writer.writeStringList(offsets[35], object.trophies);
  writer.writeBool(offsets[36], object.useAutomaticPhaseAdjustments);
  writer.writeLong(offsets[37], object.userTeamApiId);
}

GameSave _gameSaveDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GameSave();
  object.boardAcceptance = reader.readLong(offsets[0]);
  object.boardLastFeedback = reader.readString(offsets[1]);
  object.boardObjectiveLabel = reader.readString(offsets[2]);
  object.boardObjectiveMaxPosition = reader.readLong(offsets[3]);
  object.boardRequirements = reader.readObjectList<BoardRequirement>(
        offsets[4],
        BoardRequirementSchema.deserialize,
        allOffsets,
        BoardRequirement(),
      ) ??
      [];
  object.cleanSheets = reader.readLong(offsets[5]);
  object.consecutiveRedWeeks = reader.readLong(offsets[6]);
  object.cupRound = reader.readLong(offsets[7]);
  object.currentDay = reader.readLong(offsets[8]);
  object.currentMatchday = reader.readLong(offsets[9]);
  object.defaultFormation = reader.readString(offsets[10]);
  object.derbiesWon = reader.readLong(offsets[11]);
  object.fanFavoritePlayerId = reader.readStringOrNull(offsets[12]);
  object.financiallyDismissed = reader.readBool(offsets[13]);
  object.id = id;
  object.inCup = reader.readBool(offsets[14]);
  object.internationalScoutsUsed = reader.readLong(offsets[15]);
  object.lastFanSurvey = reader.readObjectOrNull<FanSurvey>(
    offsets[16],
    FanSurveySchema.deserialize,
    allOffsets,
  );
  object.lastSurveyDate = reader.readDateTimeOrNull(offsets[17]);
  object.lineupGeneratedPlayers = reader.readLong(offsets[18]);
  object.lineupTotalPlayers = reader.readLong(offsets[19]);
  object.matchMode = reader.readString(offsets[20]);
  object.phasePlans = reader.readStringList(offsets[21]) ?? [];
  object.seasonFinished = reader.readBool(offsets[22]);
  object.seasonNumber = reader.readLong(offsets[23]);
  object.staffMedicoLevel = reader.readLong(offsets[24]);
  object.staffMedicoName = reader.readString(offsets[25]);
  object.staffPreparatorLevel = reader.readLong(offsets[26]);
  object.staffPreparatorName = reader.readString(offsets[27]);
  object.staffSecretaryLevel = reader.readLong(offsets[28]);
  object.staffSecretaryName = reader.readString(offsets[29]);
  object.teamIntensity = _GameSaveteamIntensityValueEnumMap[
          reader.readStringOrNull(offsets[30])] ??
      TeamIntensity.low;
  object.teamMentality = _GameSaveteamMentalityValueEnumMap[
          reader.readStringOrNull(offsets[31])] ??
      TeamMentality.veryDefensive;
  object.teamStyle =
      _GameSaveteamStyleValueEnumMap[reader.readStringOrNull(offsets[32])] ??
          TeamStyle.possession;
  object.totalMatchdays = reader.readLong(offsets[33]);
  object.trainingFocusesUsedToday = reader.readStringList(offsets[34]) ?? [];
  object.trophies = reader.readStringList(offsets[35]) ?? [];
  object.useAutomaticPhaseAdjustments = reader.readBool(offsets[36]);
  object.userTeamApiId = reader.readLong(offsets[37]);
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
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readObjectList<BoardRequirement>(
            offset,
            BoardRequirementSchema.deserialize,
            allOffsets,
            BoardRequirement(),
          ) ??
          []) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readObjectOrNull<FanSurvey>(
        offset,
        FanSurveySchema.deserialize,
        allOffsets,
      )) as P;
    case 17:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readLong(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readStringList(offset) ?? []) as P;
    case 22:
      return (reader.readBool(offset)) as P;
    case 23:
      return (reader.readLong(offset)) as P;
    case 24:
      return (reader.readLong(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readLong(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readLong(offset)) as P;
    case 29:
      return (reader.readString(offset)) as P;
    case 30:
      return (_GameSaveteamIntensityValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TeamIntensity.low) as P;
    case 31:
      return (_GameSaveteamMentalityValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TeamMentality.veryDefensive) as P;
    case 32:
      return (_GameSaveteamStyleValueEnumMap[reader.readStringOrNull(offset)] ??
          TeamStyle.possession) as P;
    case 33:
      return (reader.readLong(offset)) as P;
    case 34:
      return (reader.readStringList(offset) ?? []) as P;
    case 35:
      return (reader.readStringList(offset) ?? []) as P;
    case 36:
      return (reader.readBool(offset)) as P;
    case 37:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _GameSaveteamIntensityEnumValueMap = {
  r'low': r'low',
  r'normal': r'normal',
  r'high': r'high',
  r'veryHigh': r'veryHigh',
};
const _GameSaveteamIntensityValueEnumMap = {
  r'low': TeamIntensity.low,
  r'normal': TeamIntensity.normal,
  r'high': TeamIntensity.high,
  r'veryHigh': TeamIntensity.veryHigh,
};
const _GameSaveteamMentalityEnumValueMap = {
  r'veryDefensive': r'veryDefensive',
  r'defensive': r'defensive',
  r'balanced': r'balanced',
  r'attacking': r'attacking',
  r'veryAttacking': r'veryAttacking',
};
const _GameSaveteamMentalityValueEnumMap = {
  r'veryDefensive': TeamMentality.veryDefensive,
  r'defensive': TeamMentality.defensive,
  r'balanced': TeamMentality.balanced,
  r'attacking': TeamMentality.attacking,
  r'veryAttacking': TeamMentality.veryAttacking,
};
const _GameSaveteamStyleEnumValueMap = {
  r'possession': r'possession',
  r'direct': r'direct',
  r'counterAttack': r'counterAttack',
  r'longBall': r'longBall',
};
const _GameSaveteamStyleValueEnumMap = {
  r'possession': TeamStyle.possession,
  r'direct': TeamStyle.direct,
  r'counterAttack': TeamStyle.counterAttack,
  r'longBall': TeamStyle.longBall,
};

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
      boardAcceptanceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardAcceptance',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardAcceptanceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardAcceptance',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardAcceptanceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardAcceptance',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardAcceptanceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardAcceptance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardLastFeedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boardLastFeedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boardLastFeedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boardLastFeedback',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'boardLastFeedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'boardLastFeedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'boardLastFeedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'boardLastFeedback',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boardLastFeedback',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardLastFeedbackIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'boardLastFeedback',
        value: '',
      ));
    });
  }

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
      boardRequirementsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardRequirements',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardRequirementsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardRequirements',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardRequirementsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardRequirements',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardRequirementsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardRequirements',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardRequirementsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardRequirements',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardRequirementsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boardRequirements',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> cleanSheetsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cleanSheets',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      cleanSheetsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cleanSheets',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> cleanSheetsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cleanSheets',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> cleanSheetsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cleanSheets',
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
      defaultFormationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      defaultFormationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      defaultFormationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      defaultFormationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultFormation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      defaultFormationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      defaultFormationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      defaultFormationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultFormation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      defaultFormationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultFormation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      defaultFormationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultFormation',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      defaultFormationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultFormation',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> derbiesWonEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'derbiesWon',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> derbiesWonGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'derbiesWon',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> derbiesWonLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'derbiesWon',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> derbiesWonBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'derbiesWon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fanFavoritePlayerId',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fanFavoritePlayerId',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fanFavoritePlayerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fanFavoritePlayerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fanFavoritePlayerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fanFavoritePlayerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fanFavoritePlayerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fanFavoritePlayerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fanFavoritePlayerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fanFavoritePlayerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fanFavoritePlayerId',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      fanFavoritePlayerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fanFavoritePlayerId',
        value: '',
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

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lastFanSurveyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastFanSurvey',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lastFanSurveyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastFanSurvey',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lastSurveyDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSurveyDate',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lastSurveyDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSurveyDate',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> lastSurveyDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSurveyDate',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lastSurveyDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSurveyDate',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lastSurveyDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSurveyDate',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> lastSurveyDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSurveyDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lineupGeneratedPlayersEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineupGeneratedPlayers',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lineupGeneratedPlayersGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineupGeneratedPlayers',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lineupGeneratedPlayersLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineupGeneratedPlayers',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lineupGeneratedPlayersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineupGeneratedPlayers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lineupTotalPlayersEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineupTotalPlayers',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lineupTotalPlayersGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineupTotalPlayers',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lineupTotalPlayersLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineupTotalPlayers',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      lineupTotalPlayersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineupTotalPlayers',
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

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phasePlans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phasePlans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phasePlans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phasePlans',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phasePlans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phasePlans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phasePlans',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phasePlans',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phasePlans',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phasePlans',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phasePlans',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> phasePlansIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phasePlans',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phasePlans',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phasePlans',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phasePlans',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      phasePlansLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'phasePlans',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
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

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamIntensityEqualTo(
    TeamIntensity value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      teamIntensityGreaterThan(
    TeamIntensity value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teamIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamIntensityLessThan(
    TeamIntensity value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teamIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamIntensityBetween(
    TeamIntensity lower,
    TeamIntensity upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teamIntensity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      teamIntensityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teamIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamIntensityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teamIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamIntensityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teamIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamIntensityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teamIntensity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      teamIntensityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamIntensity',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      teamIntensityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teamIntensity',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamMentalityEqualTo(
    TeamMentality value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamMentality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      teamMentalityGreaterThan(
    TeamMentality value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teamMentality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamMentalityLessThan(
    TeamMentality value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teamMentality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamMentalityBetween(
    TeamMentality lower,
    TeamMentality upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teamMentality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      teamMentalityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teamMentality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamMentalityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teamMentality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamMentalityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teamMentality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamMentalityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teamMentality',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      teamMentalityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamMentality',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      teamMentalityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teamMentality',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamStyleEqualTo(
    TeamStyle value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamStyleGreaterThan(
    TeamStyle value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teamStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamStyleLessThan(
    TeamStyle value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teamStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamStyleBetween(
    TeamStyle lower,
    TeamStyle upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teamStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teamStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teamStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamStyleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teamStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamStyleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teamStyle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> teamStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      teamStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teamStyle',
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
      trainingFocusesUsedTodayElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trainingFocusesUsedToday',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trainingFocusesUsedToday',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trainingFocusesUsedToday',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trainingFocusesUsedToday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trainingFocusesUsedToday',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trainingFocusesUsedToday',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trainingFocusesUsedToday',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trainingFocusesUsedToday',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trainingFocusesUsedToday',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trainingFocusesUsedToday',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trainingFocusesUsedToday',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trainingFocusesUsedToday',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trainingFocusesUsedToday',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trainingFocusesUsedToday',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trainingFocusesUsedToday',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      trainingFocusesUsedTodayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'trainingFocusesUsedToday',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
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

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      useAutomaticPhaseAdjustmentsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'useAutomaticPhaseAdjustments',
        value: value,
      ));
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
    on QueryBuilder<GameSave, GameSave, QFilterCondition> {
  QueryBuilder<GameSave, GameSave, QAfterFilterCondition>
      boardRequirementsElement(FilterQuery<BoardRequirement> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'boardRequirements');
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterFilterCondition> lastFanSurvey(
      FilterQuery<FanSurvey> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lastFanSurvey');
    });
  }
}

extension GameSaveQueryLinks
    on QueryBuilder<GameSave, GameSave, QFilterCondition> {}

extension GameSaveQuerySortBy on QueryBuilder<GameSave, GameSave, QSortBy> {
  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByBoardAcceptance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardAcceptance', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByBoardAcceptanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardAcceptance', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByBoardLastFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardLastFeedback', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByBoardLastFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardLastFeedback', Sort.desc);
    });
  }

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

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByCleanSheets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanSheets', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByCleanSheetsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanSheets', Sort.desc);
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

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByDefaultFormation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultFormation', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByDefaultFormationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultFormation', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByDerbiesWon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'derbiesWon', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByDerbiesWonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'derbiesWon', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByFanFavoritePlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fanFavoritePlayerId', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByFanFavoritePlayerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fanFavoritePlayerId', Sort.desc);
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

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByLastSurveyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSurveyDate', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByLastSurveyDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSurveyDate', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByLineupGeneratedPlayers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineupGeneratedPlayers', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByLineupGeneratedPlayersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineupGeneratedPlayers', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByLineupTotalPlayers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineupTotalPlayers', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByLineupTotalPlayersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineupTotalPlayers', Sort.desc);
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

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByTeamIntensity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamIntensity', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByTeamIntensityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamIntensity', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByTeamMentality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamMentality', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByTeamMentalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamMentality', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByTeamStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamStyle', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> sortByTeamStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamStyle', Sort.desc);
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

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByUseAutomaticPhaseAdjustments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useAutomaticPhaseAdjustments', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      sortByUseAutomaticPhaseAdjustmentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useAutomaticPhaseAdjustments', Sort.desc);
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
  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByBoardAcceptance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardAcceptance', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByBoardAcceptanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardAcceptance', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByBoardLastFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardLastFeedback', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByBoardLastFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boardLastFeedback', Sort.desc);
    });
  }

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

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByCleanSheets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanSheets', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByCleanSheetsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanSheets', Sort.desc);
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

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByDefaultFormation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultFormation', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByDefaultFormationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultFormation', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByDerbiesWon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'derbiesWon', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByDerbiesWonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'derbiesWon', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByFanFavoritePlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fanFavoritePlayerId', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByFanFavoritePlayerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fanFavoritePlayerId', Sort.desc);
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

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByLastSurveyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSurveyDate', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByLastSurveyDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSurveyDate', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByLineupGeneratedPlayers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineupGeneratedPlayers', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByLineupGeneratedPlayersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineupGeneratedPlayers', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByLineupTotalPlayers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineupTotalPlayers', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByLineupTotalPlayersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineupTotalPlayers', Sort.desc);
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

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByTeamIntensity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamIntensity', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByTeamIntensityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamIntensity', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByTeamMentality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamMentality', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByTeamMentalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamMentality', Sort.desc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByTeamStyle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamStyle', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy> thenByTeamStyleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamStyle', Sort.desc);
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

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByUseAutomaticPhaseAdjustments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useAutomaticPhaseAdjustments', Sort.asc);
    });
  }

  QueryBuilder<GameSave, GameSave, QAfterSortBy>
      thenByUseAutomaticPhaseAdjustmentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'useAutomaticPhaseAdjustments', Sort.desc);
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
  QueryBuilder<GameSave, GameSave, QDistinct> distinctByBoardAcceptance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardAcceptance');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByBoardLastFeedback(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boardLastFeedback',
          caseSensitive: caseSensitive);
    });
  }

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

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByCleanSheets() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cleanSheets');
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

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByDefaultFormation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultFormation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByDerbiesWon() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'derbiesWon');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByFanFavoritePlayerId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fanFavoritePlayerId',
          caseSensitive: caseSensitive);
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

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByLastSurveyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSurveyDate');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct>
      distinctByLineupGeneratedPlayers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineupGeneratedPlayers');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByLineupTotalPlayers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineupTotalPlayers');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByMatchMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByPhasePlans() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phasePlans');
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

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByTeamIntensity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamIntensity',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByTeamMentality(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamMentality',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByTeamStyle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamStyle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByTotalMatchdays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalMatchdays');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct>
      distinctByTrainingFocusesUsedToday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trainingFocusesUsedToday');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct> distinctByTrophies() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trophies');
    });
  }

  QueryBuilder<GameSave, GameSave, QDistinct>
      distinctByUseAutomaticPhaseAdjustments() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'useAutomaticPhaseAdjustments');
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

  QueryBuilder<GameSave, int, QQueryOperations> boardAcceptanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardAcceptance');
    });
  }

  QueryBuilder<GameSave, String, QQueryOperations> boardLastFeedbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardLastFeedback');
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

  QueryBuilder<GameSave, List<BoardRequirement>, QQueryOperations>
      boardRequirementsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boardRequirements');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> cleanSheetsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cleanSheets');
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

  QueryBuilder<GameSave, String, QQueryOperations> defaultFormationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultFormation');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> derbiesWonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'derbiesWon');
    });
  }

  QueryBuilder<GameSave, String?, QQueryOperations>
      fanFavoritePlayerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fanFavoritePlayerId');
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

  QueryBuilder<GameSave, FanSurvey?, QQueryOperations> lastFanSurveyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastFanSurvey');
    });
  }

  QueryBuilder<GameSave, DateTime?, QQueryOperations> lastSurveyDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSurveyDate');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations>
      lineupGeneratedPlayersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineupGeneratedPlayers');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> lineupTotalPlayersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineupTotalPlayers');
    });
  }

  QueryBuilder<GameSave, String, QQueryOperations> matchModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchMode');
    });
  }

  QueryBuilder<GameSave, List<String>, QQueryOperations> phasePlansProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phasePlans');
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

  QueryBuilder<GameSave, TeamIntensity, QQueryOperations>
      teamIntensityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamIntensity');
    });
  }

  QueryBuilder<GameSave, TeamMentality, QQueryOperations>
      teamMentalityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamMentality');
    });
  }

  QueryBuilder<GameSave, TeamStyle, QQueryOperations> teamStyleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamStyle');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> totalMatchdaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalMatchdays');
    });
  }

  QueryBuilder<GameSave, List<String>, QQueryOperations>
      trainingFocusesUsedTodayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trainingFocusesUsedToday');
    });
  }

  QueryBuilder<GameSave, List<String>, QQueryOperations> trophiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trophies');
    });
  }

  QueryBuilder<GameSave, bool, QQueryOperations>
      useAutomaticPhaseAdjustmentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'useAutomaticPhaseAdjustments');
    });
  }

  QueryBuilder<GameSave, int, QQueryOperations> userTeamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userTeamApiId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BoardRequirementSchema = Schema(
  name: r'BoardRequirement',
  id: -9026271418931187608,
  properties: {
    r'completed': PropertySchema(
      id: 0,
      name: r'completed',
      type: IsarType.bool,
    ),
    r'currentValue': PropertySchema(
      id: 1,
      name: r'currentValue',
      type: IsarType.long,
    ),
    r'deadline': PropertySchema(
      id: 2,
      name: r'deadline',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'playerId': PropertySchema(
      id: 4,
      name: r'playerId',
      type: IsarType.string,
    ),
    r'targetValue': PropertySchema(
      id: 5,
      name: r'targetValue',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 6,
      name: r'type',
      type: IsarType.string,
      enumMap: _BoardRequirementtypeEnumValueMap,
    )
  },
  estimateSize: _boardRequirementEstimateSize,
  serialize: _boardRequirementSerialize,
  deserialize: _boardRequirementDeserialize,
  deserializeProp: _boardRequirementDeserializeProp,
);

int _boardRequirementEstimateSize(
  BoardRequirement object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  {
    final value = object.playerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _boardRequirementSerialize(
  BoardRequirement object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.completed);
  writer.writeLong(offsets[1], object.currentValue);
  writer.writeDateTime(offsets[2], object.deadline);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.playerId);
  writer.writeLong(offsets[5], object.targetValue);
  writer.writeString(offsets[6], object.type.name);
}

BoardRequirement _boardRequirementDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BoardRequirement();
  object.completed = reader.readBool(offsets[0]);
  object.currentValue = reader.readLong(offsets[1]);
  object.deadline = reader.readDateTimeOrNull(offsets[2]);
  object.description = reader.readString(offsets[3]);
  object.playerId = reader.readStringOrNull(offsets[4]);
  object.targetValue = reader.readLong(offsets[5]);
  object.type =
      _BoardRequirementtypeValueEnumMap[reader.readStringOrNull(offsets[6])] ??
          BoardRequirementType.signPlayer;
  return object;
}

P _boardRequirementDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (_BoardRequirementtypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          BoardRequirementType.signPlayer) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BoardRequirementtypeEnumValueMap = {
  r'signPlayer': r'signPlayer',
  r'promoteYouth': r'promoteYouth',
  r'reachPosition': r'reachPosition',
  r'winDerby': r'winDerby',
  r'keepCleanSheets': r'keepCleanSheets',
  r'scoreGoals': r'scoreGoals',
  r'developPlayer': r'developPlayer',
};
const _BoardRequirementtypeValueEnumMap = {
  r'signPlayer': BoardRequirementType.signPlayer,
  r'promoteYouth': BoardRequirementType.promoteYouth,
  r'reachPosition': BoardRequirementType.reachPosition,
  r'winDerby': BoardRequirementType.winDerby,
  r'keepCleanSheets': BoardRequirementType.keepCleanSheets,
  r'scoreGoals': BoardRequirementType.scoreGoals,
  r'developPlayer': BoardRequirementType.developPlayer,
};

extension BoardRequirementQueryFilter
    on QueryBuilder<BoardRequirement, BoardRequirement, QFilterCondition> {
  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      completedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completed',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      currentValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentValue',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      currentValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentValue',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      currentValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentValue',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      currentValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      deadlineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      deadlineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      deadlineEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      deadlineGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      deadlineLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      deadlineBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deadline',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playerId',
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playerId',
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'playerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'playerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerId',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      playerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'playerId',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      targetValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetValue',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      targetValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetValue',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      targetValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetValue',
        value: value,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      targetValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeEqualTo(
    BoardRequirementType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeGreaterThan(
    BoardRequirementType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeLessThan(
    BoardRequirementType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeBetween(
    BoardRequirementType lower,
    BoardRequirementType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<BoardRequirement, BoardRequirement, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension BoardRequirementQueryObject
    on QueryBuilder<BoardRequirement, BoardRequirement, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FanSurveySchema = Schema(
  name: r'FanSurvey',
  id: 6911954931475367646,
  properties: {
    r'approvalRating': PropertySchema(
      id: 0,
      name: r'approvalRating',
      type: IsarType.long,
    ),
    r'favoritePlayer': PropertySchema(
      id: 1,
      name: r'favoritePlayer',
      type: IsarType.string,
    ),
    r'feedback': PropertySchema(
      id: 2,
      name: r'feedback',
      type: IsarType.string,
    ),
    r'mostCriticizedPlayer': PropertySchema(
      id: 3,
      name: r'mostCriticizedPlayer',
      type: IsarType.string,
    ),
    r'surveyDate': PropertySchema(
      id: 4,
      name: r'surveyDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _fanSurveyEstimateSize,
  serialize: _fanSurveySerialize,
  deserialize: _fanSurveyDeserialize,
  deserializeProp: _fanSurveyDeserializeProp,
);

int _fanSurveyEstimateSize(
  FanSurvey object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.favoritePlayer.length * 3;
  bytesCount += 3 + object.feedback.length * 3;
  bytesCount += 3 + object.mostCriticizedPlayer.length * 3;
  return bytesCount;
}

void _fanSurveySerialize(
  FanSurvey object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.approvalRating);
  writer.writeString(offsets[1], object.favoritePlayer);
  writer.writeString(offsets[2], object.feedback);
  writer.writeString(offsets[3], object.mostCriticizedPlayer);
  writer.writeDateTime(offsets[4], object.surveyDate);
}

FanSurvey _fanSurveyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FanSurvey();
  object.approvalRating = reader.readLong(offsets[0]);
  object.favoritePlayer = reader.readString(offsets[1]);
  object.feedback = reader.readString(offsets[2]);
  object.mostCriticizedPlayer = reader.readString(offsets[3]);
  object.surveyDate = reader.readDateTime(offsets[4]);
  return object;
}

P _fanSurveyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FanSurveyQueryFilter
    on QueryBuilder<FanSurvey, FanSurvey, QFilterCondition> {
  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      approvalRatingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approvalRating',
        value: value,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      approvalRatingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'approvalRating',
        value: value,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      approvalRatingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'approvalRating',
        value: value,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      approvalRatingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'approvalRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favoritePlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'favoritePlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'favoritePlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'favoritePlayer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'favoritePlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'favoritePlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'favoritePlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'favoritePlayer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'favoritePlayer',
        value: '',
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      favoritePlayerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'favoritePlayer',
        value: '',
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> feedbackEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> feedbackGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> feedbackLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> feedbackBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'feedback',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> feedbackStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> feedbackEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> feedbackContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'feedback',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> feedbackMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'feedback',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> feedbackIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedback',
        value: '',
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      feedbackIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'feedback',
        value: '',
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mostCriticizedPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mostCriticizedPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mostCriticizedPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mostCriticizedPlayer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mostCriticizedPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mostCriticizedPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mostCriticizedPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mostCriticizedPlayer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mostCriticizedPlayer',
        value: '',
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      mostCriticizedPlayerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mostCriticizedPlayer',
        value: '',
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> surveyDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surveyDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition>
      surveyDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surveyDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> surveyDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surveyDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FanSurvey, FanSurvey, QAfterFilterCondition> surveyDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surveyDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FanSurveyQueryObject
    on QueryBuilder<FanSurvey, FanSurvey, QFilterCondition> {}
