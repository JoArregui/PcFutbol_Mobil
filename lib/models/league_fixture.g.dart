// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_fixture.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLeagueFixtureCollection on Isar {
  IsarCollection<LeagueFixture> get leagueFixtures => this.collection();
}

const LeagueFixtureSchema = CollectionSchema(
  name: r'LeagueFixture',
  id: 4171287206812447418,
  properties: {
    r'awayGoals': PropertySchema(
      id: 0,
      name: r'awayGoals',
      type: IsarType.long,
    ),
    r'awayTeamApiId': PropertySchema(
      id: 1,
      name: r'awayTeamApiId',
      type: IsarType.long,
    ),
    r'competition': PropertySchema(
      id: 2,
      name: r'competition',
      type: IsarType.string,
    ),
    r'cupRound': PropertySchema(
      id: 3,
      name: r'cupRound',
      type: IsarType.long,
    ),
    r'homeGoals': PropertySchema(
      id: 4,
      name: r'homeGoals',
      type: IsarType.long,
    ),
    r'homeTeamApiId': PropertySchema(
      id: 5,
      name: r'homeTeamApiId',
      type: IsarType.long,
    ),
    r'matchday': PropertySchema(
      id: 6,
      name: r'matchday',
      type: IsarType.long,
    ),
    r'played': PropertySchema(
      id: 7,
      name: r'played',
      type: IsarType.bool,
    )
  },
  estimateSize: _leagueFixtureEstimateSize,
  serialize: _leagueFixtureSerialize,
  deserialize: _leagueFixtureDeserialize,
  deserializeProp: _leagueFixtureDeserializeProp,
  idName: r'id',
  indexes: {
    r'matchday': IndexSchema(
      id: 5613208736838221458,
      name: r'matchday',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'matchday',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _leagueFixtureGetId,
  getLinks: _leagueFixtureGetLinks,
  attach: _leagueFixtureAttach,
  version: '3.1.0+1',
);

int _leagueFixtureEstimateSize(
  LeagueFixture object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.competition.length * 3;
  return bytesCount;
}

void _leagueFixtureSerialize(
  LeagueFixture object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.awayGoals);
  writer.writeLong(offsets[1], object.awayTeamApiId);
  writer.writeString(offsets[2], object.competition);
  writer.writeLong(offsets[3], object.cupRound);
  writer.writeLong(offsets[4], object.homeGoals);
  writer.writeLong(offsets[5], object.homeTeamApiId);
  writer.writeLong(offsets[6], object.matchday);
  writer.writeBool(offsets[7], object.played);
}

LeagueFixture _leagueFixtureDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LeagueFixture();
  object.awayGoals = reader.readLong(offsets[0]);
  object.awayTeamApiId = reader.readLong(offsets[1]);
  object.competition = reader.readString(offsets[2]);
  object.cupRound = reader.readLong(offsets[3]);
  object.homeGoals = reader.readLong(offsets[4]);
  object.homeTeamApiId = reader.readLong(offsets[5]);
  object.id = id;
  object.matchday = reader.readLong(offsets[6]);
  object.played = reader.readBool(offsets[7]);
  return object;
}

P _leagueFixtureDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _leagueFixtureGetId(LeagueFixture object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _leagueFixtureGetLinks(LeagueFixture object) {
  return [];
}

void _leagueFixtureAttach(
    IsarCollection<dynamic> col, Id id, LeagueFixture object) {
  object.id = id;
}

extension LeagueFixtureQueryWhereSort
    on QueryBuilder<LeagueFixture, LeagueFixture, QWhere> {
  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhere> anyMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'matchday'),
      );
    });
  }
}

extension LeagueFixtureQueryWhere
    on QueryBuilder<LeagueFixture, LeagueFixture, QWhereClause> {
  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause> idBetween(
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

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause> matchdayEqualTo(
      int matchday) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'matchday',
        value: [matchday],
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause>
      matchdayNotEqualTo(int matchday) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'matchday',
              lower: [],
              upper: [matchday],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'matchday',
              lower: [matchday],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'matchday',
              lower: [matchday],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'matchday',
              lower: [],
              upper: [matchday],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause>
      matchdayGreaterThan(
    int matchday, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'matchday',
        lower: [matchday],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause>
      matchdayLessThan(
    int matchday, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'matchday',
        lower: [],
        upper: [matchday],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterWhereClause> matchdayBetween(
    int lowerMatchday,
    int upperMatchday, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'matchday',
        lower: [lowerMatchday],
        includeLower: includeLower,
        upper: [upperMatchday],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LeagueFixtureQueryFilter
    on QueryBuilder<LeagueFixture, LeagueFixture, QFilterCondition> {
  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      awayGoalsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'awayGoals',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      awayGoalsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'awayGoals',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      awayGoalsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'awayGoals',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      awayGoalsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'awayGoals',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      awayTeamApiIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'awayTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      awayTeamApiIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'awayTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      awayTeamApiIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'awayTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      awayTeamApiIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'awayTeamApiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'competition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'competition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'competition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'competition',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'competition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'competition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'competition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'competition',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'competition',
        value: '',
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      competitionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'competition',
        value: '',
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      cupRoundEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cupRound',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      cupRoundGreaterThan(
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

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      cupRoundLessThan(
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

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      cupRoundBetween(
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

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      homeGoalsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'homeGoals',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      homeGoalsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'homeGoals',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      homeGoalsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'homeGoals',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      homeGoalsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'homeGoals',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      homeTeamApiIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'homeTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      homeTeamApiIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'homeTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      homeTeamApiIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'homeTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      homeTeamApiIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'homeTeamApiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
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

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      matchdayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchday',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      matchdayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchday',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      matchdayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchday',
        value: value,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      matchdayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterFilterCondition>
      playedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'played',
        value: value,
      ));
    });
  }
}

extension LeagueFixtureQueryObject
    on QueryBuilder<LeagueFixture, LeagueFixture, QFilterCondition> {}

extension LeagueFixtureQueryLinks
    on QueryBuilder<LeagueFixture, LeagueFixture, QFilterCondition> {}

extension LeagueFixtureQuerySortBy
    on QueryBuilder<LeagueFixture, LeagueFixture, QSortBy> {
  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> sortByAwayGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayGoals', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      sortByAwayGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayGoals', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      sortByAwayTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      sortByAwayTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> sortByCompetition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'competition', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      sortByCompetitionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'competition', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> sortByCupRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cupRound', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      sortByCupRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cupRound', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> sortByHomeGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeGoals', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      sortByHomeGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeGoals', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      sortByHomeTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      sortByHomeTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> sortByMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchday', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      sortByMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchday', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> sortByPlayed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> sortByPlayedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.desc);
    });
  }
}

extension LeagueFixtureQuerySortThenBy
    on QueryBuilder<LeagueFixture, LeagueFixture, QSortThenBy> {
  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> thenByAwayGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayGoals', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      thenByAwayGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayGoals', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      thenByAwayTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      thenByAwayTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> thenByCompetition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'competition', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      thenByCompetitionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'competition', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> thenByCupRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cupRound', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      thenByCupRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cupRound', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> thenByHomeGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeGoals', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      thenByHomeGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeGoals', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      thenByHomeTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      thenByHomeTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> thenByMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchday', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy>
      thenByMatchdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchday', Sort.desc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> thenByPlayed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.asc);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QAfterSortBy> thenByPlayedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.desc);
    });
  }
}

extension LeagueFixtureQueryWhereDistinct
    on QueryBuilder<LeagueFixture, LeagueFixture, QDistinct> {
  QueryBuilder<LeagueFixture, LeagueFixture, QDistinct> distinctByAwayGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'awayGoals');
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QDistinct>
      distinctByAwayTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'awayTeamApiId');
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QDistinct> distinctByCompetition(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'competition', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QDistinct> distinctByCupRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cupRound');
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QDistinct> distinctByHomeGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'homeGoals');
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QDistinct>
      distinctByHomeTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'homeTeamApiId');
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QDistinct> distinctByMatchday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchday');
    });
  }

  QueryBuilder<LeagueFixture, LeagueFixture, QDistinct> distinctByPlayed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'played');
    });
  }
}

extension LeagueFixtureQueryProperty
    on QueryBuilder<LeagueFixture, LeagueFixture, QQueryProperty> {
  QueryBuilder<LeagueFixture, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LeagueFixture, int, QQueryOperations> awayGoalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'awayGoals');
    });
  }

  QueryBuilder<LeagueFixture, int, QQueryOperations> awayTeamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'awayTeamApiId');
    });
  }

  QueryBuilder<LeagueFixture, String, QQueryOperations> competitionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'competition');
    });
  }

  QueryBuilder<LeagueFixture, int, QQueryOperations> cupRoundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cupRound');
    });
  }

  QueryBuilder<LeagueFixture, int, QQueryOperations> homeGoalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'homeGoals');
    });
  }

  QueryBuilder<LeagueFixture, int, QQueryOperations> homeTeamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'homeTeamApiId');
    });
  }

  QueryBuilder<LeagueFixture, int, QQueryOperations> matchdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchday');
    });
  }

  QueryBuilder<LeagueFixture, bool, QQueryOperations> playedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'played');
    });
  }
}
