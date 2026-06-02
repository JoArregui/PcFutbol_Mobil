// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_standing.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLeagueStandingCollection on Isar {
  IsarCollection<LeagueStanding> get leagueStandings => this.collection();
}

const LeagueStandingSchema = CollectionSchema(
  name: r'LeagueStanding',
  id: 3002222734794039545,
  properties: {
    r'draws': PropertySchema(
      id: 0,
      name: r'draws',
      type: IsarType.long,
    ),
    r'goalDifference': PropertySchema(
      id: 1,
      name: r'goalDifference',
      type: IsarType.long,
    ),
    r'goalsAgainst': PropertySchema(
      id: 2,
      name: r'goalsAgainst',
      type: IsarType.long,
    ),
    r'goalsFor': PropertySchema(
      id: 3,
      name: r'goalsFor',
      type: IsarType.long,
    ),
    r'losses': PropertySchema(
      id: 4,
      name: r'losses',
      type: IsarType.long,
    ),
    r'played': PropertySchema(
      id: 5,
      name: r'played',
      type: IsarType.long,
    ),
    r'points': PropertySchema(
      id: 6,
      name: r'points',
      type: IsarType.long,
    ),
    r'teamApiId': PropertySchema(
      id: 7,
      name: r'teamApiId',
      type: IsarType.long,
    ),
    r'wins': PropertySchema(
      id: 8,
      name: r'wins',
      type: IsarType.long,
    )
  },
  estimateSize: _leagueStandingEstimateSize,
  serialize: _leagueStandingSerialize,
  deserialize: _leagueStandingDeserialize,
  deserializeProp: _leagueStandingDeserializeProp,
  idName: r'id',
  indexes: {
    r'teamApiId': IndexSchema(
      id: -6029187653010580359,
      name: r'teamApiId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'teamApiId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _leagueStandingGetId,
  getLinks: _leagueStandingGetLinks,
  attach: _leagueStandingAttach,
  version: '3.1.0+1',
);

int _leagueStandingEstimateSize(
  LeagueStanding object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _leagueStandingSerialize(
  LeagueStanding object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.draws);
  writer.writeLong(offsets[1], object.goalDifference);
  writer.writeLong(offsets[2], object.goalsAgainst);
  writer.writeLong(offsets[3], object.goalsFor);
  writer.writeLong(offsets[4], object.losses);
  writer.writeLong(offsets[5], object.played);
  writer.writeLong(offsets[6], object.points);
  writer.writeLong(offsets[7], object.teamApiId);
  writer.writeLong(offsets[8], object.wins);
}

LeagueStanding _leagueStandingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LeagueStanding();
  object.draws = reader.readLong(offsets[0]);
  object.goalsAgainst = reader.readLong(offsets[2]);
  object.goalsFor = reader.readLong(offsets[3]);
  object.id = id;
  object.losses = reader.readLong(offsets[4]);
  object.played = reader.readLong(offsets[5]);
  object.points = reader.readLong(offsets[6]);
  object.teamApiId = reader.readLong(offsets[7]);
  object.wins = reader.readLong(offsets[8]);
  return object;
}

P _leagueStandingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
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
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _leagueStandingGetId(LeagueStanding object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _leagueStandingGetLinks(LeagueStanding object) {
  return [];
}

void _leagueStandingAttach(
    IsarCollection<dynamic> col, Id id, LeagueStanding object) {
  object.id = id;
}

extension LeagueStandingByIndex on IsarCollection<LeagueStanding> {
  Future<LeagueStanding?> getByTeamApiId(int teamApiId) {
    return getByIndex(r'teamApiId', [teamApiId]);
  }

  LeagueStanding? getByTeamApiIdSync(int teamApiId) {
    return getByIndexSync(r'teamApiId', [teamApiId]);
  }

  Future<bool> deleteByTeamApiId(int teamApiId) {
    return deleteByIndex(r'teamApiId', [teamApiId]);
  }

  bool deleteByTeamApiIdSync(int teamApiId) {
    return deleteByIndexSync(r'teamApiId', [teamApiId]);
  }

  Future<List<LeagueStanding?>> getAllByTeamApiId(List<int> teamApiIdValues) {
    final values = teamApiIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'teamApiId', values);
  }

  List<LeagueStanding?> getAllByTeamApiIdSync(List<int> teamApiIdValues) {
    final values = teamApiIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'teamApiId', values);
  }

  Future<int> deleteAllByTeamApiId(List<int> teamApiIdValues) {
    final values = teamApiIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'teamApiId', values);
  }

  int deleteAllByTeamApiIdSync(List<int> teamApiIdValues) {
    final values = teamApiIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'teamApiId', values);
  }

  Future<Id> putByTeamApiId(LeagueStanding object) {
    return putByIndex(r'teamApiId', object);
  }

  Id putByTeamApiIdSync(LeagueStanding object, {bool saveLinks = true}) {
    return putByIndexSync(r'teamApiId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTeamApiId(List<LeagueStanding> objects) {
    return putAllByIndex(r'teamApiId', objects);
  }

  List<Id> putAllByTeamApiIdSync(List<LeagueStanding> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'teamApiId', objects, saveLinks: saveLinks);
  }
}

extension LeagueStandingQueryWhereSort
    on QueryBuilder<LeagueStanding, LeagueStanding, QWhere> {
  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhere> anyTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'teamApiId'),
      );
    });
  }
}

extension LeagueStandingQueryWhere
    on QueryBuilder<LeagueStanding, LeagueStanding, QWhereClause> {
  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause> idBetween(
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause>
      teamApiIdEqualTo(int teamApiId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'teamApiId',
        value: [teamApiId],
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause>
      teamApiIdNotEqualTo(int teamApiId) {
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause>
      teamApiIdGreaterThan(
    int teamApiId, {
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause>
      teamApiIdLessThan(
    int teamApiId, {
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterWhereClause>
      teamApiIdBetween(
    int lowerTeamApiId,
    int upperTeamApiId, {
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
}

extension LeagueStandingQueryFilter
    on QueryBuilder<LeagueStanding, LeagueStanding, QFilterCondition> {
  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      drawsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'draws',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      drawsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'draws',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      drawsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'draws',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      drawsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'draws',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalDifferenceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalDifference',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalDifferenceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalDifference',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalDifferenceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalDifference',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalDifferenceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalDifference',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalsAgainstEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalsAgainst',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalsAgainstGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalsAgainst',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalsAgainstLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalsAgainst',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalsAgainstBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalsAgainst',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalsForEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalsFor',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalsForGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalsFor',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalsForLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalsFor',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      goalsForBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalsFor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      lossesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'losses',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      lossesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'losses',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      lossesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'losses',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      lossesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'losses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      playedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'played',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      playedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'played',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      playedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'played',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      playedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'played',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      pointsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      pointsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      pointsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'points',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      pointsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'points',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      teamApiIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      teamApiIdGreaterThan(
    int value, {
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      teamApiIdLessThan(
    int value, {
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      teamApiIdBetween(
    int lower,
    int upper, {
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

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      winsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wins',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      winsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wins',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      winsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wins',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterFilterCondition>
      winsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wins',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LeagueStandingQueryObject
    on QueryBuilder<LeagueStanding, LeagueStanding, QFilterCondition> {}

extension LeagueStandingQueryLinks
    on QueryBuilder<LeagueStanding, LeagueStanding, QFilterCondition> {}

extension LeagueStandingQuerySortBy
    on QueryBuilder<LeagueStanding, LeagueStanding, QSortBy> {
  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> sortByDraws() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draws', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> sortByDrawsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draws', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      sortByGoalDifference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalDifference', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      sortByGoalDifferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalDifference', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      sortByGoalsAgainst() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsAgainst', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      sortByGoalsAgainstDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsAgainst', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> sortByGoalsFor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsFor', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      sortByGoalsForDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsFor', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> sortByLosses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'losses', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      sortByLossesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'losses', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> sortByPlayed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      sortByPlayedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> sortByPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'points', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      sortByPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'points', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> sortByTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamApiId', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      sortByTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamApiId', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> sortByWins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wins', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> sortByWinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wins', Sort.desc);
    });
  }
}

extension LeagueStandingQuerySortThenBy
    on QueryBuilder<LeagueStanding, LeagueStanding, QSortThenBy> {
  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByDraws() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draws', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByDrawsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draws', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      thenByGoalDifference() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalDifference', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      thenByGoalDifferenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalDifference', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      thenByGoalsAgainst() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsAgainst', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      thenByGoalsAgainstDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsAgainst', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByGoalsFor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsFor', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      thenByGoalsForDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsFor', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByLosses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'losses', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      thenByLossesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'losses', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByPlayed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      thenByPlayedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'points', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      thenByPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'points', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamApiId', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy>
      thenByTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamApiId', Sort.desc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByWins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wins', Sort.asc);
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QAfterSortBy> thenByWinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wins', Sort.desc);
    });
  }
}

extension LeagueStandingQueryWhereDistinct
    on QueryBuilder<LeagueStanding, LeagueStanding, QDistinct> {
  QueryBuilder<LeagueStanding, LeagueStanding, QDistinct> distinctByDraws() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'draws');
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QDistinct>
      distinctByGoalDifference() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalDifference');
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QDistinct>
      distinctByGoalsAgainst() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalsAgainst');
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QDistinct> distinctByGoalsFor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalsFor');
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QDistinct> distinctByLosses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'losses');
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QDistinct> distinctByPlayed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'played');
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QDistinct> distinctByPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'points');
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QDistinct>
      distinctByTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamApiId');
    });
  }

  QueryBuilder<LeagueStanding, LeagueStanding, QDistinct> distinctByWins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wins');
    });
  }
}

extension LeagueStandingQueryProperty
    on QueryBuilder<LeagueStanding, LeagueStanding, QQueryProperty> {
  QueryBuilder<LeagueStanding, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LeagueStanding, int, QQueryOperations> drawsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'draws');
    });
  }

  QueryBuilder<LeagueStanding, int, QQueryOperations> goalDifferenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalDifference');
    });
  }

  QueryBuilder<LeagueStanding, int, QQueryOperations> goalsAgainstProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalsAgainst');
    });
  }

  QueryBuilder<LeagueStanding, int, QQueryOperations> goalsForProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalsFor');
    });
  }

  QueryBuilder<LeagueStanding, int, QQueryOperations> lossesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'losses');
    });
  }

  QueryBuilder<LeagueStanding, int, QQueryOperations> playedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'played');
    });
  }

  QueryBuilder<LeagueStanding, int, QQueryOperations> pointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'points');
    });
  }

  QueryBuilder<LeagueStanding, int, QQueryOperations> teamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamApiId');
    });
  }

  QueryBuilder<LeagueStanding, int, QQueryOperations> winsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wins');
    });
  }
}
