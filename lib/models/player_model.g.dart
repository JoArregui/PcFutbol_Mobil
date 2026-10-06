// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlayerCollection on Isar {
  IsarCollection<Player> get players => this.collection();
}

const PlayerSchema = CollectionSchema(
  name: r'Player',
  id: -1052842935974721688,
  properties: {
    r'age': PropertySchema(
      id: 0,
      name: r'age',
      type: IsarType.long,
    ),
    r'average': PropertySchema(
      id: 1,
      name: r'average',
      type: IsarType.double,
    ),
    r'buyoutClause': PropertySchema(
      id: 2,
      name: r'buyoutClause',
      type: IsarType.double,
    ),
    r'contractYearsRemaining': PropertySchema(
      id: 3,
      name: r'contractYearsRemaining',
      type: IsarType.long,
    ),
    r'injuredDays': PropertySchema(
      id: 4,
      name: r'injuredDays',
      type: IsarType.long,
    ),
    r'isGenerated': PropertySchema(
      id: 5,
      name: r'isGenerated',
      type: IsarType.bool,
    ),
    r'isUnicorn': PropertySchema(
      id: 6,
      name: r'isUnicorn',
      type: IsarType.bool,
    ),
    r'isYouth': PropertySchema(
      id: 7,
      name: r'isYouth',
      type: IsarType.bool,
    ),
    r'loanedOutToTeamApiId': PropertySchema(
      id: 8,
      name: r'loanedOutToTeamApiId',
      type: IsarType.long,
    ),
    r'loanedOutUntilMatchday': PropertySchema(
      id: 9,
      name: r'loanedOutUntilMatchday',
      type: IsarType.long,
    ),
    r'marketValue': PropertySchema(
      id: 10,
      name: r'marketValue',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'nationality': PropertySchema(
      id: 12,
      name: r'nationality',
      type: IsarType.string,
    ),
    r'onLoanFromTeamApiId': PropertySchema(
      id: 13,
      name: r'onLoanFromTeamApiId',
      type: IsarType.long,
    ),
    r'onLoanUntilMatchday': PropertySchema(
      id: 14,
      name: r'onLoanUntilMatchday',
      type: IsarType.long,
    ),
    r'personality': PropertySchema(
      id: 15,
      name: r'personality',
      type: IsarType.byte,
      enumMap: _PlayerpersonalityEnumValueMap,
    ),
    r'position': PropertySchema(
      id: 16,
      name: r'position',
      type: IsarType.string,
    ),
    r'potential': PropertySchema(
      id: 17,
      name: r'potential',
      type: IsarType.long,
    ),
    r'salary': PropertySchema(
      id: 18,
      name: r'salary',
      type: IsarType.double,
    ),
    r'stats': PropertySchema(
      id: 19,
      name: r'stats',
      type: IsarType.longList,
    ),
    r'suspendedMatches': PropertySchema(
      id: 20,
      name: r'suspendedMatches',
      type: IsarType.long,
    ),
    r'teamApiId': PropertySchema(
      id: 21,
      name: r'teamApiId',
      type: IsarType.long,
    ),
    r'teamId': PropertySchema(
      id: 22,
      name: r'teamId',
      type: IsarType.string,
    )
  },
  estimateSize: _playerEstimateSize,
  serialize: _playerSerialize,
  deserialize: _playerDeserialize,
  deserializeProp: _playerDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'teamId': IndexSchema(
      id: 8894498918133773550,
      name: r'teamId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'teamId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'teamApiId': IndexSchema(
      id: -6029187653010580359,
      name: r'teamApiId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'teamApiId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isYouth': IndexSchema(
      id: -895132139811771596,
      name: r'isYouth',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isYouth',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _playerGetId,
  getLinks: _playerGetLinks,
  attach: _playerAttach,
  version: '3.1.0+1',
);

int _playerEstimateSize(
  Player object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.nationality.length * 3;
  bytesCount += 3 + object.position.length * 3;
  bytesCount += 3 + object.stats.length * 8;
  bytesCount += 3 + object.teamId.length * 3;
  return bytesCount;
}

void _playerSerialize(
  Player object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.age);
  writer.writeDouble(offsets[1], object.average);
  writer.writeDouble(offsets[2], object.buyoutClause);
  writer.writeLong(offsets[3], object.contractYearsRemaining);
  writer.writeLong(offsets[4], object.injuredDays);
  writer.writeBool(offsets[5], object.isGenerated);
  writer.writeBool(offsets[6], object.isUnicorn);
  writer.writeBool(offsets[7], object.isYouth);
  writer.writeLong(offsets[8], object.loanedOutToTeamApiId);
  writer.writeLong(offsets[9], object.loanedOutUntilMatchday);
  writer.writeDouble(offsets[10], object.marketValue);
  writer.writeString(offsets[11], object.name);
  writer.writeString(offsets[12], object.nationality);
  writer.writeLong(offsets[13], object.onLoanFromTeamApiId);
  writer.writeLong(offsets[14], object.onLoanUntilMatchday);
  writer.writeByte(offsets[15], object.personality.index);
  writer.writeString(offsets[16], object.position);
  writer.writeLong(offsets[17], object.potential);
  writer.writeDouble(offsets[18], object.salary);
  writer.writeLongList(offsets[19], object.stats);
  writer.writeLong(offsets[20], object.suspendedMatches);
  writer.writeLong(offsets[21], object.teamApiId);
  writer.writeString(offsets[22], object.teamId);
}

Player _playerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Player();
  object.age = reader.readLong(offsets[0]);
  object.buyoutClause = reader.readDouble(offsets[2]);
  object.contractYearsRemaining = reader.readLong(offsets[3]);
  object.id = id;
  object.injuredDays = reader.readLong(offsets[4]);
  object.isGenerated = reader.readBool(offsets[5]);
  object.isUnicorn = reader.readBool(offsets[6]);
  object.isYouth = reader.readBool(offsets[7]);
  object.loanedOutToTeamApiId = reader.readLong(offsets[8]);
  object.loanedOutUntilMatchday = reader.readLong(offsets[9]);
  object.marketValue = reader.readDouble(offsets[10]);
  object.name = reader.readString(offsets[11]);
  object.nationality = reader.readString(offsets[12]);
  object.onLoanFromTeamApiId = reader.readLong(offsets[13]);
  object.onLoanUntilMatchday = reader.readLong(offsets[14]);
  object.personality =
      _PlayerpersonalityValueEnumMap[reader.readByteOrNull(offsets[15])] ??
          Personality.ambitious;
  object.position = reader.readString(offsets[16]);
  object.potential = reader.readLong(offsets[17]);
  object.salary = reader.readDouble(offsets[18]);
  object.stats = reader.readLongList(offsets[19]) ?? [];
  object.suspendedMatches = reader.readLong(offsets[20]);
  object.teamApiId = reader.readLongOrNull(offsets[21]);
  object.teamId = reader.readString(offsets[22]);
  return object;
}

P _playerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (_PlayerpersonalityValueEnumMap[reader.readByteOrNull(offset)] ??
          Personality.ambitious) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    case 18:
      return (reader.readDouble(offset)) as P;
    case 19:
      return (reader.readLongList(offset) ?? []) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    case 21:
      return (reader.readLongOrNull(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PlayerpersonalityEnumValueMap = {
  'ambitious': 0,
  'loyal': 1,
  'greedy': 2,
  'professional': 3,
};
const _PlayerpersonalityValueEnumMap = {
  0: Personality.ambitious,
  1: Personality.loyal,
  2: Personality.greedy,
  3: Personality.professional,
};

Id _playerGetId(Player object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _playerGetLinks(Player object) {
  return [];
}

void _playerAttach(IsarCollection<dynamic> col, Id id, Player object) {
  object.id = id;
}

extension PlayerQueryWhereSort on QueryBuilder<Player, Player, QWhere> {
  QueryBuilder<Player, Player, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Player, Player, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }

  QueryBuilder<Player, Player, QAfterWhere> anyTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'teamApiId'),
      );
    });
  }

  QueryBuilder<Player, Player, QAfterWhere> anyIsYouth() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isYouth'),
      );
    });
  }
}

extension PlayerQueryWhere on QueryBuilder<Player, Player, QWhereClause> {
  QueryBuilder<Player, Player, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Player, Player, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> idBetween(
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

  QueryBuilder<Player, Player, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> nameStartsWith(
      String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> teamIdEqualTo(String teamId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'teamId',
        value: [teamId],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> teamIdNotEqualTo(
      String teamId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamId',
              lower: [],
              upper: [teamId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamId',
              lower: [teamId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamId',
              lower: [teamId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamId',
              lower: [],
              upper: [teamId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> teamApiIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'teamApiId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> teamApiIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'teamApiId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> teamApiIdEqualTo(
      int? teamApiId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'teamApiId',
        value: [teamApiId],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> teamApiIdNotEqualTo(
      int? teamApiId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamApiId',
              lower: [],
              upper: [teamApiId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamApiId',
              lower: [teamApiId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamApiId',
              lower: [teamApiId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamApiId',
              lower: [],
              upper: [teamApiId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> teamApiIdGreaterThan(
    int? teamApiId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'teamApiId',
        lower: [teamApiId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> teamApiIdLessThan(
    int? teamApiId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'teamApiId',
        lower: [],
        upper: [teamApiId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> teamApiIdBetween(
    int? lowerTeamApiId,
    int? upperTeamApiId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'teamApiId',
        lower: [lowerTeamApiId],
        includeLower: includeLower,
        upper: [upperTeamApiId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> isYouthEqualTo(bool isYouth) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isYouth',
        value: [isYouth],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> isYouthNotEqualTo(
      bool isYouth) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isYouth',
              lower: [],
              upper: [isYouth],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isYouth',
              lower: [isYouth],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isYouth',
              lower: [isYouth],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isYouth',
              lower: [],
              upper: [isYouth],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PlayerQueryFilter on QueryBuilder<Player, Player, QFilterCondition> {
  QueryBuilder<Player, Player, QAfterFilterCondition> ageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'age',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> ageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'age',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> ageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'age',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> ageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'age',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> averageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'average',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> averageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'average',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> averageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'average',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> averageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'average',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> buyoutClauseEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buyoutClause',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> buyoutClauseGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'buyoutClause',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> buyoutClauseLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'buyoutClause',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> buyoutClauseBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'buyoutClause',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      contractYearsRemainingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contractYearsRemaining',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      contractYearsRemainingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contractYearsRemaining',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      contractYearsRemainingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contractYearsRemaining',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      contractYearsRemainingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contractYearsRemaining',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Player, Player, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Player, Player, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Player, Player, QAfterFilterCondition> injuredDaysEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'injuredDays',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> injuredDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'injuredDays',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> injuredDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'injuredDays',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> injuredDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'injuredDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> isGeneratedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGenerated',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> isUnicornEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUnicorn',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> isYouthEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isYouth',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      loanedOutToTeamApiIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loanedOutToTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      loanedOutToTeamApiIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loanedOutToTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      loanedOutToTeamApiIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loanedOutToTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      loanedOutToTeamApiIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loanedOutToTeamApiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      loanedOutUntilMatchdayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loanedOutUntilMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      loanedOutUntilMatchdayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loanedOutUntilMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      loanedOutUntilMatchdayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loanedOutUntilMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      loanedOutUntilMatchdayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loanedOutUntilMatchday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> marketValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'marketValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> marketValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'marketValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> marketValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'marketValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> marketValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'marketValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nationality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nationality',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nationality',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nationality',
        value: '',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nationalityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nationality',
        value: '',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      onLoanFromTeamApiIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onLoanFromTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      onLoanFromTeamApiIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'onLoanFromTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      onLoanFromTeamApiIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'onLoanFromTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      onLoanFromTeamApiIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'onLoanFromTeamApiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      onLoanUntilMatchdayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onLoanUntilMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      onLoanUntilMatchdayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'onLoanUntilMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      onLoanUntilMatchdayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'onLoanUntilMatchday',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      onLoanUntilMatchdayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'onLoanUntilMatchday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> personalityEqualTo(
      Personality value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personality',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> personalityGreaterThan(
    Personality value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'personality',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> personalityLessThan(
    Personality value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'personality',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> personalityBetween(
    Personality lower,
    Personality upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'personality',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'position',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'position',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: '',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> positionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'position',
        value: '',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> potentialEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'potential',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> potentialGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'potential',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> potentialLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'potential',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> potentialBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'potential',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> salaryEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salary',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> salaryGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'salary',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> salaryLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'salary',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> salaryBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'salary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stats',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stats',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stats',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stats',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stats',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stats',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stats',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stats',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stats',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> statsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stats',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> suspendedMatchesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'suspendedMatches',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition>
      suspendedMatchesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'suspendedMatches',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> suspendedMatchesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'suspendedMatches',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> suspendedMatchesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'suspendedMatches',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamApiIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teamApiId',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamApiIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teamApiId',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamApiIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamApiIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamApiIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamApiIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teamApiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teamId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teamId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teamId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teamId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teamId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teamId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teamId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamId',
        value: '',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> teamIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teamId',
        value: '',
      ));
    });
  }
}

extension PlayerQueryObject on QueryBuilder<Player, Player, QFilterCondition> {}

extension PlayerQueryLinks on QueryBuilder<Player, Player, QFilterCondition> {}

extension PlayerQuerySortBy on QueryBuilder<Player, Player, QSortBy> {
  QueryBuilder<Player, Player, QAfterSortBy> sortByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByAverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'average', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByAverageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'average', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByBuyoutClause() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buyoutClause', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByBuyoutClauseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buyoutClause', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByContractYearsRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractYearsRemaining', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy>
      sortByContractYearsRemainingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractYearsRemaining', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByInjuredDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injuredDays', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByInjuredDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injuredDays', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByIsGenerated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGenerated', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByIsGeneratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGenerated', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByIsUnicorn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnicorn', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByIsUnicornDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnicorn', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByIsYouth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isYouth', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByIsYouthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isYouth', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByLoanedOutToTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanedOutToTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByLoanedOutToTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanedOutToTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByLoanedOutUntilMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanedOutUntilMatchday', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy>
      sortByLoanedOutUntilMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanedOutUntilMatchday', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByMarketValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketValue', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByMarketValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketValue', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByNationality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nationality', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByNationalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nationality', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByOnLoanFromTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onLoanFromTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByOnLoanFromTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onLoanFromTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByOnLoanUntilMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onLoanUntilMatchday', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByOnLoanUntilMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onLoanUntilMatchday', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByPersonality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personality', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByPersonalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personality', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByPotential() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'potential', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByPotentialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'potential', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortBySalary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salary', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortBySalaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salary', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortBySuspendedMatches() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suspendedMatches', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortBySuspendedMatchesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suspendedMatches', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamApiId', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamApiId', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByTeamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamId', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByTeamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamId', Sort.desc);
    });
  }
}

extension PlayerQuerySortThenBy on QueryBuilder<Player, Player, QSortThenBy> {
  QueryBuilder<Player, Player, QAfterSortBy> thenByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'age', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByAverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'average', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByAverageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'average', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByBuyoutClause() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buyoutClause', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByBuyoutClauseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'buyoutClause', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByContractYearsRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractYearsRemaining', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy>
      thenByContractYearsRemainingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractYearsRemaining', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByInjuredDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injuredDays', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByInjuredDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injuredDays', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIsGenerated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGenerated', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIsGeneratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGenerated', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIsUnicorn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnicorn', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIsUnicornDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUnicorn', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIsYouth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isYouth', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIsYouthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isYouth', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByLoanedOutToTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanedOutToTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByLoanedOutToTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanedOutToTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByLoanedOutUntilMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanedOutUntilMatchday', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy>
      thenByLoanedOutUntilMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loanedOutUntilMatchday', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByMarketValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketValue', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByMarketValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketValue', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByNationality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nationality', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByNationalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nationality', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByOnLoanFromTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onLoanFromTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByOnLoanFromTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onLoanFromTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByOnLoanUntilMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onLoanUntilMatchday', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByOnLoanUntilMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onLoanUntilMatchday', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByPersonality() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personality', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByPersonalityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personality', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByPotential() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'potential', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByPotentialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'potential', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenBySalary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salary', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenBySalaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salary', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenBySuspendedMatches() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suspendedMatches', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenBySuspendedMatchesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'suspendedMatches', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamApiId', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamApiId', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByTeamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamId', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByTeamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamId', Sort.desc);
    });
  }
}

extension PlayerQueryWhereDistinct on QueryBuilder<Player, Player, QDistinct> {
  QueryBuilder<Player, Player, QDistinct> distinctByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'age');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByAverage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'average');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByBuyoutClause() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'buyoutClause');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByContractYearsRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contractYearsRemaining');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByInjuredDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'injuredDays');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByIsGenerated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGenerated');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByIsUnicorn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUnicorn');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByIsYouth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isYouth');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByLoanedOutToTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loanedOutToTeamApiId');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByLoanedOutUntilMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loanedOutUntilMatchday');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByMarketValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'marketValue');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByNationality(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nationality', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByOnLoanFromTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onLoanFromTeamApiId');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByOnLoanUntilMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onLoanUntilMatchday');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByPersonality() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personality');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByPosition(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'position', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByPotential() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'potential');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctBySalary() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'salary');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByStats() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stats');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctBySuspendedMatches() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'suspendedMatches');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamApiId');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByTeamId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamId', caseSensitive: caseSensitive);
    });
  }
}

extension PlayerQueryProperty on QueryBuilder<Player, Player, QQueryProperty> {
  QueryBuilder<Player, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> ageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'age');
    });
  }

  QueryBuilder<Player, double, QQueryOperations> averageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'average');
    });
  }

  QueryBuilder<Player, double, QQueryOperations> buyoutClauseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'buyoutClause');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> contractYearsRemainingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contractYearsRemaining');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> injuredDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'injuredDays');
    });
  }

  QueryBuilder<Player, bool, QQueryOperations> isGeneratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGenerated');
    });
  }

  QueryBuilder<Player, bool, QQueryOperations> isUnicornProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUnicorn');
    });
  }

  QueryBuilder<Player, bool, QQueryOperations> isYouthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isYouth');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> loanedOutToTeamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loanedOutToTeamApiId');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> loanedOutUntilMatchdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loanedOutUntilMatchday');
    });
  }

  QueryBuilder<Player, double, QQueryOperations> marketValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'marketValue');
    });
  }

  QueryBuilder<Player, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Player, String, QQueryOperations> nationalityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nationality');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> onLoanFromTeamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onLoanFromTeamApiId');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> onLoanUntilMatchdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onLoanUntilMatchday');
    });
  }

  QueryBuilder<Player, Personality, QQueryOperations> personalityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personality');
    });
  }

  QueryBuilder<Player, String, QQueryOperations> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'position');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> potentialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'potential');
    });
  }

  QueryBuilder<Player, double, QQueryOperations> salaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'salary');
    });
  }

  QueryBuilder<Player, List<int>, QQueryOperations> statsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stats');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> suspendedMatchesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'suspendedMatches');
    });
  }

  QueryBuilder<Player, int?, QQueryOperations> teamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamApiId');
    });
  }

  QueryBuilder<Player, String, QQueryOperations> teamIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamId');
    });
  }
}
