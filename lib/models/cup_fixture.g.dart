// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cup_fixture.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCupFixtureCollection on Isar {
  IsarCollection<CupFixture> get cupFixtures => this.collection();
}

const CupFixtureSchema = CollectionSchema(
  name: r'CupFixture',
  id: -5414264175365810197,
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
    r'homeGoals': PropertySchema(
      id: 2,
      name: r'homeGoals',
      type: IsarType.long,
    ),
    r'homeTeamApiId': PropertySchema(
      id: 3,
      name: r'homeTeamApiId',
      type: IsarType.long,
    ),
    r'played': PropertySchema(
      id: 4,
      name: r'played',
      type: IsarType.bool,
    ),
    r'round': PropertySchema(
      id: 5,
      name: r'round',
      type: IsarType.long,
    )
  },
  estimateSize: _cupFixtureEstimateSize,
  serialize: _cupFixtureSerialize,
  deserialize: _cupFixtureDeserialize,
  deserializeProp: _cupFixtureDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _cupFixtureGetId,
  getLinks: _cupFixtureGetLinks,
  attach: _cupFixtureAttach,
  version: '3.1.0+1',
);

int _cupFixtureEstimateSize(
  CupFixture object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _cupFixtureSerialize(
  CupFixture object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.awayGoals);
  writer.writeLong(offsets[1], object.awayTeamApiId);
  writer.writeLong(offsets[2], object.homeGoals);
  writer.writeLong(offsets[3], object.homeTeamApiId);
  writer.writeBool(offsets[4], object.played);
  writer.writeLong(offsets[5], object.round);
}

CupFixture _cupFixtureDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CupFixture();
  object.awayGoals = reader.readLong(offsets[0]);
  object.awayTeamApiId = reader.readLong(offsets[1]);
  object.homeGoals = reader.readLong(offsets[2]);
  object.homeTeamApiId = reader.readLong(offsets[3]);
  object.id = id;
  object.played = reader.readBool(offsets[4]);
  object.round = reader.readLong(offsets[5]);
  return object;
}

P _cupFixtureDeserializeProp<P>(
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
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cupFixtureGetId(CupFixture object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cupFixtureGetLinks(CupFixture object) {
  return [];
}

void _cupFixtureAttach(IsarCollection<dynamic> col, Id id, CupFixture object) {
  object.id = id;
}

extension CupFixtureQueryWhereSort
    on QueryBuilder<CupFixture, CupFixture, QWhere> {
  QueryBuilder<CupFixture, CupFixture, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CupFixtureQueryWhere
    on QueryBuilder<CupFixture, CupFixture, QWhereClause> {
  QueryBuilder<CupFixture, CupFixture, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<CupFixture, CupFixture, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterWhereClause> idBetween(
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

extension CupFixtureQueryFilter
    on QueryBuilder<CupFixture, CupFixture, QFilterCondition> {
  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> awayGoalsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'awayGoals',
        value: value,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> awayGoalsLessThan(
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> awayGoalsBetween(
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
      awayTeamApiIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'awayTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> homeGoalsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'homeGoals',
        value: value,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> homeGoalsLessThan(
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> homeGoalsBetween(
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
      homeTeamApiIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'homeTeamApiId',
        value: value,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition>
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> playedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'played',
        value: value,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> roundEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'round',
        value: value,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> roundGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'round',
        value: value,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> roundLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'round',
        value: value,
      ));
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterFilterCondition> roundBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'round',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CupFixtureQueryObject
    on QueryBuilder<CupFixture, CupFixture, QFilterCondition> {}

extension CupFixtureQueryLinks
    on QueryBuilder<CupFixture, CupFixture, QFilterCondition> {}

extension CupFixtureQuerySortBy
    on QueryBuilder<CupFixture, CupFixture, QSortBy> {
  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByAwayGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayGoals', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByAwayGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayGoals', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByAwayTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByAwayTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByHomeGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeGoals', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByHomeGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeGoals', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByHomeTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByHomeTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByPlayed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByPlayedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'round', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> sortByRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'round', Sort.desc);
    });
  }
}

extension CupFixtureQuerySortThenBy
    on QueryBuilder<CupFixture, CupFixture, QSortThenBy> {
  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByAwayGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayGoals', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByAwayGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayGoals', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByAwayTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByAwayTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByHomeGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeGoals', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByHomeGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeGoals', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByHomeTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeTeamApiId', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByHomeTeamApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeTeamApiId', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByPlayed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByPlayedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'played', Sort.desc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'round', Sort.asc);
    });
  }

  QueryBuilder<CupFixture, CupFixture, QAfterSortBy> thenByRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'round', Sort.desc);
    });
  }
}

extension CupFixtureQueryWhereDistinct
    on QueryBuilder<CupFixture, CupFixture, QDistinct> {
  QueryBuilder<CupFixture, CupFixture, QDistinct> distinctByAwayGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'awayGoals');
    });
  }

  QueryBuilder<CupFixture, CupFixture, QDistinct> distinctByAwayTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'awayTeamApiId');
    });
  }

  QueryBuilder<CupFixture, CupFixture, QDistinct> distinctByHomeGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'homeGoals');
    });
  }

  QueryBuilder<CupFixture, CupFixture, QDistinct> distinctByHomeTeamApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'homeTeamApiId');
    });
  }

  QueryBuilder<CupFixture, CupFixture, QDistinct> distinctByPlayed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'played');
    });
  }

  QueryBuilder<CupFixture, CupFixture, QDistinct> distinctByRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'round');
    });
  }
}

extension CupFixtureQueryProperty
    on QueryBuilder<CupFixture, CupFixture, QQueryProperty> {
  QueryBuilder<CupFixture, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CupFixture, int, QQueryOperations> awayGoalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'awayGoals');
    });
  }

  QueryBuilder<CupFixture, int, QQueryOperations> awayTeamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'awayTeamApiId');
    });
  }

  QueryBuilder<CupFixture, int, QQueryOperations> homeGoalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'homeGoals');
    });
  }

  QueryBuilder<CupFixture, int, QQueryOperations> homeTeamApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'homeTeamApiId');
    });
  }

  QueryBuilder<CupFixture, bool, QQueryOperations> playedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'played');
    });
  }

  QueryBuilder<CupFixture, int, QQueryOperations> roundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'round');
    });
  }
}
